# Discover Consul settings
module "consul" {
  source       = "github.com/nubisproject/nubis-terraform//consul?ref=v2.1.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
}

# Configure our Consul provider, module can't do it for us
provider "consul" {
  address    = "${module.consul.address}"
  scheme     = "${module.consul.scheme}"
  datacenter = "${module.consul.datacenter}"
}

# Publish our outputs into Consul for our application to consume
resource "consul_keys" "config" {
  key {
    path   = "${module.consul.config_prefix}/ssh/public-key"
    value  = "${tls_private_key.vertical.public_key_openssh}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/ssh/secret-key"
    value  = "${tls_private_key.vertical.private_key_pem}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/clients/security-group-id"
    value  = "${aws_security_group.vertical_clients.id}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/S3/Bucket/RPMS"
    value  = "${module.rpms.name}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/S3/Bucket/Backup"
    value  = "${module.backup.name}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/AutoScaling/SNS"
    value  = "${aws_sns_topic.graceful_termination.arn}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/AutoScaling/LifeCycleHookName"
    value  = "${var.service_name}-${var.arena}-${var.environment}-shutdown"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/AutoScaling/SQS"
    value  = "${aws_sqs_queue.graceful_termination.id}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/AdminPassword"
    value  = "${random_id.admin_password.b64_url}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/SSL/Certificate"
    value  = "${tls_self_signed_cert.vertical.cert_pem}"
    delete = true
  }

  key {
    path   = "${module.consul.config_prefix}/SSL/Key"
    value  = "${tls_private_key.vertical_ssl.private_key_pem}"
    delete = true
  }

}
