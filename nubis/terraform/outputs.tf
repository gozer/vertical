output "address" {
  value = "https://${module.dns.fqdn}/"
}

output "private_key" {
  value = "${tls_private_key.vertical.private_key_pem}"
}
