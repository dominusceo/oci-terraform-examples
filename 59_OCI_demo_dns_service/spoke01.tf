## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "spoke01" {
  cidr_block     = var.spoke01_vcn_cidr_block
  dns_label      = var.spoke01_vcn_dns_label
  compartment_id = var.compartment_ocid
  display_name   = var.spoke01_vcn_display_name
}
#LPG Spoke-HUB
resource "oci_core_local_peering_gateway" "spoke01_hub_local_peering_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.spoke01.id
  display_name   = "spoke01_hub_lpg"
}

#Default route table spoke01
resource "oci_core_default_route_table" "spoke01_default_route_table" {
  manage_default_resource_id = oci_core_vcn.spoke01.default_route_table_id
  route_rules {
    network_entity_id = oci_core_local_peering_gateway.spoke01_hub_local_peering_gateway.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}
