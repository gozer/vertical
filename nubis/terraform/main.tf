locals {
  health_check_type = "ELB"

  # Need to tune this to represent the worst-case rebalancing timings
  wait_for_capacity_timeout = "60m"
  health_check_grace_period = "${60*60}"

  instance_type     = "m4.4xlarge"
  root_storage_size = "64"
  root_storage_type = "gp2"
  data_storage_size = "1024"
  data_storage_type = "gp2"

  storage_encrypted_at_rest = true

  swap_size_meg = "4096"

  nubis_sudo_groups = "${var.nubis_sudo_groups}"
  nubis_user_groups = "${var.nubis_user_groups}"
}

module "worker_0" {
  source       = "github.com/nubisproject/nubis-terraform//worker?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer_vsql.name},${module.load_balancer_vsql_public.name}"

  nubis_sudo_groups = "${local.nubis_sudo_groups}"
  nubis_user_groups = "${local.nubis_user_groups}"

  tags = ["${list(
    map("key", "DependsOn", "value", "nobody", "propagate_at_launch", true),
    map("key", "AzIndex", "value", "0", "propagate_at_launch", true),
  )}"]

  min_instances = 1

  health_check_type         = "${local.health_check_type}"
  wait_for_capacity_timeout = "${local.wait_for_capacity_timeout}"
  health_check_grace_period = "${local.health_check_grace_period}"

  instance_type = "${local.instance_type}"

  root_storage_size = "${local.root_storage_size}"
  root_storage_type = "${local.root_storage_type}"
  data_storage_size = "${local.data_storage_size}"
  data_storage_type = "${local.data_storage_type}"

  storage_encrypted_at_rest = "${local.storage_encrypted_at_rest}"

  swap_size_meg = "${local.swap_size_meg}"

  security_group        = "${aws_security_group.vertical.id}"
  security_group_custom = true

  az_index = 0
}

module "worker_1" {
  source       = "github.com/nubisproject/nubis-terraform//worker?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer_vsql.name},${module.load_balancer_vsql_public.name}"

  nubis_sudo_groups = "${local.nubis_sudo_groups}"
  nubis_user_groups = "${local.nubis_user_groups}"

  tags = ["${list(
    map("key", "DependsOn", "value", "${module.worker_0.autoscaling_group}", "propagate_at_launch", true),
    map("key", "AzIndex", "value", "1", "propagate_at_launch", true),
  )}"]

  min_instances = 2

  health_check_type         = "${local.health_check_type}"
  wait_for_capacity_timeout = "${local.wait_for_capacity_timeout}"
  health_check_grace_period = "${local.health_check_grace_period}"

  instance_type = "${local.instance_type}"

  root_storage_size = "${local.root_storage_size}"
  root_storage_type = "${local.root_storage_type}"
  data_storage_size = "${local.data_storage_size}"
  data_storage_type = "${local.data_storage_type}"

  storage_encrypted_at_rest = "${local.storage_encrypted_at_rest}"

  swap_size_meg = "${local.swap_size_meg}"

  security_group        = "${aws_security_group.vertical.id}"
  security_group_custom = true

  az_index = 1
}

module "worker_2" {
  source       = "github.com/nubisproject/nubis-terraform//worker?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer_vsql.name},${module.load_balancer_vsql_public.name}"

  nubis_sudo_groups = "${local.nubis_sudo_groups}"
  nubis_user_groups = "${local.nubis_user_groups}"

  tags = ["${list(
    map("key", "DependsOn", "value", "${module.worker_1.autoscaling_group}", "propagate_at_launch", true),
    map("key", "AzIndex", "value", "2", "propagate_at_launch", true),
  )}"]

  min_instances = 2

  health_check_type         = "${local.health_check_type}"
  wait_for_capacity_timeout = "${local.wait_for_capacity_timeout}"
  health_check_grace_period = "${local.health_check_grace_period}"

  instance_type = "${local.instance_type}"

  root_storage_size = "${local.root_storage_size}"
  root_storage_type = "${local.root_storage_type}"
  data_storage_size = "${local.data_storage_size}"
  data_storage_type = "${local.data_storage_type}"

  storage_encrypted_at_rest = "${local.storage_encrypted_at_rest}"

  swap_size_meg = "${local.swap_size_meg}"

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
  source       = "github.com/nubisproject/nubis-terraform//load_balancer?ref=v2.3.1"
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

