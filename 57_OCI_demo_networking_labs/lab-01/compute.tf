resource "oci_core_instance" "test_instance" {
  count               = 2
  availability_domain = var.adDomain
  compartment_id      = var.compartment
  shape               = "VM.Standard.E2.1.Micro"
  //shape               = "VM.Standard2.1"
  display_name = "server-${count.index + 1}"

  source_details {
    //All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    # Add image from - us-ashburn-1
    #source_id   = "ocid1.image.oc1.iad.aaaaaaaakv7vhpdllpbotmmjvxus3j5nh6wt2n43ddcg3cl5fnq5p6kngkza"
    # Add image from - is-sanjose-1
    source_id   = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa3stdbyfdqhcdykpzf7ndzwudklnp77wo5lym7rp33ysspk6o2m4q"
    source_type = "image"
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.test_subnet.id
  }

  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
  }
}
output "oci_core_instance" {
  value = [oci_core_instance.test_instance[0].private_ip, oci_core_instance.test_instance[1].private_ip]
}