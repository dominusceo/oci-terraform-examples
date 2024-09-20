resource "oci_core_vcn" "inlab_vcn" {
  compartment_id = var.compartment
  cidr_blocks    = ["192.169.0.0/16", "172.16.0.0/20"]
  display_name   = var.vnc_name
}

resource "oci_core_dhcp_options" "test_dhcp_options" {
  #Required
  compartment_id = var.compartment
  display_name   = "Default-${oci_core_vcn.inlab_vcn.display_name}"
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["inlabs.com"]
  }
  vcn_id = oci_core_vcn.inlab_vcn.id
}

resource "oci_core_subnet" "priv_subnet1" {
  cidr_block        = "192.169.18.0/24"
  compartment_id    = var.compartment
  vcn_id            = oci_core_vcn.inlab_vcn.id
  display_name      = "var.subnet_name-${oci_core_vcn.inlab_vcn.display_name}"
  route_table_id    = oci_core_route_table.test_route_table.id
  security_list_ids = [oci_core_security_list.inlab_security-list.id]
  #dns_label         = var.dns_label_subnet
  dhcp_options_id   = oci_core_vcn.inlab_vcn.default_dhcp_options_id

  provisioner "local-exec" {
    command = "sleep 7"
  }
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = var.compartment
  vcn_id         = oci_core_vcn.inlab_vcn.id
  display_name   = "var.ig_name-${oci_core_vcn.inlab_vcn.display_name}"
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment
  vcn_id         = oci_core_vcn.inlab_vcn.id
  display_name   = "Default Route Table for ${oci_core_vcn.inlab_vcn.display_name}"
  route_rules {
    network_entity_id = oci_core_internet_gateway.test_internet_gateway.id
    destination       = "0.0.0.0/0"
  }
}