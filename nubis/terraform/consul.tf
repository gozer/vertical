# Discover Consul settings
module "consul" {
  source       = "github.com/nubisproject/nubis-terraform//consul?ref=v2.0.1"
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
}
