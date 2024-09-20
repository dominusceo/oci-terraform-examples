##################################################################################
# Create compute Instance for OCI VCN
##################################################################################
resource "oci_core_instance" "oci-vcn-pub-instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "oci-vcn-pub-instance"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id                 = oci_core_subnet.oci-vcn-subnet.id
    display_name              = "Primaryvnic"
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = "oci-vcn-pub-subnet-vnic"
  }
  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region["mx"]]
  }
  shape_config {
    #Optional
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
    ocpus = var.instance_shape_config_ocpus
  }
  metadata = {
    ssh_authorized_keys = file(var.public_key_path)
  }
}

resource "oci_core_instance" "oci-vcn-priv-instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "oci-vcn-priv-instance"
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id                 = oci_core_subnet.oci-vcn-priv-subnet.id
    display_name              = "Primaryvnic"
    assign_public_ip          = false
    assign_private_dns_record = true
    hostname_label            = "oci-vcn-priv-subnet-vnic"
  }
  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region["mx"]]
  }
  shape_config {
    #Optional
    memory_in_gbs = var.instance_shape_config_memory_in_gbs
    ocpus = var.instance_shape_config_ocpus
  }
  metadata = {
    ssh_authorized_keys = file(var.public_key_path)
  }
}

// Gets a list of VNIC attachments on the instance
data "oci_core_vnic_attachments" "oci-vcn-pub-instance-vnics" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domain.ad.name
  instance_id         = oci_core_instance.oci-vcn-pub-instance.id
}
// Gets the OCID of the first (default) VNIC
data "oci_core_vnic" "oci-vcn-pub-instance-vnics" {
  vnic_id = data.oci_core_vnic_attachments.oci-vcn-pub-instance-vnics.vnic_attachments[0]["vnic_id"]
}

// List Private IPs
data "oci_core_private_ips" "oci-vcn-priv-ip-datasource" {
  vnic_id = data.oci_core_vnic.oci-vcn-pub-instance-vnics.id
}