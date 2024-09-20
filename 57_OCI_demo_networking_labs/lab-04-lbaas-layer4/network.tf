resource "oci_core_vcn" "test_vcn" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = ["10.12.0.0/16", "172.168.0.0/20"]
  display_name   = "demo57_vncvtapflow"
}

resource "oci_core_dhcp_options" "test_dhcp_options" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = "Default-${oci_core_vcn.test_vcn.display_name}"
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["dominusceo.net"]
  }
  vcn_id = oci_core_vcn.test_vcn.id
}

resource "oci_core_subnet" "pub_subnet1" {
  cidr_block        = "10.12.1.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.test_vcn.id
  display_name      = "public-subnet1-${oci_core_vcn.test_vcn.display_name}"
  route_table_id    = oci_core_route_table.test_route_table.id
  security_list_ids = [oci_core_security_list.test_security_list.id]
  #dns_label           = "public-subnet1"
  dhcp_options_id = oci_core_vcn.test_vcn.default_dhcp_options_id

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
resource "oci_core_subnet" "priv_subnet2" {
  cidr_block        = "10.12.2.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.test_vcn.id
  display_name      = "private-subnet2-${oci_core_vcn.test_vcn.display_name}"
  route_table_id    = oci_core_route_table.test_nat_route_table.id
  security_list_ids = [oci_core_security_list.test_security_list.id]
  #dns_label           = "private-subnet2"
  dhcp_options_id = oci_core_vcn.test_vcn.default_dhcp_options_id

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "ig-${oci_core_vcn.test_vcn.display_name}"
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "Default Route Table for ${oci_core_vcn.test_vcn.display_name}"
  route_rules {
    network_entity_id = oci_core_internet_gateway.test_internet_gateway.id
    destination       = "0.0.0.0/0"
  }
}

resource "oci_core_nat_gateway" "test_nat_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "ng-${oci_core_vcn.test_vcn.display_name}"
}

resource "oci_core_route_table" "test_nat_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "Default Route Table for internal services in ${oci_core_vcn.test_vcn.display_name}"
  route_rules {
    network_entity_id = oci_core_nat_gateway.test_nat_gateway.id
    destination       = "0.0.0.0/0"
  }
}