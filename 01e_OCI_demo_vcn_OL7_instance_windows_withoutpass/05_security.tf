##########################
## Create Security List ##
##########################

# Local Variables for Security Lists
locals {
  tcp_protocol     = "6"
  udp_protocol     = "17"
  icmp_protocol    = "1"
  icmp_v6_protocol = "58"
  all_protocols    = "all"
  anywhere         = "0.0.0.0/0"
}

# Create a Security List for the Public Subnet
resource "oci_core_security_list" "public_security_list" {
  #compartment_id = oci_identity_compartment.compartment.id
  compartment_id      = var.oci_root_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.instance_name}-${var.environment}-public-security-list"

  # RDP TCP Port 3389 from anywhere
  ingress_security_rules {
    description = "RDP TCP Port 3389"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = local.anywhere
    source_type = "CIDR_BLOCK"

    tcp_options {
      min = 3389
      max = 3389
    }
  }

  # HTTPS TCP Port 443 from anywhere
  ingress_security_rules {
    description = "HTTPS TCP Port 443"
    stateless   = false
    protocol    = local.tcp_protocol
    source      = local.anywhere
    source_type = "CIDR_BLOCK"

    tcp_options {
      min = 443
      max = 443
    }
  }
  # allow inbound winrm traffic
  ingress_security_rules {
    protocol    = local.tcp_protocol
    source      = local.anywhere
    stateless = false
    tcp_options { 
      min = 5986
      max = 5986
    }
  }

  # Egress all
  egress_security_rules {
    description = "Egress all"
    stateless   = false
    protocol    = local.tcp_protocol
    destination = local.anywhere
  }
}

