############################
## Create VM Image - Main ##
############################

# Get List of Availability Domains
data "oci_identity_availability_domains" "ads" {
  #compartment_id = oci_identity_compartment.compartment.id
  compartment_id = var.oci_root_compartment
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
  display_name        = "${var.instance_name}-${var.environment}-vm"
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.oci_root_compartment

  shape               = var.instance_shape
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = var.instance_shape_mem
    ocpus                     = var.instance_shape_cpu
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    display_name     = "${var.instance_name}-${var.environment}-vm-nic"
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