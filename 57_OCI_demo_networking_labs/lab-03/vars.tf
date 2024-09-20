variable "compartment" {
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaanoui6jllobc2iubjyno2vvvv7flg4rsu37avw532zzygizgche7q"
  description = "Oracle Cloud Compute Compartment where the infra will be deployed"
}

variable "tenancy_ocid" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaar6q6nrtbkidcz6xnyl3lkqssk7c6nslpnu2mdjywtbppvz5txz2a"
  description = "Oracle Cloud Identifier tenancy"
}

variable "user_ocid" {
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaavhq2vh6b2fh2yim2jmh6bjb3kkd2x7prhhfkz7swomle644azkcq"
  description = "Oracle Cloud Identifier user"
}

variable "fingerprint" {
  type        = string
  default     = "3e:48:9e:44:b4:23:3c:41:8e:94:03:d5:4a:83:73:5b"
  description = "Oracle Cloud Fingerprint for the key pair"
}

variable "private_key" {
  type    = string
  default = "~/.ssh/oci_api_private.pem"
}

variable "oci_region" {
  type        = string
  default     = "us-sanjose-1"
  description = "Oracle Cloud region"
}

variable "ad_list" {
  type        = list(any)
  default     = ["HRGE:US-SANJOSE-1-AD-1"]
  description = "Availability Domain in us-sanjose-1 region"
}

variable "adDomain" {
  type        = string
  default     = "HRGE:US-SANJOSE-1-AD-1"
  description = "Availability domain in San Jose"
}

variable "ansible_user" {
  type    = string
  default = "opc"
}

variable "instanceShape" {
  type        = string
  default     = "VM.Standard.E2.1.Micro"
  description = "Virtual machine default shape"
}

variable "ansible_ssh_private_key" {
  type    = string
  default = "~/.ssh/tf-private.key"
}

variable "templates_path" {
  type    = string
  default = "./module/templates/"
}

variable "inventory_path" {
  type    = string
  default = "./module/inventory/"
}

variable "inventory_file" {
  type    = string
  default = "host.ini"
}

variable "grpIAMAdmin" {
  type        = string
  default     = "Administrators"
  description = "Default Administrators in OCI console"
}

variable "vnc_name" {
  type        = string
  default     = "vnc-inlab"
  description = "OCI default name for the VCN to be created"
}
variable "dns_label_subnet" {
  type        = string
  default     = "private-subnet"
  description = "OCI default dns dns_label_subnet"
}

variable "ig_name" {
  type        = string
  default     = "ig"
  description = "OCI default internet gateway name"
}
variable "securitylist_name" {
  type        = string
  default     = "SL_lab"
  description = "OCI default Security list Name"

}
variable "vcn_dns_label" {
  type        = string
  default     = "private-subnet"
  description = "OCI default dns label for the resources"
}
variable "subnet_name" {
  type        = string
  default     = "private-subnet1"
  description = "OCI default dns label for the resources"
}

variable "image_id" {
  type        = string
  default     = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa3stdbyfdqhcdykpzf7ndzwudklnp77wo5lym7rp33ysspk6o2m4q"
  description = "Default image id to be used on deployments" 
}

variable "domains" {
  type = map(object({
    domain_name = string,
    port        = number,
    hostnames   = list(string),
  }))
  description = "Parameters for Domains for the different servers."
  default     = {}
}