resource "oci_core_instance" "search-head" {
  display_name        = "splunk-search-head-${count.index}"
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[var.ad_number]["name"]
  shape               = var.search_head_shape

  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }

  create_vnic_details {
    #subnet_id    = !var.use_existing_vcn ? oci_core_subnet.vcn01_compute_subnet[0].id : var.compute_subnet_id
    subnet_id        = !var.use_existing_vcn ? oci_core_subnet.vcn01_lb_subnet[0].id : var.compute_subnet_id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }
  provisioner "local-exec" {
    command = "sleep 340"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = "${base64encode(
      join(
        "\n",
        [
          "#!/usr/bin/env bash",
          file("scripts/metadata.sh"),
          file("scripts/disks.sh"),
          file("scripts/search_head.sh"),
          data.template_cloudinit_config.cloud_init.rendered
        ],
      ),
    )}"
  }

  extended_metadata = {
    config = jsonencode(
      {
        "shape"       = var.search_deployer_shape
        "role_title"  = "search_head_deployer"
        "password"    = var.password
        "shc_pass"    = var.shc_pass
        "deployer_ip" = oci_core_instance.search-deployer.public_ip
      },
    )
  }
  count        = var.search_head_count
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
