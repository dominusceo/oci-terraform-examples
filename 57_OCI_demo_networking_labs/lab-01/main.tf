#Author : Ricardo Carrillo
# Main file describe the provider configuration, this file uses vars.tf file in order to get values defined to connect to oci
terraform {
  #required_version = "~> 1.3.0"
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~>4.93"
    }
  }
}

provider "oci" {
  region              = var.oci_region
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key         = var.private_key
  private_key_path    = var.private_key
  config_file_profile = var.profile
}
