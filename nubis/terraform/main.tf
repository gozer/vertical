locals {
  health_check_type         = "ELB"
  
  # Need to tune this to represent the worst-case rebalancing timings
  wait_for_capacity_timeout = "60m"
  health_check_grace_period = "${60*60}"

  instance_type     = "m4.4xlarge"
  root_storage_size = "1024"
  swap_size_meg     = "4096"
}

module "worker_0" {
  source       = "github.com/gozer/nubis-terraform//worker?ref=issue%2F160%2Faz"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer_vsql.name}"

  tags = ["${list(
    map("key", "DependsOn", "value", "nobody", "propagate_at_launch", true),
    map("key", "AzIndex", "value", "0", "propagate_at_launch", true),
  )}"]

  min_instances = 1

  health_check_type         = "${local.health_check_type}"
  wait_for_capacity_timeout = "${local.wait_for_capacity_timeout}"
  health_check_grace_period = "${local.health_check_grace_period}"

  instance_type     = "${local.instance_type}"
  root_storage_size = "${local.root_storage_size}"
  swap_size_meg     = "${local.swap_size_meg}"

  security_group        = "${aws_security_group.vertical.id}"
  security_group_custom = true

  az_index = 0
}

module "worker_1" {
  source       = "github.com/gozer/nubis-terraform//worker?ref=issue%2F160%2Faz"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer_vsql.name}"

  tags = ["${list(
    map("key", "DependsOn", "value", "${module.worker_0.autoscaling_group}", "propagate_at_launch", true),
    map("key", "AzIndex", "value", "1", "propagate_at_launch", true),
  )}"]

  min_instances = 2

  health_check_type         = "${local.health_check_type}"
  wait_for_capacity_timeout = "${local.wait_for_capacity_timeout}"
  health_check_grace_period = "${local.health_check_grace_period}"

  instance_type     = "${local.instance_type}"
  root_storage_size = "${local.root_storage_size}"
  swap_size_meg     = "${local.swap_size_meg}"

  security_group        = "${aws_security_group.vertical.id}"
  security_group_custom = true

  az_index = 1
}

module "worker_2" {
  source       = "github.com/gozer/nubis-terraform//worker?ref=issue%2F160%2Faz"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer_vsql.name}"

  tags = ["${list(
    map("key", "DependsOn", "value", "${module.worker_1.autoscaling_group}", "propagate_at_launch", true),
    map("key", "AzIndex", "value", "2", "propagate_at_launch", true),
  )}"]

  min_instances = 2

  health_check_type         = "${local.health_check_type}"
  wait_for_capacity_timeout = "${local.wait_for_capacity_timeout}"
  health_check_grace_period = "${local.health_check_grace_period}"

  instance_type     = "${local.instance_type}"
  root_storage_size = "${local.root_storage_size}"
  swap_size_meg     = "${local.swap_size_meg}"

  security_group        = "${aws_security_group.vertical.id}"
  security_group_custom = true

  az_index = 2
}

resource "aws_autoscaling_lifecycle_hook" "graceful_shutdown" {
  count                  = "${length(data.aws_availability_zones.available.names)}"
  name                   = "${var.service_name}-${var.arena}-${var.environment}-shutdown"
  autoscaling_group_name = "${element(list(module.worker_0.autoscaling_group,module.worker_1.autoscaling_group,module.worker_2.autoscaling_group), count.index)}"

  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${aws_sqs_queue.graceful_termination.arn}"

  # We heartbeat every 5 minutes, so go for 7
  heartbeat_timeout = "${60 * 7}"

  role_arn = "${aws_iam_role.autoscaling_role.arn}"
}

resource "aws_autoscaling_notification" "vertical" {
  group_names = [
    "${module.worker_0.autoscaling_group}",
    "${module.worker_1.autoscaling_group}",
    "${module.worker_2.autoscaling_group}",
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = "${aws_sns_topic.graceful_termination.arn}"
}

# This one is for vsql
module "load_balancer_vsql" {
  source       = "github.com/nubisproject/nubis-terraform//load_balancer?ref=v2.1.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}-vsql"

  no_ssl_cert        = "1"
  backend_protocol   = "tcp"
  protocol_http      = "tcp"
  protocol_https     = "tcp"
  backend_port_http  = "5433"
  backend_port_https = "5433"

  internal = true

  health_check_target = "TCP:5433"
}

module "dns_vsql" {
  source       = "github.com/nubisproject/nubis-terraform//dns?ref=v2.1.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}-vsql"
  target       = "${module.load_balancer_vsql.address}"
}

module "rpms" {
  source       = "github.com/nubisproject/nubis-terraform//bucket?ref=v2.1.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "rpms"
  role_cnt     = "${length(data.aws_availability_zones.available.names)}"
  role         = "${module.worker_0.role},${module.worker_1.role},${module.worker_2.role}"
}

module "backup" {
  source       = "github.com/nubisproject/nubis-terraform//bucket?ref=v2.1.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "backup"
  role_cnt     = "${length(data.aws_availability_zones.available.names)}"
  role         = "${module.worker_0.role},${module.worker_1.role},${module.worker_2.role}"
}

provider "aws" {
  region = "${var.region}"
}

module "info" {
  source      = "github.com/nubisproject/nubis-terraform//info?ref=v2.1.0"
  region      = "${var.region}"
  environment = "${var.environment}"
  account     = "${var.account}"
}

resource "tls_private_key" "vertical" {
  algorithm = "RSA"
}

# And a special role to be able to talk to AWS a little
resource "aws_iam_role_policy" "vertical" {
  count = "${length(data.aws_availability_zones.available.names)}"
  name  = "vertical-${var.region}-${var.arena}-${var.environment}-${count.index}"
  role  = "${element(list(module.worker_0.role, module.worker_1.role, module.worker_2.role), count.index)}"

  policy = "${data.aws_iam_policy_document.vertical.json}"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "vertical" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeAddresses",
      "ec2:DescribeVolumes",
      "ec2:AssignPrivateIpAddresses",
      "ec2:TerminateInstances",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeAutoScalingGroups",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "autoscaling:CompleteLifecycleAction",
      "autoscaling:RecordLifecycleActionHeartbeat",
    ]

    resources = [
      "${module.worker_0.autoscaling_group_arn}",
      "${module.worker_1.autoscaling_group_arn}",
      "${module.worker_2.autoscaling_group_arn}",
      "arn:aws:autoscaling:${var.region}:${module.info.account_id}:autoScalingGroup:*:autoScalingGroupName/${var.service_name}-${var.environment}-${var.region}-*",
    ]
  }

  statement {
    actions = [
      "sns:Publish",
    ]

    resources = [
      "${aws_sns_topic.graceful_termination.arn}",
    ]
  }

  statement {
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
    ]

    resources = [
      "${aws_sqs_queue.graceful_termination.arn}",
    ]
  }
}

