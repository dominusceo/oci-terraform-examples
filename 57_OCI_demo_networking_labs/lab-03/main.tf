#Author : Ricardo Carrillo <ricardo.d.carrillo@oracle.com>
# Main file describe the provider configuration, this file uses vars.tf file in order to get values defined to connect to oci
#The Terraform code contains the following directories and files at the top level:
#  -  docs directory and *.adoc: Documentation for the code. All the information and instructions you need is included in the documentation that you're reading now. You won't need to refer to the documentation that's included in the code.
#  -  *.tf: The Terraform configuration files that the solution uses. Do not edit these files.
#  -  terraform.tfvars.example: A template that you'll use to create the Terraform variables file. Don't edit or remove the template. Copy it to terraform.tfvars
#  -  modules: Directories containing the core Terraform configurations for the resources that you create by using this solution. Do not edit them.
#  -  examples: Directory containing code samples for additional solutions that can be developed by using this solution as the base module. The additional solutions and the code samples for them are outside the scope of this solution. You can either leave the directory as is in your repository or remove them.
#  - .github directory and .gitignore: Internal Github configuration files. Do not edit them.

terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~>4.92"
    }
  }
  cloud {
    organization = "dominus-ceo"
    workspaces {
      name = "oracle"
  }
  
  backend "s3" {
    bucket                      = "bucket-terraform"
    key                         = "terraform.tfstate"
    region                      = "us-sanjose-1"
    endpoint                    = "https://axa9guvckv7k.compat.objectstorage.us-sanjose-1.oraclecloud.com"
    shared_credentials_file     = "~/.oci/tf-bucket-c"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
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