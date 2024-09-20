##############################
## OCI Provider - Variables ##
##############################

# OCI Authentication Variables

variable "oci_tenancy" {
  type        = string
  description = "OCI tenancy identifier"
}

variable "oci_user" {
  type        = string
  description = "OCI user identifier"
}

variable "oci_fingerprint" {
  type        = string
  description = "OCI fingerprint for the key pair"
}

variable "oci_key" {
  type        = string
  description = "OCI key pair"
}

variable "oci_region" {
  type        = string
  description = "OCI region"
}

variable "oci_root_compartment" {
  type        = string
  description = "OCI root compartment"
}
#################################
## Create VM Image - Variables ##
#################################

variable "availability_domains" {
  description = "Availability Domains"
  type        = list(any)
}
#################################
## Create VM Image - Variables ##
#################################

variable "instance_shape" {
  description = "Instance size"
  type        = string
  default     = "VM.Standard.E4.Flex"
}

variable "instance_shape_cpu" {
  description = "Instance vCPUs"
  type        = string
  default     = "1"
}

variable "instance_shape_mem" {
  description = "Instance Memory in GB"
  type        = string
  default     = "2"
}
#############################
## Instance - Variables    ##
#############################

# application name 
variable "instance_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
  default     = "windows"
}

# application or company environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}
#########################
## Network - Variables ##
#########################

# VCN Subnet CIDR
variable "vcn_cidr_block" {
  type        = list(string)
  description = "Virtual Cloud Network CIDR Block"
}

# Public Subnet CIDR
variable "public_subnet_cidr_block" {
  type        = string
  description = "Public Subnet CIDR Block"
}

# Enable ipv6
variable "enable_ipv6" {
  type        = bool
  description = "Enable ipV6"
  default     = false
}

# DNS Domain Name
variable "dns_domain_name" {
  type        = string
  description = "DNS Domain Name"
}


