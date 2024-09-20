resource "oci_objectstorage_bucket" "audit-events-bucket" {
  #Required
  compartment_id = var.compartment_ocid
  name           = var.bucket_name
  namespace      = var.bucket_namespace
  access_type    = var.bucket_access_type
}