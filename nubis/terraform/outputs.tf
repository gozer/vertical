output "vsql_address" {
  value = "${module.dns_vsql.fqdn}"
}

output "vsql_address_public" {
  value = "${module.dns_vsql_public.fqdn}"
}
