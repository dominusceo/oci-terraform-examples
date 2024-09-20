####################
## List VM Images ##
####################
# Get latest Windows Server 2019 Virtual Machine image
data "oci_core_images" "windows-2019" {
  compartment_id   = var.compartment_ocid
  operating_system = "Windows"
  filter {
    name   = "display_name"
    values = ["^Windows-Server-2019-Standard-Edition-VM-([\\.0-9-]+)$"]
    regex  = true
  }
}

# Template Bootstrap File
data "template_file" "bootstrap" {
  template = file("${path.module}/userdata/bootstrap.ps1")
}

# Cloudinit Config
data "template_cloudinit_config" "cloudinit_config" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "bootstrap.ps1"
    content_type = "text/x-shellscript"
    content      = data.template_file.bootstrap.rendered
  }
}

# Create Virtual Machine Instance 
resource "oci_core_instance" "windows" {
  display_name        = "windows-01"
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  compartment_id      = var.compartment_ocid

  shape = var.instance_shape
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = var.instance_shape_mem
    ocpus                     = var.instance_shape_cpu
  }

  create_vnic_details {
    subnet_id        = !var.use_existing_vcn ? oci_core_subnet.vcn01_lb_subnet[0].id : var.lb_subnet_id
    display_name     = "winvnicprimary"
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.windows-2019.images.0.id
  }

  metadata = {
    user_data = data.template_cloudinit_config.cloudinit_config.rendered
  }
}

# Get Virtual Machine Instance Credentials
data "oci_core_instance_credentials" "api_credential" {
  depends_on  = [oci_core_instance.windows]
  instance_id = oci_core_instance.windows.id
}