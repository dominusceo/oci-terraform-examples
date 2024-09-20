resource "oci_core_instance" "search-deployer" {
  display_name   = "splunk-search-deployer"
  compartment_id = var.compartment_ocid
  #availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[var.ad_number]["name"]
  #fault_domain        = "FAULT-DOMAIN-${(count.index % 3) + 1}"
  #shape               = var.InstanceShape
  shape = var.search_deployer_shape

  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }

  create_vnic_details {
    #subnet_id        = !var.use_existing_vcn ? oci_core_subnet.vcn01_compute_subnet[0].id : var.compute_subnet_id
    subnet_id        = !var.use_existing_vcn ? oci_core_subnet.vcn01_lb_subnet[0].id : var.compute_subnet_id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }
  provisioner "local-exec" {
    command = "sleep 240"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = "${base64encode(
      join("\n",
        [
          "#!/usr/bin/env bash",
          file("scripts/metadata.sh"),
          file("scripts/disks.sh"),
          file("scripts/search_deployer.sh"),
        ],
      ),
    )}"
  }

  extended_metadata = {
    config = jsonencode(
      {
        "shape"      = var.search_deployer_shape
        "role_title" = "search_head_deployer"
        "password"   = var.password
      },
    )
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
