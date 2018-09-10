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

    # Vu Doan at home
    "76.102.98.122/32",
  ]
}
