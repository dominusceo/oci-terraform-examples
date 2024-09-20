####################
## Network - Main ##
####################

# Create the OCI VCN 
resource "oci_core_vcn" "vcn" {
  #depends_on = [oci_identity_compartment.compartment]

  cidr_blocks    = var.vcn_cidr_block
 # compartment_id = oci_identity_compartment.compartment.id
  compartment_id      = var.oci_root_compartment
  is_ipv6enabled = var.enable_ipv6
  display_name   = "${var.instance_name}-${var.environment}-vcn"

  freeform_tags = {
    "Application" = var.instance_name
    "Environment" = var.environment
  }

  lifecycle {
    ignore_changes = [defined_tags, dns_label, freeform_tags]
  }
}

# Create the Internet Gateway
resource "oci_core_internet_gateway" "igw" {
  #compartment_id = oci_identity_compartment.compartment.id
  compartment_id      = var.oci_root_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.instance_name}-${var.environment}-igw"

  freeform_tags = {
    "Application" = var.instance_name
    "Environment" = var.environment
  }
}

# Create a Route Table for Internet Gateway
resource "oci_core_route_table" "igw_route_table" {
  #compartment_id = oci_identity_compartment.compartment.id
  compartment_id      = var.oci_root_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.instance_name}-${var.environment}-igw-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

# Create a Public Subnet
resource "oci_core_subnet" "public_subnet" {
  #compartment_id = oci_identity_compartment.compartment.id
  compartment_id      = var.oci_root_compartment
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.public_subnet_cidr_block
  display_name   = "${var.instance_name}-${var.environment}-public-subnet"

  route_table_id    = oci_core_route_table.igw_route_table.id
  security_list_ids = [oci_core_security_list.public_security_list.id]

  freeform_tags = {
    "Application" = var.instance_name
    "Environment" = var.environment
  }

  lifecycle {
    ignore_changes = [defined_tags, dns_label, freeform_tags]
  }
}

