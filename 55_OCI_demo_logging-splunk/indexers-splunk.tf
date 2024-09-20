resource "oci_core_instance" "indexer" {
  display_name        = "splunk-indexer-${count.index}"
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  #availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[var.ad_number]["name"]
  #fault_domain        = "FAULT-DOMAIN-${(count.index % 3) + 1}"
  #shape               = var.InstanceShape
  shape = var.indexer_shape

  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }

  create_vnic_details {
    #subnet_id    = !var.use_existing_vcn ? oci_core_subnet.vcn01_compute_subnet[0].id : var.compute_subnet_id
    subnet_id    = !var.use_existing_vcn ? oci_core_subnet.vcn01_lb_subnet[0].id : var.compute_subnet_id
    display_name = "primaryvnic"
    //hostname_label = "splunk-indexer-${count.index}"   
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
          file("scripts/indexer.sh"),
          data.template_cloudinit_config.cloud_init.rendered
        ],
      ),
    )}"
  }

  extended_metadata = {
    config = jsonencode(
      {
        "shape"            = var.indexer_shape
        "disk_count"       = var.indexer_disk_count
        "disk_size"        = var.indexer_disk_size
        "site_string"      = element(split(",", var.sites_string), count.index)
        "count"            = count.index
        "master_public_ip" = oci_core_instance.master.public_ip
      },
    )
  }

  count = length(split(",", var.sites_string))
}
