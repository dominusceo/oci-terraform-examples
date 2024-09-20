resource "oci_core_instance" "test_instance" {
  count               = 2
  availability_domain = var.adDomain
  compartment_id      = var.compartment
  shape               = var.instanceShape
  display_name        = "server-${count.index + 1}"
  source_details {
    #All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    source_id   = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa3stdbyfdqhcdykpzf7ndzwudklnp77wo5lym7rp33ysspk6o2m4q"
    source_type = "image"
  }

  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCV5PvhexjNfIGBtC+j5Yu+aQk+cZ8Ua6tEy2X3tjkMiV4OurfYaH0A+0PCwwwRIb8AFyJxW4y9Cq2l+B0jExhPckUC42xr33U4fb/fDS8IgO8Y0pbkLF9PZbBDtgUNcp9mgheLic4W7bXYT1S1VhFkte1f4cq4gF/XsAnU+cj+1QBDr0FU2leoac87BheI6yGB/i7lSww6Fvpl4otThVuoC92tIuOXNMPSLBpsI+igNoA+4PUhySLix/4CKYBUYmmYsZX4+rN3qRRk+Z2JiosdVV6EndzeyChJ50TNxJVp7SIc6/YS+k/zsSx9d/W2W5rSDRB1WeEKMa+Q7RuKYxx/ terraform-ssh-key"
  }
  create_vnic_details {
    subnet_id = oci_core_subnet.priv_subnet1.id
  }

  /*
 connection {
    type        = "ssh"
    host        = "self.public_ip"
    #host       = self.test_instance[count.index].public_ip
    user        = "opc"
    timeout     = "3m"
    private_key = file("~/.ssh/tf-private.key")
 }
*/
  #depends_on = [local_file.inventory]
  /*  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ansible_user} -i '${var.inventory_path}${var.inventory_file}' --private-key ${var.ansible_ssh_private_key} setup-terraform-infra.yaml -T 300 --extra-vars @ansible-vars.json"
  }
*/
}

resource "oci_core_instance_configuration" "test_instance" {
  count          = 2
  compartment_id = var.compartment
  display_name   = oci_core_instance.test_instance[count.index].display_name
  instance_details {
    instance_type = "compute"
    launch_details {
      #compartment_id = var.compartment
      freeform_tags = { "CostCenter" = "SJC" }
      agent_config {
        are_all_plugins_disabled = false
        is_management_disabled   = false
      }
    }
  }
}

output "nodes_managed" {
  value = [oci_core_instance.test_instance[*].private_ip, oci_core_instance.test_instance[*].public_ip]
  #depends_on = [local_file.inventory]
}
