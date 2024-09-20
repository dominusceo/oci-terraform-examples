# ------ OCI Network Firewall Policy
resource "oci_network_firewall_network_firewall_policy" "network_firewall_policy" {
  display_name   = "network-firewall-policy-demo"
  compartment_id = var.network_compartment_ocid
  /* security_rules {
    action = var.oci_network_firewall_policy_action
    condition {
    }
    name = "Allow-All"
  }
  */
}
# ------ OCI Network Firewall
resource "oci_network_firewall_network_firewall" "network_firewall" {
  count                      = local.use_existing_network ? 0 : 1
  compartment_id             = var.network_compartment_ocid
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  subnet_id                  = local.use_existing_network ? var.oci_network_firewall_subnet_id : oci_core_subnet.oci_network_firewall_subnet[0].id
  display_name               = var.oci_network_firewall_name
  depends_on = [
    oci_core_subnet.oci_network_firewall_subnet,
  ]
}
resource oci_network_firewall_network_firewall_policy_address_list summit-lb-ip {
  addresses = [
    "10.10.1.148",
    "64.181.170.70",
  ]
  name                       = "summit-lb-ip"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list serverB-subnet {
  addresses = [
    "10.20.2.0/24",
  ]
  name                       = "serverB-subnet"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list serverA-subnet {
  addresses = [
    "10.20.1.0/24",
  ]
  name                       = "serverA-subnet"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list spoke-vcn {
  addresses = [
    "10.20.0.0/16",
  ]
  name                       = "spoke-vcn"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list server-subnet {
  addresses = [
    "10.10.2.0/24",
  ]
  name                       = "server-subnet"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list firewall-vcn {
  addresses = [
    "10.10.0.0/16",
  ]
  name                       = "firewall-vcn"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list firewall-subnet {
  addresses = [
    "10.10.0.0/24",
  ]
  name                       = "firewall-subnet"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}

resource oci_network_firewall_network_firewall_policy_address_list client-subnet {
  addresses = [
    "10.10.1.0/24",
  ]
  name                       = "client-subnet"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  type                       = "IP"
}
resource "oci_network_firewall_network_firewall_policy_application_group" "echo-reply-request" {
  apps = [
  ]
  name                       = "echo-reply-request"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-Allow-URL" {
  action = "ALLOW"
  condition {
    application = [
    ]
    destination_address = [
    ]
    service = [
      "common-web",
    ]
    source_address = [
    ]
    url = [
      "allow-url",
    ]
  }
  inspection                 = ""
  name                       = "SR-Allow-URL"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    #after_rule = <<Optional value not found in discovery>>
    before_rule = "SR-Deny-URL"
  }
  #priority_order = <<Optional value not found in discovery>>
}
resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-Deny-URL" {
  action = "DROP"
  condition {
    application = [
    ]
    destination_address = [
    ]
    service = [
      "common-web",
    ]
    source_address = [
    ]
    url = [
      "deny-social-url",
    ]
  }
  inspection                 = ""
  name                       = "SR-Deny-URL"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-Allow-URL"
    before_rule = "SR-IPS-URL-client"
  }
  #priority_order = <<Optional value not found in discovery>>
}
resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-IPS-URL-client" {
  action = "INSPECT"
  condition {
    application = [
    ]
    destination_address = [
    ]
    service = [
      "common-web",
    ]
    source_address = [
      "client-subnet",
    ]
    url = [
      "ids-url",
    ]
  }
  inspection                 = "INTRUSION_PREVENTION"
  name                       = "SR-IPS-URL-client"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-Deny-URL"
    before_rule = "SR-IDS-URL-server"
  }
  #priority_order = <<Optional value not found in discovery>>
}
resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-IDS-URL-server" {
  action = "INSPECT"
  condition {
    application = [
    ]
    destination_address = [
    ]
    service = [
      "common-web",
    ]
    source_address = [
      "server-subnet",
    ]
    url = [
      "ids-url",
    ]
  }
  inspection                 = "INTRUSION_DETECTION"
  name                       = "SR-IDS-URL-server"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-IPS-URL-client"
    before_rule = "SR-External-WebApplication"
  }
  #priority_order = <<Optional value not found in discovery>>
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-External-WebApplication" {
  action = "INSPECT"
  condition {
    application = [
    ]
    destination_address = [
      "serverB-subnet",
      "serverA-subnet",
      "server-subnet",
    ]
    service = [
      "common-web",
    ]
    source_address = [
    ]
    url = [
    ]
  }
  inspection                 = "INTRUSION_DETECTION"
  name                       = "SR-External-WebApplication"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-IDS-URL-server"
    before_rule = "SR-External-LoadBalancer"
  }
  #priority_order = <<Optional value not found in discovery>>
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-External-LoadBalancer" {
  action = "INSPECT"
  condition {
    application = [
    ]
    destination_address = [
      "summit-lb-ip",
    ]
    service = [
      "common-web",
    ]
    source_address = [
    ]
    url = [
    ]
  }
  inspection                 = "INTRUSION_PREVENTION"
  name                       = "SR-External-LoadBalancer"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-External-WebApplication"
    before_rule = "SR-Internal-LoadBalancer"
  }
  #priority_order = <<Optional value not found in discovery>>
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-Internal-LoadBalancer" {
  action = "ALLOW"
  condition {
    application = [
    ]
    destination_address = [
      "server-subnet",
    ]
    service = [
      "common-web",
    ]
    source_address = [
      "client-subnet",
    ]
    url = [
    ]
  }
  inspection                 = ""
  name                       = "SR-Internal-LoadBalancer"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-External-LoadBalancer"
    before_rule = "SR-Internal-Remote-Access"
  }
  #priority_order = <<Optional value not found in discovery>>
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-Internal-Remote-Access" {
  action = "ALLOW"
  condition {
    application = [
    ]
    destination_address = [
      "spoke-vcn",
      "firewall-vcn",
    ]
    service = [
      "common-remote-access",
    ]
    source_address = [
      "client-subnet",
    ]
    url = [
    ]
  }
  inspection                 = ""
  name                       = "SR-Internal-Remote-Access"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule  = "SR-Internal-LoadBalancer"
    before_rule = "SR-External-Remote-Access"
  }
  #priority_order = <<Optional value not found in discovery>>
}

