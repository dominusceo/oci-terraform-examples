# -------- get the list of available ADs
data oci_identity_availability_domains demo39t1-ADs {
  provider       = oci.tenant1
  compartment_id = var.tenant1_tenancy_ocid
}

# --------- Get the OCID for the most recent for Oracle Linux 7.x disk image
data oci_core_images ImageOCID-ol7-t1 {
  provider                 = oci.tenant1
  compartment_id           = var.tenant1_compartment_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"

  # filter to avoid Oracle Linux 7.x images for GPU and ARM
  filter {
    name   = "display_name"
    values = ["^.*Oracle-Linux-7.9-202.*$"]
    regex  = true
  }
}
