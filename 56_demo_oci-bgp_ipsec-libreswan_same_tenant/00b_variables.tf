variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

# Required by the OCI Provider
variable "compartment_ocid" {
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "Oracle Cloud Compute Compartment where the infra will be deployed"
}

variable "tenancy_ocid" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaawquag7eeulmm6e2yoykcvigene6piosc6rwgglznmt4d5iubifuq"
  description = "Oracle Cloud Identifier tenancy"
}

variable "user_ocid" {
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaakrlp2rwn3ouh45vplzlsqphkjo25i7dbodhl4wctcrzyt7sh4cta"
  description = "Oracle Cloud Identifier user"
}

variable "fingerprint" {
  type        = string
  default     = "66:df:ee:f4:c3:fe:84:90:ac:d6:50:65:ca:2e:d6:57"
  description = "Oracle Cloud Fingerprint for the key pair"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/tf-private.key"
}

variable "region" {
  type = map(string)
  default = {
    "mx" = "mx-queretaro-1"
    "as" = "us-ashburn-1"
    "sp" = "sa-saopaulo-1"
    "sj" = "us-sanjose-1"
    "ch" = "sa-santiago-1"
    "pnx"= "us-phoenix-1"
  }
  description = "Oracle Cloud region"
}

# Key used to SSH to OCI VMs
variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
}

variable "ssh_private_key" {
  #https://forums.oracle.com/ords/apexds/post/terraform-ssh-private-key-issue-9138
  type    = string
  default = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAleT74XsYzXyBgbQvo+WLvmkJPnGfFGurRMtl97Y5DIleDrq3
2Gh9APtDwsMMESG/ABcicVuMvQqtpfgdIxMYT3JFAuNsa991OH2/3w0vCIDvGNKW
5CxfT2WwQ7YFDXKfZoIXi4nOFu212E9UtVYRZLXtX+HKuIBf17AJ1PnI/tUAQ69B
VNpXqGnPOwYXiOshgf4u5UsMOhb6ZeKLU4VbqAvdrSLjlzTD0iwabCPooDaAPuD1
Icki4sf+AimAVGJpmLGV+Pqzd6kUZPmdiYqLHVVehJ3c3sgoSedEzcSVae0iHOv2
EvpP87EsfXf1tlua0g0QdVnhCjGvkO0bimMcfwIDAQABAoIBACXoo/UqGyM45k3l
wpiqQJXW3aIfvTI+arG62R51ROdRRGroOP+vqVGauk/i4UXh6Xq93xWZKDZVIYaU
gdXxidfp1987ohuEB5LSZrikDm2RoiZ+d+/b8vzTBGmTeqKkhwC3TPoaz3bIBpHe
ulckHcEBK7fwlELmIJcda9cjlvwvgkvPR5oGEt5osxGiE3I1zsWZc2kSgntYrGVF
FOisITbi+/cSVWGA9lCPW3DVkyAa7OtuVdxrosaP1YY+yhSDmdNFPLlEvRK5ezgx
/dJDph+VDgrPBGLsa13EOaqPTAxY2fJzb11Uos4BuU1VNMdYt6avUq8RqyZ4CmdV
G+MNfY0CgYEAxXYjf8YtjU05qhP0EI4rVjDL74sdB5kcXUIKbELoDrF7nivt2Cxn
b2R32VCVfgpI6xAUY30ptLYcfL2H3zHkYRKs0TboPSc80GVUW9q7FhDsgoXJHkJm
hEBW1IhmjznzeP1w1pfoghx6H/SZ+E7rYQlALz2J6vmu3Y6U5LrGsm0CgYEAwlTc
rQyBi4JTYF93lGKzXGW6PoKYCtMcxILhVO9Ac8jxP19gjB5deheCIkqEkg26yEs8
5h4nscqc8EfgthD5c802mnH+9vuUljQ/1YHHnNkFHGeoe5Qk75H9/Hbuo027fQGW
koOaZrWe7hdCHul9I1vxAjQPt2pwYWgFhBbwlxsCgYAwQ88rhTJPLoggxV3LyiRX
nffLJnLDD666MNFBYx07sjAoGk65nyjtNl6BFMxlkXf/VN/W7ZoLHNRbvSv/5z8O
ZzUsskIT6IpZ2drD1PQT0bEtuivNpKdQPjW7H1gKPD0B3tj86wae/vzu4Kfd5NRt
1IgGxAD5GWyfpSFJw0mcBQKBgQCCWpxgdAgdxcEZ30/+OCrqKs7Aiadlc3FTnBt8
drR8NmklQlwoAWJguI4xZF0C/7SwEE/8aHPl/exB/WUNm9tIw3oCJb+Kev2Tt96t
4E0+uBCGmj3ZD2mrTfnaNQkkf8rpMnyHMUIL7X57ZRyUUbkAU/cZrERymzJhFH7G
uQCPywKBgCdaNSIkoMOSQzBr0kXM80fClLlfHxm6SRWsGKMgWviupsJCtJsyszVz
kpHOZvefujuQBnKdEs2kASKPThx8ikU2/ys5ZgWlXLrfGAM4LsZGvHd2JWqqqnxa
tQ39pJuJV3uzz48bL+9M1MpnDL1PI0A7YMqQCwJnvXcACDTx8H1c
-----END RSA PRIVATE KEY-----
EOF
}

