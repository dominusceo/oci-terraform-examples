resource "local_file" "inventory" {
  directory_permission = "0700"
  file_permission      = "0600"
  content = templatefile("${var.templates_path}backends-frontends.tftpl",
    {
      user   = var.ansible_user,
      prefix = "srv",
      fronts = oci_core_instance.test_instance[*].public_ip,
      backs  = oci_core_instance.test_instance[*].private_ip
    }
  )
  filename = "${var.inventory_path}${var.inventory_file}"
  #filename             = "${path.module}${var.inventory_file}"
}

resource "local_file" "ansible_variables" {
  directory_permission = "0700"
  file_permission      = "0600"
  content              = data.template_file.init.rendered
  filename             = "ansible-vars.json"
}
resource "local_file" "add_ssh_key" {
  filename             = "add-ssh-key.sh"
  directory_permission = "0700"
  file_permission      = "0600"
  content              = <<EOF
!#/bin/bash
#Autor: Ricardo D. Carrillo <ricardo.d.carrillo@oracle.com>
#Goal: Add ssh frontends keys where the ansible user will connect to.
echo "Adding SSH Key to each host:"
ssh-add ${var.ansible_ssh_private_key}
echo "Adding IPs:"
%{for ip in oci_core_instance.test_instance[*].public_ip}
ssh-keyscan -H ${ip} >> ~/.ssh/known_hosts
%{endfor}
EOF
}