resource "oci_network_firewall_network_firewall_policy_security_rule" "SR-External-Remote-Access" {
  action = "ALLOW"
  condition {
    application = [
    ]
    destination_address = [
      "client-subnet",
      "serverA-subnet",
    ]
    service = [
      "common-remote-access",
    ]
    source_address = [
    ]
    url = [
    ]
  }
  inspection                 = ""
  name                       = "SR-External-Remote-Access"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  position {
    after_rule = "SR-Internal-Remote-Access"
    #before_rule = <<Optional value not found in discovery>>
  }
  #priority_order = <<Optional value not found in discovery>>
}

resource "oci_network_firewall_network_firewall_policy_service" "common-web" {
  name                       = "common-web"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  port_ranges {
    maximum_port = "80"
    minimum_port = "80"
  }
  port_ranges {
    maximum_port = "443"
    minimum_port = "443"
  }
  type = "TCP_SERVICE"
}

resource "oci_network_firewall_network_firewall_policy_service" "common-ssh" {
  name                       = "common-ssh"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  port_ranges {
    maximum_port = "22"
    minimum_port = "22"
  }
  type = "TCP_SERVICE"
}

resource "oci_network_firewall_network_firewall_policy_service" "common-rdp" {
  name                       = "common-rdp"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  port_ranges {
    maximum_port = "3389"
    minimum_port = "3389"
  }
  type = "TCP_SERVICE"
}

resource "oci_network_firewall_network_firewall_policy_service_list" "common-web_1" {
  name                       = "common-web"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  services = [
    "common-web",
  ]
}

resource "oci_network_firewall_network_firewall_policy_service_list" "common-remote-access" {
  name                       = "common-remote-access"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  services = [
    "common-rdp",
    "common-ssh",
  ]
}

resource "oci_network_firewall_network_firewall_policy_url_list" "ids-url" {
  name                       = "ids-url"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  urls {
    pattern = "eicar.org"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.eicar.org"
    type    = "SIMPLE"
  }
  urls {
    pattern = "secure.eicar.org"
    type    = "SIMPLE"
  }
}

resource "oci_network_firewall_network_firewall_policy_url_list" "deny-social-url" {
  name                       = "deny-social-url"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  urls {
    pattern = "linkedin.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.linkedin.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "youtube.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.youtube.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "instagram.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.instagram.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "facebook.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.facebook.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "x.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.x.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "twitter.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.twitter.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "tiktok.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "wwww.tiktok.com"
    type    = "SIMPLE"
  }
}

resource "oci_network_firewall_network_firewall_policy_url_list" "allow-url" {
  name                       = "allow-url"
  network_firewall_policy_id = oci_network_firewall_network_firewall_policy.network_firewall_policy.id
  urls {
    pattern = "www.google.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "google.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.espn.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "espn.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "www.espn.com.br"
    type    = "SIMPLE"
  }
  urls {
    pattern = "espn.com.br"
    type    = "SIMPLE"
  }
  urls {
    pattern = "*.espn.com.br"
    type    = "SIMPLE"
  }
  urls {
    pattern = "*.espn.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "*.espncdn.com.br"
    type    = "SIMPLE"
  }
  urls {
    pattern = "*.espncdn.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "yum.oracle.com"
    type    = "SIMPLE"
  }
  urls {
    pattern = "yum.*.oci.oraclecloud.com"
    type    = "SIMPLE"
  }
}