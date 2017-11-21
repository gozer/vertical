module "worker" {
  source                    = "github.com/nubisproject/nubis-terraform//worker?ref=v2.0.1"
  region                    = "${var.region}"
  environment               = "${var.environment}"
  account                   = "${var.account}"
  service_name              = "${var.service_name}"
  purpose                   = "database"
  ami                       = "${var.ami}"
  instance_type             = "m4.4xlarge"
  root_storage_size         = "128"
}
