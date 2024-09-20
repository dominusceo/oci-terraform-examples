resource "oci_dns_zone" "test_zone" {
  #Required
  compartment_id = var.compartment_ocid
  name           = var.zone_name
  zone_type      = var.zone_zone_type
}

resource "oci_dns_view" "oexample_view" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  scope        = "PRIVATE"
  display_name = var.view_display_name
}