variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "authorized_ips_list" {}
variable "ssh_public_key_file_websrv" {}
variable "ssh_private_key_file_websrv" {}
variable "ssh_public_key_file_bastion" {}
variable "ssh_private_key_file_bastion" {}
#variable "lb_reserved_public_ip_id" {}
variable "dns_hostname" {}
variable "use_cert_cs" {}
variable "oci_cs_cert_id" {}
variable "file_lb_cert" {}
variable "file_ca_cert" {}
variable "file_lb_key" {}
variable "cidr_vcn" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "bastion_private_ip" {}
variable "websrv_private_ips" {}
variable "AD_bastion" {}
variable "AD_websrvs" {}
variable "BootStrapFile_websrv" {}
variable "BootStrapFile_bastion" {}
variable "web_page_zip" {}
variable "verify_peer_certificate" {}
variable "allowed_countries" {}
variable "detect_roles" {}
variable "block_roles" {}
variable "lb_res_ip_display_name" {}
variable "zone_name" {}
variable "zone_zone_type" {}
variable "view_display_name" {}
variable "record_items_ttl" {}
variable "rrset_domain" {}
variable "rrset_rtype" {}
variable "record_items_rtype" {}
variable "zone_external_masters_address" {}
variable "zone_external_masters_port" {}