resource "oci_core_security_list" "inlab_security-list" {
  compartment_id = var.compartment
  vcn_id         = oci_core_vcn.inlab_vcn.id
  display_name   = var.securitylist_name
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = "22"
      max = "22"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = "80"
      max = "80"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"
    tcp_options {
      min = "443"
      max = "443"
    }
  }
}

