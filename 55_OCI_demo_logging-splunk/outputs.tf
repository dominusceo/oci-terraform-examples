## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}
output "Master_server_public_IP" {
  value = oci_core_instance.master.public_ip
}
output "Master_server_private_IP" {
  value = oci_core_instance.master.private_ip
}
output "Master_server_URL" {
  value = "http://${oci_core_instance.master.public_ip}:8000"
}
output "Indexer_server_public_IPs" {
  value = oci_core_instance.indexer.*.public_ip
}
output "Indexer_server_private_IPs" {
  value = oci_core_instance.indexer.*.private_ip
}
output "Search_deployer_server_public_IP" {
  value = oci_core_instance.search-deployer.public_ip
}
output "Search_deployer_server_private_IP" {
  value = oci_core_instance.search-deployer.private_ip
}
output "Search_head_server_public_IPs" {
  value = oci_core_instance.search-head.*.public_ip
}

output "Search_head_server_private_IPs" {
  value = oci_core_instance.search-head.*.private_ip
}
output "bucket_name" {
  value = oci_objectstorage_bucket.audit-events-bucket.name
}

output "bucket_id" {
  value = oci_objectstorage_bucket.audit-events-bucket.bucket_id
}