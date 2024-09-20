## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "region" {
  default = "us-ashburn-1"
}
variable "fingerprint" {
  default = "b9:fa:a1:e5:0a:8e:a3:c6:4c:ff:7f:52:22:87:7f:67"
} # comented out for ORM - uncomment if using terraform CLI
variable "user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaakrlp2rwn3ouh45vplzlsqphkjo25i7dbodhl4wctcrzyt7sh4cta"
} # comented out for ORM - uncomment if using terraform CLI
variable "private_key_path" {
  default = "/home/rcarrillos/.oci/general-api.key"
} # comented out for ORM - uncomment if using terraform CLI
variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaawquag7eeulmm6e2yoykcvigene6piosc6rwgglznmt4d5iubifuq"
}
variable "compartment_ocid" {
  default = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
}
variable "ssh_public_key" {
  default="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCNuPZWaPDNia3JSeI0+tlrr2WdPW9qX3/yEKSnoElZyIHYPoXEAtYGJWsoNEEDm3g/2NuiyqQwIE8dsskCiNswfODOe9WDo/wJdJwAfq1xxVrwsEGQ7j+pcnuDusw4bTw/c1g1hg78t1QsXRJGqTEhv3LlSmKrP885N6qWAxLJSYz4MLL/goICo0llufJz/mFEt9wmmNcBaMXpGMGrI+cAhelPurnj7Hh3/pgRns0Hgl4gmlk+h96CBQlSK9kAEcoKi7qpp1RbSQQGOX4btxyQ1FLVeBMT2+m9hQwM5rckph/6h9/ikfTb/wLfAVujAzWF1K0PUz8cVqLl/x9YdvM1 ricardo.d.carrillo@oracle.com"
}

variable "availability_domains" {
  default = "ERDj:SA-SAOPAULO-1-AD-1"
}
variable "hub_vcn_cidr_block" {
  default = "13.0.0.0/16"
}
variable "hub_vcn_dns_label" {
  default = "hubvcn"
}
variable "hub_vcn_display_name" {
  default = "hub_vcn"
}

variable "hub_subnet_pub01_cidr_block" {
  default = "13.0.0.0/24"
}

variable "hub_subnet_pub01_display_name" {
  default = "pub01"
}

# spoke01
variable "spoke01_vcn_cidr_block" {
  default = "10.10.0.0/16"
}
variable "spoke01_vcn_dns_label" {
  default = "spoke01"
}
variable "spoke01_vcn_display_name" {
  default = "spoke01_vcn"
}
variable "spoke01_subnet_priv01_cidr_block" {
  default = "10.10.0.0/24"
}
variable "spoke01_subnet_priv01_display_name" {
  default = "priv01"
}

# # OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "7.7"
}

variable "InstanceShape" {
  default = "VM.Standard.E2.1"
}
