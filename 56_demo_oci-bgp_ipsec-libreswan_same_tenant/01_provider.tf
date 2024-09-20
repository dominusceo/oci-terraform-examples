terraform {
  #required_version = "~> 1.3.0"
  required_providers {
   oci = {
      source = "oracle/oci"
      version = "5.41.0"
    }
  }
}
 
/*
provider "oci" {
  region              = var.region
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key         = var.private_key
  private_key_path    = var.private_key
  config_file_profile = var.profile
}
*/

provider "oci" {
  alias                = "home"
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.fingerprint
  private_key_path     = var.private_key_path
  region               = data.oci_identity_region_subscriptions.home_region_subscriptions.region_subscriptions[0].region_name
  config_file_profile  = "MEXICO"
  disable_auto_retries = "true"
}

data oci_identity_regions regions {}

data oci_identity_tenancy tenancy {
    tenancy_id = var.tenancy_ocid
}

locals {
    region_map = { for r in data.oci_identity_regions.regions.regions : r.key => r.name }
}