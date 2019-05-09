variable "account" {
  default = ""
}

variable "region" {
  default = "us-west-2"
}

variable "environment" {
  default = "stage"
}

variable "arena" {
  default = "core"
}

variable "service_name" {
  default = "vertical"
}

variable "ami" {}

variable "nubis_sudo_groups" {
  default = "nubis_global_admins,team_dbeng"
}

variable "nubis_user_groups" {
  default = ""
}

variable "vsql_whitelist" {
  type = "list"

  default = [
    # XXX: The account itself
    "34.216.154.14/32",
    "52.24.122.144/32",

    # MDC VPNs
    "63.245.208.132/32",

    "63.245.208.133/32",
    "63.245.210.132/32",
    "63.245.210.133/32",

    #SCL3
    "63.245.214.169/32",

    #hala.data.mozaws.net
    "35.155.141.29/32",

    #sql.telemetry.mozilla.com
    "52.36.66.76/32",

    # STMO in GCP
    "35.203.170.234/32",
    "104.196.252.116/32",

    #John Miller's home
    "192.76.2.90/32",
    "69.249.207.121/32",
    "108.52.99.186/32",
    "74.94.16.116/32",

    #Gozer's Home
    "96.22.236.163/32",
    "76.67.140.225/32",
    "67.68.121.229/32",
  ]
}