variable "profile" {
  type    = string
  default = "DEFAULT"
}

# Terraform 
variable "pem_private_key_path" {
  type    = string
  default = "~/.ssh/api_key_private.pem"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/tf-public.key"
}

# ---------------------------------------------------------------------------------------------------------------------
# Network variables
# ---------------------------------------------------------------------------------------------------------------------
/*
variable "default_oci_vcn_route_table" {
    type = string
}
*/
variable "user"{
  type    = string
  default = "opc"
}
variable "oci_subnet_cidr" {
  type    = string
  default = "193.168.20.0/24"
}

variable "oci_priv_subnet_cidr" {
  type    = string
  default = "193.168.21.0/24"
}

variable "onprem_subnet_cidr" {
  type    = string
  default = "172.10.0.0/24"
}
variable "oci_vcn_cidr_block" {
  type    = string
  default = "193.168.0.0/16"
}
variable "onprem_cidr_block" {
  type    = string
  default = "172.10.0.0/16"
}

variable "bgp_cust_tunnela_ip" {
  type    = string
  default = "10.10.10.1/30"
}

variable "bgp_oci_tunnela_ip" {
  type    = string
  default = "10.10.10.2/30"
}
variable "bgp_cust_tunnelb_ip" {
  type    = string
  default = "10.10.10.5/30"
}
variable "bgp_oci_tunnelb_ip" {
  type    = string
  default = "10.10.10.6/30"
}
variable "shared_secret_psk" {
  type    = string
  default = "UppOkHbW8GXa49DAGkXSncf1Gkdzi4kG98UtdZQYkYvLsvz0oS3sgGAg5DNYrkQ6"
}
variable "instance_image_ocid" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    mx-queretaro-1 = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaatrca6uvd2wi7v6vpxrpug3lrhdfk6x63zg4gtpcnyltndllfqn7q"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaaoqj42sokaoh42l76wsyhn3k2beuntrh5maj3gmgmzeyr55zzrwwa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaay4rq7eg5j5c55vlwth43y6xrhhbivagj5vosae2a56acpr3xavya"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa32voyikkkzfxyo4xbdmadc2dmvorfxxgdhpnk6dw64fa3l4jh7wa"
    us-sanjose-1   = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa3stdbyfdqhcdykpzf7ndzwudklnp77wo5lym7rp33ysspk6o2m4q"
  }
}
variable "instance_shape" {
  default = "VM.Standard.E4.Flex"
}

variable "instance_shape_config_memory_in_gbs" {
  type = string
  default = "12"
}
variable "instance_shape_config_ocpus" {
  type = string
  default = "4"
}