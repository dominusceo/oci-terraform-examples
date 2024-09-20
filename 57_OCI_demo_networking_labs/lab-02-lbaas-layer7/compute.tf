resource "oci_core_instance" "test_instance" {
  count               = 2
  availability_domain = var.ad-domain
  compartment_id      = var.compartment_ocid
  shape               = var.instance_shape
  display_name = "server-${count.index + 1}"

  source_details {
    #All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    source_id   = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaaphf2lkmclgfoms3r5y6f4ioxi72hdo4r53qaoa2igyelbz4ldp7q"
    source_type = "image"
  }
  shape_config {
    #Optional
    #baseline_ocpu_utilization = "BASELINE_1_8"
    memory_in_gbs = "32"
    ocpus = "4"
  }
  create_vnic_details {
    subnet_id = oci_core_subnet.priv_subnet2.id
  }

  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
    user_data           = base64encode(var.user-data)
  }
}