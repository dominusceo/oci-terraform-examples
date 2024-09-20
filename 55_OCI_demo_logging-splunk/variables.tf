## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

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
  default     = "8e:9b:88:5b:69:da:e3:72:7c:06:a5:3c:4f:5b:2c:7d"
  description = "Oracle Cloud Fingerprint for the key pair"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/oci-console-private.pem"
}

variable "region" {
  type        = string
  default     = "mx-queretaro-1"
  description = "Oracle Cloud region"
}
variable "availability_domain_name" {
  default = ""
}

variable "availability_domain_number" {
  default = 0
}

variable "use_existing_vcn" {
  default = false
}

variable "vcn_id" {
  default = ""
}

variable "lb_subnet_id" {
  default = ""
}

variable "compute_subnet_id" {
  default = ""
}

# Key used to SSH to OCI VMs
variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdaKuRf286xQDpUUzMZ7hmJsSkiKBVgfCDJiNf+T3g+zXTTsTA4IwLfE0gLP7QyDbpJtlj59KCPCSjDENnLkjFkM7NTJsRL4uGtn7h0MTmkr7/XAk5V8dDOBc0n/ezlACniNo4Mo9MnsmGp742VsF1+EeRILOU5f8JxOYLnJOyGL5SB0UJrkrFni7rZoaTNJ5DHjojs/wu2mon5P7zgOS/2EZ7XiMpR24nWpoyoAku+vqN47pcPWITxMGXtoVJAxAcecrhmJzFO7tQnRI08F5pHMPRJnCgh0Hnfmz4QR256WvquXehzxcwtvtpPueyBQf5RMQsDPdMLbrYBm5uhba/ terraform-ssh-key"
}

variable "ssh_private_key" {
  #https://forums.oracle.com/ords/apexds/post/terraform-ssh-private-key-issue-9138
  type    = string
  default = <<EOF
EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# Network variables
# ---------------------------------------------------------------------------------------------------------------------
variable "ad_number" {
  default     = 0
  description = "Which availability domain to deploy, zero based."
}
variable "numberOfNodes" {
  default = 2
}

variable "igw_display_name" {
  default = "internet-gateway"
}

variable "vcn01_cidr_block" {
  default = "194.168.0.0/16"
}

variable "vcn01_lb_subnet_cidr_block" {
  default = "194.168.1.0/24"
}

variable "vcn01_compute_subnet_cidr_block" {
  default = "194.168.2.0/24"
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "lb_listener_port" {
  default = 80
}

variable "lb_listener_backend_port" {
  default = 80
}

variable "InstanceShape" {
  default = "VM.Standard2.8"
}

variable "InstanceFlexShapeOCPUS" {
  default = 1
}

variable "InstanceFlexShapeMemory" {
  default = 1
}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "9"
}

# --------------------------
# master instance variables
# --------------------------

variable "master_shape" {
  default = "VM.Standard2.8"
}

variable "master_disk_count" {
  default = 1
}

variable "master_disk_size" {
  default = 50
}

variable "password" {
  default = "admin123!"
}

variable "sites_string" {
  default = "site1,site2"
}

# --------------------------
# indexer instance variables
# --------------------------

variable "indexer_shape" {
  default = "VM.Standard2.4"
}

variable "indexer_disk_count" {
  default = 1
}

variable "indexer_disk_size" {
  default = 50
}

# ------------------------------
# search deployer instance variables
# ------------------------------

variable "search_deployer_shape" {
  default = "VM.Standard2.2"
}

variable "role_title" {
  default = "search_head_deployer"
}

# ------------------------------
# search head instance variables
# ------------------------------

variable "search_head_shape" {
  default = "VM.Standard2.2"
}

variable "search_head_count" {
  default = 2
}

variable "search_head_disk_count" {
  default = 1
}

variable "search_head_disk_size" {
  default = 50
}

variable "shc_pass" {
  default = "asdf4567"
}
variable "images" {
  type = map(string)
  default = {
    mx-queretaro-1 = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaamxqzcyqme44cjrfebyxqz6mcrlam4yjopyjgdhffc6xy7wxeysoa"
    sa-santiago-1  = "ocid1.image.oc1.sa-santiago-1.aaaaaaaahulxzohkmje5lshmebwly2z3v3xdumypcunqlhe3l3skb4d77rha"
    sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaqzkez5umgblxezzswl32yf7uqzeyrv63zpjmoi6e2vxyd2v3plaa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaaj6pcmnh6y3hdi3ibyxhhflvp3mj2qad4nspojrnxc6pzgn2w3k5q"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaa2wadtmv6j6zboncfobau7fracahvweue6dqipmcd5yj6s54f3wpq"
  }
}
variable "bucket_name" {
  type    = string
  default = "audit-events"
}
variable "bucket_namespace" {
  type    = string
  default = "grxmw2a9myyj"
}
variable "bucket_access_type" {
  type    = string
  default = "NoPublicAccess"
}

variable "user-data" {
  default = <<EOF
#!/bin/bash -x
# echo '########## yum update all ###############'
yum update -y

echo '########## basic webserver ##############'
yum install -y httpd openssl wget mod_ssl
systemctl enable --now httpd.service
firewall-cmd --add-service=http --persistent
firewall-cmd --add-port=80/tcp --persistent
firewall-cmd --reload
echo '<html><head></head><body><pre><code>' > /var/www/html/index.html
echo '<b>' $(hostname) '</b>'  >> /var/www/html/index.html
echo '' >> /var/www/html/index.html
#cat /etc/os-release >> /var/www/html/index.html
sudo mkdir -p /var/www/html/img
sudo wget  https://docs.oracle.com/en-us/iaas/Content/Resources/Images/loadBalancer3adRegional.png -O /var/www/html/img/loadbalancer-reg.png
sudo chown -R apache:apache  /var/www/html/
echo '<img src="img/loadbalancer-reg.png" alt="Load Balancer Regional">'>> /var/www/html/index.html
echo '</code></pre></body></html>' >> /var/www/html/index.html
EOF
}

#Windows specifications
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
  default     = "6"
}