# This one is for vsql
module "load_balancer_vsql_public" {
  #XXX: Will be in Nubis v2.3.1-next
  source       = "github.com/gozer/nubis-terraform//load_balancer?ref=issue%2F251%2Fwhitelisting"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}-vsql-public"

  no_ssl_cert        = "1"
  backend_protocol   = "tcp"
  protocol_http      = "tcp"
  protocol_https     = "tcp"
  backend_port_http  = "5433"
  port_http          = "5433"
  backend_port_https = "5433"

  whitelist_cidrs = "${var.vsql_whitelist}"

  internal = false

  health_check_target = "TCP:5433"
}

module "dns_vsql_public" {
  source       = "github.com/nubisproject/nubis-terraform//dns?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}-public"
  target       = "${module.load_balancer_vsql_public.address}"
  prefix       = "vsql"
}

module "dns_vsql" {
  source       = "github.com/nubisproject/nubis-terraform//dns?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}-vsql"
  target       = "${module.load_balancer_vsql.address}"
}

module "rpms" {
  source       = "github.com/nubisproject/nubis-terraform//bucket?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "rpms"
  role_cnt     = "${length(data.aws_availability_zones.available.names)}"
  role         = "${module.worker_0.role},${module.worker_1.role},${module.worker_2.role}"
}

module "backup" {
  source                    = "github.com/nubisproject/nubis-terraform//bucket?ref=v2.3.1"
  region                    = "${var.region}"
  environment               = "${var.environment}"
  account                   = "${var.account}"
  service_name              = "${var.service_name}"
  purpose                   = "backup"
  role_cnt                  = "${length(data.aws_availability_zones.available.names)}"
  role                      = "${module.worker_0.role},${module.worker_1.role},${module.worker_2.role}"
  storage_encrypted_at_rest = false
}

provider "aws" {
  region = "${var.region}"
}

module "info" {
  source      = "github.com/nubisproject/nubis-terraform//info?ref=v2.3.1"
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
  name  = "vertical-autoscaling"
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
      "autoscaling:TerminateInstanceInAutoScalingGroup",
    ]

    resources = [
      "arn:aws:autoscaling:${var.region}:${module.info.account_id}:autoScalingGroup:*:autoScalingGroupName/${var.service_name}-${var.environment}-${var.region}-*",
    ]
  }

  statement {
    sid = "termination"

    actions = [
      "ec2:TerminateInstances",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Project"

      values = [
        "${var.service_name}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Arena"

      values = [
        "${var.arena}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Region"

      values = [
        "${var.region}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Environment"

      values = [
        "${var.environment}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Purpose"

      values = [
        "database",
      ]
    }
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

    cidr_blocks = ["${formatlist("%s/32",flatten(data.aws_network_interface.public.*.private_ips))}"]

    security_groups = [
      "${module.load_balancer_vsql.source_security_group_id}",
      "${module.load_balancer_vsql_public.source_security_group_id}",
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

resource "tls_private_key" "vertical_ssl" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "vertical" {
  key_algorithm   = "${tls_private_key.vertical_ssl.algorithm}"
  private_key_pem = "${tls_private_key.vertical_ssl.private_key_pem}"

  # Certificate expires after one year
  validity_period_hours = 8760

  # Generate a new certificate if Terraform is run within three
  # hours of the certificate's expiration time. ( 120 days )
  early_renewal_hours = 2880

  is_ca_certificate = true

  # Reasonable set of uses for a server SSL certificate.
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
    "server_auth",
    "client_auth",
  ]

  subject {
    common_name  = "${var.environment}.${var.service_name}.service.consul"
    organization = "Mozilla Nubis"
  }
}

resource "aws_lb" "public" {
  name                             = "${var.service_name}-vsqlnet-public-${var.environment}"
  internal                         = false
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true

  subnets = ["${split(",",module.info.public_subnets)}"]

  tags = {
    Name        = "${var.service_name}-vsqlnet-public-${var.environment}"
    Region      = "${var.region}"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "public" {
  name     = "${var.service_name}-vsqlnet-public-${var.environment}"
  port     = 5433
  protocol = "TCP"
  vpc_id   = "${module.info.vpc_id}"

  tags = {
    Name        = "${var.service_name}-vsqlnet-public-${var.environment}"
    Region      = "${var.region}"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_listener" "public" {
  load_balancer_arn = "${aws_lb.public.arn}"
  port              = "5433"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.public.arn}"
  }
}

data "aws_network_interface" "public" {
  count = "${length(split(",",module.info.public_subnets))}"

  filter = {
    name   = "description"
    values = ["ELB ${aws_lb.public.arn_suffix}"]
  }

  filter = {
    name   = "subnet-id"
    values = ["${element(split(",",module.info.public_subnets), count.index)}"]
  }
}

module "dns_vsqlnet_public" {
  source       = "github.com/nubisproject/nubis-terraform//dns?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}-vsqlnet"
  target       = "${aws_lb.public.dns_name}"
  prefix       = "vsqlnet"
}
