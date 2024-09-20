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
  default     = "72:5f:c4:20:2b:b0:13:96:81:cb:67:2e:22:f7:75:f6"
  description = "Oracle Cloud Fingerprint for the key pair"
}

variable "private_key" {
  type    = string
  default = "~/.ssh/api_key_private.pem"
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

variable "profile" {
  type = string
  default = "ORACLESECURITY"
  description = "Default profile in OCI-CLI config file (~/.oci/config)"
}
