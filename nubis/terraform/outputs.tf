output "console_address" {
  value = "https://${module.dns_console.fqdn}/"
}

output "vsql_address" {
  value = "${module.dns_vsql.fqdn}"
}
