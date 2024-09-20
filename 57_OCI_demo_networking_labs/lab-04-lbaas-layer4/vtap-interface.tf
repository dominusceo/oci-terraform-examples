# ricardo.d.carrillo@oracle.com
resource oci_core_vtap demo57_vtap {
  capture_filter_id         = oci_core_capture_filter.generic_capture_filter.id
  compartment_id            = var.compartment_ocid
  display_name              = "demo57_vtap"
  encapsulation_protocol    = "VXLAN"
  is_vtap_enabled           = "false"
  max_packet_size           = "9000"
  source_id                 = oci_load_balancer.lb1.id
  source_type               = "LOAD_BALANCER"
  target_id                 = oci_network_load_balancer_network_load_balancer.nlb_demo57_vtap.id
  target_type               = "NETWORK_LOAD_BALANCER"
  traffic_mode              = "DEFAULT"
  vcn_id                    = oci_core_vcn.test_vcn.id
  vxlan_network_identifier  = "342473"
}

resource oci_core_capture_filter capture_http_https {
  compartment_id            = var.compartment_ocid
  display_name              = "capture_http_https"
  filter_type               = "VTAP"
  vtap_capture_filter_rules {
    destination_cidr = var.destination_cidr_vtap
    #icmp_options = <<Optional value not found in discovery>>
    protocol                = "6"
    rule_action             = "INCLUDE"
    tcp_options {
      destination_port_range {
        max = "80"
        min = "80"
      }
    }
    traffic_direction = "INGRESS"
  }
  vtap_capture_filter_rules {
    destination_cidr = var.destination_cidr_vtap
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "17"
    rule_action = "INCLUDE"
    #source_cidr = <<Optional value not found in discovery>>
    #tcp_options = <<Optional value not found in discovery>>
    traffic_direction = "INGRESS"
    udp_options {
      destination_port_range {
        max = "443"
        min = "443"
      }
    }
  }
}

################
resource oci_core_capture_filter generic_capture_filter {
  compartment_id = var.compartment_ocid
  display_name = "generic_capture_filter"
  filter_type  = "VTAP"
  freeform_tags = {
  }
  vtap_capture_filter_rules {
    destination_cidr = "0.0.0.0/0"
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "all"
    rule_action = "INCLUDE"
    source_cidr = "0.0.0.0/0"
    #tcp_options = <<Optional value not found in discovery>>
    traffic_direction = "INGRESS"
    #udp_options = <<Optional value not found in discovery>>
  }
  vtap_capture_filter_rules {
    destination_cidr = "0.0.0.0/0"
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "all"
    rule_action = "INCLUDE"
    source_cidr = "10.12.0.0/16"
    #tcp_options = <<Optional value not found in discovery>>
    traffic_direction = "EGRESS"
    #udp_options = <<Optional value not found in discovery>>
  }
}