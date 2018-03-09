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
  default = "nubis_global_admins"
}

variable "nubis_user_groups" {
  default = "team_dbeng"
}
