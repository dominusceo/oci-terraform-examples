data "template_file" "master-ssh" {
  template = file("${path.module}/scripts/sshkey.tpl")
  vars = {
    ssh_public_key = tls_private_key.public_private_key_pair.public_key_openssh
  }
}

data "template_cloudinit_config" "cloud-init-master" {
  gzip          = true
  base64_encode = true
  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.master-ssh.rendered
  }
}
data "template_cloudinit_config" "metadata" {
  gzip          = true
  base64_encode = true
  part {
    filename     = "metadata.sh"
    content_type = "text/x-shellscript"
    content      = file("scripts/metadata.sh")
  }
}
data "template_cloudinit_config" "disk" {
  gzip          = true
  base64_encode = true
  part {
    filename     = "disks.sh"
    content_type = "text/x-shellscript"
    content      = file("scripts/disks.sh")
  }
}
data "template_cloudinit_config" "master" {
  gzip          = true
  base64_encode = true
  part {
    filename     = "master.sh"
    content_type = "text/x-shellscript"
    content      = file("./scripts/master.sh")
  }
}

resource "oci_core_instance" "master" {
  display_name        = "splunk-master"
  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  shape               = var.master_shape

  create_vnic_details {
    #subnet_id        = !var.use_existing_vcn ? oci_core_subnet.vcn01_compute_subnet[0].id : var.compute_subnet_id
    subnet_id        = !var.use_existing_vcn ? oci_core_subnet.vcn01_lb_subnet[0].id : var.compute_subnet_id
    display_name     = "primaryvnic"
    assign_public_ip = true
  }
  /*
  source_details {
    source_id   = var.images[var.region]
    source_type = "image"
  }
*/
  source_details {
    source_type             = "image"
    source_id               = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
    boot_volume_size_in_gbs = "50"
  }

  provisioner "local-exec" {
    command = "sleep 340"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    //user_data    = base64encode(join("\n",[data.template_cloudinit_config.cloud-init-master.rendered,data.template_cloudinit_config.metadata.rendered,data.template_cloudinit_config.disk.rendered,data.template_cloudinit_config.master.rendered]))
    user_data = base64encode(
      join(
        "\n",
        [
          "#!/usr/bin/env bash",
          file("scripts/metadata.sh"),
          file("scripts/disks.sh"),
          file("scripts/master.sh"),
        ],
      ),
    )
  }

  extended_metadata = {
    config = jsonencode(
      {
        "shape"        = var.master_shape
        "disk_count"   = var.master_disk_count
        "disk_size"    = var.master_disk_size
        "password"     = var.password
        "sites_string" = var.sites_string
      },
    )
  }

  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

