/*
 * Autor : Ricardo David Carrillo Sanchez <ricardo.d.carrillo@oracle.com> 
 * Goal  : This example demonstrates round robin load balancing behavior 
 *         by creating two alwats free  instances, a configured vcn and a 
 *         load balancer. 
 *
 *         The public IP of the load balancer is outputted after a successful
 *         run, curl this address to see the hostname change as different instances
 *         or open a web browser and test to handle the request.
 */

resource "oci_core_public_ip" "test_reserved_ip" {
  compartment_id = var.compartment
  lifetime       = "RESERVED"
  lifecycle {
    ignore_changes = [private_ip_id]
  }
}

/* Load Balancer */
resource null_resource lb-certificates-generate {
  provisioner local-exec {
    command = "sh ./certs/create-certificates.sh"
  }
}

resource "oci_load_balancer" "lb1" {
  shape          = "flexible"
  compartment_id = var.compartment
  subnet_ids = [
    oci_core_subnet.pub_subnet1.id,
    #oci_core_subnet.priv_subnet2.id,
  ]
  display_name = "lb1-${oci_core_vcn.test_vcn.display_name}"
  reserved_ips {
    id = oci_core_public_ip.test_reserved_ip.id
  }

  shape_details {
    #Required
    maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
  }
}

resource "oci_load_balancer_backend_set" "lb-bkset1" {
  name             = "lb-bkset1-${oci_core_vcn.test_vcn.display_name}"
  load_balancer_id = oci_load_balancer.lb1.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "443"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
    retries             =  3
    interval_ms         = 3000
    timeout_in_millis   = 1000
  }
  ssl_configuration {
    #Optional
    certificate_name = oci_load_balancer_certificate.test_certificate.certificate_name
    verify_depth            = 0
    verify_peer_certificate = false
  }
}

resource "oci_load_balancer_path_route_set" "test_path_route_set" {
  #Required
  load_balancer_id = oci_load_balancer.lb1.id
  name             = "pr-set1"

  path_routes {
    #Required
    backend_set_name = oci_load_balancer_backend_set.lb-bkset1.name
    path             = "/v1"

    path_match_type {
      #Required
      match_type = "EXACT_MATCH"
    }
  }
}

resource "oci_load_balancer_hostname" "test_hostname1" {
  #Required
  hostname         = "${oci_core_instance.test_instance[0].display_name}.example.com"
  name             = oci_core_instance.test_instance[0].display_name
  load_balancer_id = oci_load_balancer.lb1.id
}

resource "oci_load_balancer_hostname" "test_hostname2" {
  #Required
  hostname         = "${oci_core_instance.test_instance[1].display_name}.example.com"
  name             = oci_core_instance.test_instance[1].display_name
  load_balancer_id = oci_load_balancer.lb1.id
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = oci_load_balancer.lb1.id
  name                     = "lstnr-${oci_core_vcn.test_vcn.display_name}"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bkset1.name
  hostname_names           = [oci_load_balancer_hostname.test_hostname1.name, oci_load_balancer_hostname.test_hostname2.name]
  port                     = 443
  protocol                 = "HTTP"
  rule_set_names           = [oci_load_balancer_rule_set.test_rule_set.name]
  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
  ssl_configuration {
    #Optional
      certificate_name = oci_load_balancer_certificate.test_certificate.certificate_name
      verify_depth        = 0
      verify_peer_certificate = false
      protocols =  ["TLSv1.1", "TLSv1.2"]
    }
}

resource "oci_load_balancer_backend" "lb-backend1" {
  count            = 2
  load_balancer_id = oci_load_balancer.lb1.id
  backendset_name  = oci_load_balancer_backend_set.lb-bkset1.name
  ip_address       = oci_core_instance.test_instance[count.index].private_ip
  port             = 443
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_rule_set" "test_rule_set" {
  items {
    action          = "CONTROL_ACCESS_USING_HTTP_METHODS"
    allowed_methods = ["GET", "POST"]
    status_code     = "405"
  }

  items {
    action = "REDIRECT"

    conditions {
      attribute_name  = "PATH"
      attribute_value = "/v1"
      operator        = "FORCE_LONGEST_PREFIX_MATCH"
    }
    redirect_uri {
      protocol = "https"
      host     = "{host}"
      port     = 8080
      path     = "/okit"
      query    = "?lang=en"
    }

    response_code = 302
  }

  items {
    action                         = "HTTP_HEADER"
    are_invalid_characters_allowed = true
    http_large_header_size_in_kb   = 8
  }

  load_balancer_id = oci_load_balancer.lb1.id
  # name             = "${oci_vcn_name.test_vcn.display_name}_rule_set_name"
  name = "example_rule_set_name"
}

resource "oci_load_balancer_certificate" "test_certificate" {
  #Required
  certificate_name = "loadbalancer.crt"
  load_balancer_id = oci_load_balancer.lb1.id
  #Optional
  /* You should consider to parse or configure your certificate more secure way, 
   * for the purpouse of this lab, we can set the certificates within the same 
   * git Project
  */
  ca_certificate     = file("./certs/ca.crt")
  public_certificate = file("./certs/loadbalancer.crt")
  passphrase         = null
  private_key        = file("./certs/loadbalancer.key")
  lifecycle {
    create_before_destroy = true
  }
}

data "oci_load_balancer_ssl_cipher_suites" "test_ssl_cipher_suites" {
  #Optional
  load_balancer_id = oci_load_balancer.lb1.id
}
output "lb_public_ip-and_nodes" {
  value = [oci_load_balancer.lb1.ip_address_details, oci_core_instance.test_instance[0].private_ip, oci_core_instance.test_instance[1].private_ip]
}