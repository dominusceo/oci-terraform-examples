#Variables declared in this file must be declared in the marketplace.yaml

############################
#  Hidden Variable Group   #
############################
variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID"
}
variable "user_ocid" {
  type        = string
  description = "User  OCIDfor authentication"
}

variable "fingerprint" {
  type        = string
  description = "Fingerprint for authentication"
}

variable "region" {
  type        = string
  description = "tenancy region"
}
variable "compartment_ocid" {
  type        = string
  description = "Compartment ocid"
}

variable "private_key_path" {
  type        = string
  description = "SSH key path"
}
variable "network_firewall_policy_id" {
  type        = string
  description = "network_firewall_policy_id"
}
############################
#  Compute Configuration   #
############################

# variable "vm_display_name" {
#   description = "Instance Name"
#   default     = "client-vm"
# }

# variable "vm_display_name_application" {
#   description = "Instance Name"
#   default     = "application-vm"
# }

variable "vm_compute_shape" {
  description = "Compute Shape"
  default     = "VM.Standard.E4.Flex"
}

variable "spoke_vm_compute_shape" {
  description = "Compute Shape"
  default     = "VM.Standard.E4.Flex"
}

variable "vm_flex_shape_ocpus" {
  description = "Flex Shape OCPUs"
  default     = 1
}

variable "spoke_vm_flex_shape_ocpus" {
  description = "Spoke VMs Flex Shape OCPUs"
  default     = 1
}
variable "availability_domain_name" {
  default     = "ERDj:MX-QUERETARO-1-AD-1"
  description = "Availability Domain"
}

variable "availability_domain_number" {
  default     = 1
  description = "OCI Availability Domains: 1,2,3  (subject to region availability)"
}

variable "ssh_public_key" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/"
  description = "SSH Public Key String"
}

variable "instance_launch_options_network_type" {
  description = "NIC Attachment Type"
  default     = "PARAVIRTUALIZED"
}

############################
#  Network Configuration   #
############################

variable "network_strategy" {
  default = "Create New VCN and Subnet"
}

variable "oci_network_firewall_vcn_id" {
  default = ""
}

variable "application_vcn_id" {
  default = ""
}

variable "oci_network_firewall_vcn_display_name" {
  description = "Firewall VCN Name"
  default     = "firewall-vcn"
}

variable "oci_network_firewall_vcn_cidr_block" {
  description = "OCI Network Firewall VCN CIDR"
  default     = "10.10.0.0/16"
}

variable "oci_network_firewall_vcn_dns_label" {
  description = "Firewall VCN DNS Label"
  default     = "firewall"
}

variable "subnet_span" {
  description = "Choose between regional and AD specific subnets"
  default     = "Regional Subnet"
}

variable "oci_network_firewall_subnet_id" {
  default = ""
}

variable "oci_network_firewall_subnet_display_name" {
  description = "Firewall Subnet Name"
  default     = "firewall-subnet"
}

variable "oci_network_firewall_subnet_cidr_block" {
  description = "Firewall Subnet CIDR"
  default     = "10.10.0.0/24"
}

variable "oci_network_firewall_subnet_dns_label" {
  description = "Firewall Subnet DNS Label"
  default     = "firewall"
}

variable "client_subnet_id" {
  default = ""
}

variable "client_subnet_display_name" {
  description = "Client Subnet Name"
  default     = "client-subnet"
}

variable "client_subnet_cidr_block" {
  description = "Client Subnet CIDR"
  default     = "10.10.1.0/24"
}

variable "client_subnet_dns_label" {
  description = "Client Subnet DNS Label"
  default     = "client"
}

variable "server_subnet_id" {
  default = ""
}

variable "server_subnet_display_name" {
  description = "Server Subnet Name"
  default     = "server-subnet"
}

variable "server_subnet_cidr_block" {
  description = "Server Subnet CIDR"
  default     = "10.10.2.0/24"
}

variable "server_subnet_dns_label" {
  description = "Server Subnet DNS Label"
  default     = "server"
}

variable "application_vcn_cidr_block" {
  description = "Application VCN CIDR Block"
  default     = "10.20.0.0/16"
}

variable "application_vcn_dns_label" {
  description = "Spoke Application VCN DNS Label"
  default     = "spoke"
}

variable "application_vcn_display_name" {
  description = "Spoke Application VCN Display Name"
  default     = "spoke-vcn"
}

variable "application_compute_subnetA_id" {
  default = ""
}

variable "application_compute_subnetA_cidr_block" {
  description = "ServerA Subnet CIDR Block"
  default     = "10.20.1.0/24"
}

variable "application_compute_subnetA_display_name" {
  description = "ServerA Subnet Display Name"
  default     = "serverA-subnet"
}

variable "application_compute_subnetA_dns_label" {
  description = "ServerA Subnet DNS Label"
  default     = "serverA"
}

variable "application_compute_subnetB_id" {
  default = ""
}

variable "application_compute_subnetB_cidr_block" {
  description = "ServerB Subnet CIDR Block"
  default     = "10.20.2.0/24"
}

variable "application_compute_subnetB_display_name" {
  description = "ServerB Subnet Display Name"
  default     = "serverB-subnet"
}

variable "application_compute_subnetB_dns_label" {
  description = "ServerB Subnet DNS Label"
  default     = "serverB"
}

############################
# Additional Configuration #
############################

variable "oci_network_firewall_policy_action" {
  description = "Security Policy Action"
  default     = "ALLOW"
}

variable "oci_network_firewall_name" {
  description = "OCI Network Firewall Name"
  default     = "oci-network-firewall-demo"
}

############################
# Additional Configuration #
############################

variable "compute_compartment_ocid" {
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "Compartment where Compute and Marketplace subscription resources will be created"
}
variable "network_compartment_id" {
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "network_compartment_id"
}
variable "network_compartment_ocid" {
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "Compartment where Network resources will be created"
}

variable "nsg_whitelist_ip" {
  description = "Network Security Groups - Whitelisted CIDR block for ingress communication: Enter 0.0.0.0/0 or <your IP>/32"
  default     = "0.0.0.0/0"
}

variable "nsg_display_name" {
  description = "Network Security Groups - Name"
  default     = "firewall-vcn-security-group"
}

variable "spoke_nsg_display_name" {
  description = "Network Security Groups - Spoke"
  default     = "spoke-security-group"
}

variable "template_name" {
  description = "Template name. Should be defined according to deployment type"
  default     = "oci-network-firewall"
}

variable "template_version" {
  description = "Template version"
  default     = "20200724"
}

######################
#    Enum Values     #   
######################
variable "network_strategy_enum" {
  type = map(any)
  default = {
    CREATE_NEW_VCN_SUBNET   = "Create New VCN and Subnet"
    USE_EXISTING_VCN_SUBNET = "Use Existing VCN and Subnet"
  }
}

variable "subnet_type_enum" {
  type = map(any)
  default = {
    transit_subnet    = "Private Subnet"
    MANAGEMENT_SUBENT = "Public Subnet"
  }
}

variable "nsg_config_enum" {
  type = map(any)
  default = {
    BLOCK_ALL_PORTS = "Block all ports"
    OPEN_ALL_PORTS  = "Open all ports"
    CUSTOMIZE       = "Customize ports - Post deployment"
  }
}