# And a custom vertica security group for our clients to use
resource "aws_security_group" "vertical_clients" {
  name_prefix = "${var.service_name}-${var.arena}-${var.environment}-vertical-clients-"

  vpc_id = "${module.info.vpc_id}"

  tags = {
    Name        = "${var.service_name}-${var.arena}-${var.environment}-vertical-clients"
    Arena       = "${var.arena}"
    Region      = "${var.region}"
    Environment = "${var.environment}"
    Backup      = "true"
    Shutdown    = "never"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      "${module.info.ssh_security_group}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# And a custom vertica security group from the world
resource "aws_security_group" "vertical" {
  name_prefix = "${var.service_name}-${var.arena}-${var.environment}-vertical-"

  vpc_id = "${module.info.vpc_id}"

  tags = {
    Name        = "${var.service_name}-${var.arena}-${var.environment}-vertical"
    Arena       = "${var.arena}"
    Region      = "${var.region}"
    Environment = "${var.environment}"
    Backup      = "true"
    Shutdown    = "never"
  }

  # HP Vertica client (vsql, ODBC, JDBC, etc) port.
  ingress {
    from_port = 5433
    to_port   = 5433
    protocol  = "tcp"
    self      = true

    security_groups = [
      "${module.load_balancer_vsql.source_security_group_id}",
      "${aws_security_group.vertical_clients.id}",
    ]
  }

  # Intra-cluster communication
  ingress {
    from_port = 5434
    to_port   = 5434
    protocol  = "tcp"
    self      = true
  }

  # HP Vertica spread monitoring.
  ingress {
    from_port = 5433
    to_port   = 5433
    protocol  = "udp"
    self      = true
  }

  # MC-to-node and node-to-node (agent)
  ingress {
    from_port = 5444
    to_port   = 5444
    protocol  = "tcp"
    self      = true
  }

  # Port used to connect to MC from a web browser
  ingress {
    from_port = 5450
    to_port   = 5450
    protocol  = "tcp"
    self      = true

    security_groups = [
      "${aws_security_group.vertical_clients.id}",
      "${module.info.sso_security_group}",
    ]
  }

  # Client connections.
  ingress {
    from_port = 4803
    to_port   = 4803
    protocol  = "tcp"
    self      = true
  }

  # Daemon to Daemon connections.
  ingress {
    from_port = 4803
    to_port   = 4804
    protocol  = "udp"
    self      = true
  }

  # Monitor to Daemon connection.
  ingress {
    from_port = 6543
    to_port   = 6543
    protocol  = "udp"
    self      = true
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    self      = true

    security_groups = [
      "${module.info.ssh_security_group}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "available" {}

resource "aws_ebs_volume" "storage" {
  count             = "${length(data.aws_availability_zones.available.names)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  size              = 1024
  type              = "gp2"

  tags {
    Name             = "${var.service_name}-${var.arena}-${var.environment}-storage-${count.index}"
    Project          = "${var.service_name}"
    Arena            = "${var.arena}"
    Region           = "${var.region}"
    Environment      = "${var.environment}"
    Purpose          = "database"
    AvailabilityZone = "${data.aws_availability_zones.available.names[count.index]}"
    AzIndex          = "${count.index}"
  }
}

resource "aws_sns_topic" "graceful_termination" {
  name = "${var.service_name}-${var.arena}-${var.environment}-termination"
}

resource "aws_sqs_queue" "graceful_termination" {
  name = "${var.service_name}-${var.arena}-${var.environment}-termination"

  tags {
    Name        = "${var.service_name}-${var.arena}-${var.environment}-termination"
    Project     = "${var.service_name}"
    Arena       = "${var.arena}"
    Region      = "${var.region}"
    Environment = "${var.environment}"
  }
}

data "aws_iam_policy_document" "autoscaling" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["autoscaling.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "autoscaling_hook" {
  statement {
    actions = [
      "sqs:SendMessage",
      "sqs:GetQueueUrl",
    ]

    resources = [
      "${aws_sqs_queue.graceful_termination.arn}",
    ]
  }
}

resource "aws_iam_role" "autoscaling_role" {
  name               = "${var.service_name}-${var.arena}-${var.environment}-termination"
  assume_role_policy = "${data.aws_iam_policy_document.autoscaling.json}"
}

resource "aws_iam_role_policy" "termination" {
  name   = "${var.service_name}-${var.arena}-${var.environment}-termination"
  role   = "${aws_iam_role.autoscaling_role.id}"
  policy = "${data.aws_iam_policy_document.autoscaling_hook.json}"
}

resource "random_id" "admin_password" {
  byte_length = 16
}
