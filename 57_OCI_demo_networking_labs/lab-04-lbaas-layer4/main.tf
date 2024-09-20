#Author : Ricardo Carrillo ricardo.d.carrillo@oracle.com
#Goal   : Main file describe the provider configuration, this file uses vars.tf file in order to get values defined to connect to oci
terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
    }
  }
}
