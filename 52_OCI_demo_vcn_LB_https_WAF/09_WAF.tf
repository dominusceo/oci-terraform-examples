resource "oci_waf_web_app_firewall_policy" "demo52" {
  compartment_id = var.compartment_ocid
  display_name   = "demo52"

  actions {
    name = "block_access"
    type = "RETURN_HTTP_RESPONSE"
    body {
      text = "<H1 style=\"text-align: center;\"><br>Access blocked by OCI WAF !<br>Access is not authorized from your country.</H1>"
      type = "STATIC_TEXT"
    }
    code = "401"
    headers {
      #https://docs.oracle.com/en-us/iaas/Content/WAF/Reference/httpheaders.htm
      name  = "X-Country-Code"
      value = "US"
    }
  }

  actions {
    name = "check"
    type = "CHECK"
  }

  actions {
    name = "allow_access"
    type = "ALLOW"
    code = "200"
  }

  actions {
    name = "ForbbidenAction"
    type = "RETURN_HTTP_RESPONSE"
    code = "403"
  }
  request_access_control {
    default_action_name = "block_access"
    rules {
      action_name        = "allow_access"
      condition          = "i_contains(connection.source.geo.countryCode, 'MX')"
      condition_language = "JMESPATH"
      name               = "AllowSourcesbyCountryMX"
      type               = "ACCESS_CONTROL"
    }
    rules {
      action_name        = "allow_access"
      condition          = "i_contains(['GET'], http.request.method)\n&& i_equals(http.request.url.path, '/protected')\n&& i_contains(['MX'], connection.source.geo.countryCode)"
      condition_language = "JMESPATH"
      name               = "Allowed-URLs-with-GET"
      type               = "ACCESS_CONTROL"
    }
    rules {
      action_name        = "allow_access"
      condition          = "i_contains(['POST'], http.request.method)\n&& i_contains(http.request.url.path, '/protected')\n&& i_contains(['MX'], connection.source.geo.countryCode)"
      condition_language = "JMESPATH"
      name               = "Allowed-URLs-with-POST"
      type               = "ACCESS_CONTROL"
    }
    rules {
      action_name        = "block_access"
      condition          = "i_contains(['GET', 'POST', 'DELETE', 'PROPFIND', 'PUT'], http.request.method)"
      condition_language = "JMESPATH"
      name               = "deny-by-default"
      type               = "ACCESS_CONTROL"
    }
  }
  request_protection {
    #body_inspection_size_limit_exceeded_action_name = <<Optional value not found in discovery>>
    body_inspection_size_limit_in_bytes = "8192"
    rules {
      action_name                = "block_access"
      condition                  = "i_equals(http.request.url.path, '/protected')"
      condition_language         = "JMESPATH"
      is_body_inspection_enabled = "true"
      name                       = "requestProtectionRule"
      protection_capabilities {
        action_name                    = "check"
        collaborative_action_threshold = "4"
        collaborative_weights {
          key    = "9301000"
          weight = "2"
        }
        collaborative_weights {
          key    = "9301100"
          weight = "2"
        }
        collaborative_weights {
          key    = "9301200"
          weight = "2"
        }
        collaborative_weights {
          key    = "9301300"
          weight = "2"
        }
        exclusions {
          args = [
            "argName1",
            "argName2",
          ]
          request_cookies = [
            "cookieName1",
            "cookieName2",
          ]
        }
        key     = "9300000"
        version = "1"
      }
      protection_capabilities {
        action_name = "check"
        #collaborative_action_threshold = <<Optional value not found in discovery>>
        exclusions {
          args = [
            "algo1",
          ]
          request_cookies = [
          ]
        }
        key     = "944152"
        version = "1"
      }
      protection_capabilities {
        action_name = "check"
        #collaborative_action_threshold = <<Optional value not found in discovery>>
        #exclusions = <<Optional value not found in discovery>>
        key     = "944151"
        version = "1"
      }
      protection_capabilities {
        action_name = "check"
        #collaborative_action_threshold = <<Optional value not found in discovery>>
        #exclusions = <<Optional value not found in discovery>>
        key     = "944150"
        version = "1"
      }
      protection_capabilities {
        action_name = "check"
        #collaborative_action_threshold = <<Optional value not found in discovery>>
        #exclusions = <<Optional value not found in discovery>>
        key     = "932131"
        version = "1"
      }
      protection_capabilities {
        action_name = "check"
        #collaborative_action_threshold = <<Optional value not found in discovery>>
        #exclusions = <<Optional value not found in discovery>>
        key     = "932130"
        version = "3"
      }
      #protection_capability_settings = <<Optional value not found in discovery>>
      type = "PROTECTION"
    }
  }
  request_rate_limiting {
    rules {
      action_name = "ForbbidenAction"
      #condition = <<Optional value not found in discovery>>
      condition_language = "JMESPATH"
      configurations {
        action_duration_in_seconds = "10"
        period_in_seconds          = "100"
        requests_limit             = "10"
      }
      name = "requestRateLimitingRule"
      type = "REQUEST_RATE_LIMITING"
    }
    #system_tags = var.web_app_firewall_policy_system_tags
  }
}

# associate the WAF policy to the OCI load balancer
resource "oci_waf_web_app_firewall" "demo52" {
  compartment_id             = var.compartment_ocid
  display_name               = "demo52"
  backend_type               = "LOAD_BALANCER"
  load_balancer_id           = oci_load_balancer_load_balancer.demo52-lb.id
  web_app_firewall_policy_id = oci_waf_web_app_firewall_policy.demo52.id
}