resource "oci_core_vcn" "test_vcn" {
  compartment_id = var.compartment
  cidr_blocks    = ["10.12.0.0/16", "172.168.0.0/20"]
  display_name   = "vnc-inlab"
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block        = "10.12.1.0/24"
  compartment_id    = var.compartment
  vcn_id            = oci_core_vcn.test_vcn.id
  display_name      = "public-subnet-${oci_core_vcn.test_vcn.display_name}"
  route_table_id    = oci_core_route_table.test_route_table.id
  security_list_ids = [oci_core_security_list.test_security_list.id]
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = var.compartment
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "ig-${oci_core_vcn.test_vcn.display_name}"
}

resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment
  vcn_id         = oci_core_vcn.test_vcn.id
  display_name   = "Default Route Table for ${oci_core_vcn.test_vcn.display_name}"
  route_rules {
    network_entity_id = oci_core_internet_gateway.test_internet_gateway.id
    destination       = "0.0.0.0/0"
  }
}
