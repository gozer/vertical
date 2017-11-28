module "worker" {
  source       = "github.com/nubisproject/nubis-terraform//worker?ref=v2.0.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "database"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer.name}"

  min_instances = 3

  health_check_type = "EC2"
  wait_for_capacity_timeout = "30m"
  health_check_grace_period = "1200"

  instance_type     = "m4.4xlarge"
  root_storage_size = "128"

  security_group        = "${aws_security_group.vertical.id}"
  security_group_custom = true
}

module "load_balancer" {
  source       = "github.com/nubisproject/nubis-terraform//load_balancer?ref=v2.0.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"

  backend_port_http  = "5450"
  backend_port_https = "5450"

  backend_protocol = "https"

  health_check_target = "TCP:5433"
}

module "dns" {
  source       = "github.com/nubisproject/nubis-terraform//dns?ref=v2.0.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  target       = "${module.load_balancer.address}"
}

module "clips" {
  source       = "github.com/nubisproject/nubis-terraform//bucket?ref=v2.0.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "rpms"
  role         = "${module.worker.role}"
}

provider "aws" {
  region = "${var.region}"
}

module "info" {
  source      = "github.com/nubisproject/nubis-terraform//info?ref=v2.0.1"
  region      = "${var.region}"
  environment = "${var.environment}"
  account     = "${var.account}"
}

resource "tls_private_key" "vertical" {
  algorithm = "RSA"
}

# This null resource is responsible for publishing platform secrets to KMS
resource "null_resource" "ssh" {
  # Important to list here every variable that affects what needs to be put into KMS
  triggers {
    region       = "${var.region}"
    arena        = "${var.arena}"
    service_name = "${var.service_name}"
    context      = "-E region:${var.region} -E arena:${var.arena} -E service:${var.service_name}"
    unicreds     = "unicreds -r ${var.region} put  vertical/${var.arena}/${var.environment}"
    unicreds_rm  = "unicreds -r ${var.region} delete  vertical/${var.arena}/${var.environment}"
  }

  # Consul Internal UI SSL Certificate
  provisioner "local-exec" {
    command = "${self.triggers.unicreds}/ssh/public-key ${self.triggers.context} -- \"${tls_private_key.vertical.public_key_openssh}\""
  }

  provisioner "local-exec" {
    command = "${self.triggers.unicreds}/ssh/secret-key ${self.triggers.context} -- \"${tls_private_key.vertical.private_key_pem}\""
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${self.triggers.unicreds_rm}/ssh/public-key"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${self.triggers.unicreds_rm}/ssh/secret-key"
  }
}

# And a special role to be able to talk to AWS a little
resource "aws_iam_role_policy" "vertical" {
  name   = "vertical-${var.region}-${var.arena}-${var.environment}"
  role   = "${module.worker.role}"
  policy = "${data.aws_iam_policy_document.vertical.json}"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "vertical" {
  statement {
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeAddresses",
      "autoscaling:DescribeAutoScalingInstances",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/credential-store",
    ]
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
      "${module.load_balancer.source_security_group_id}",
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
      "${module.load_balancer.source_security_group_id}",
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
      "${module.load_balancer.source_security_group_id}",
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
