resource "oci_core_volume" "test_volume" {
  count          = 2
  compartment_id = var.compartment
  size_in_gbs    = 50
  #display_name        = "bv_oci_lab"
  display_name        = "bv_oci_lab-${format("%01d", count.index + 1)}"
  availability_domain = var.ad-domain
}

resource "oci_core_volume_attachment" "test_volume_attachment" {
  count           = 2
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.test_instance[count.index].id
  display_name    = oci_core_instance.test_instance[count.index].display_name
  volume_id       = oci_core_volume.test_volume[count.index].id
  connection {
    type = "ssh"
    #host        = "self.private_ip"
    host        = oci_core_instance.test_instance[count.index].public_ip
    user        = "opc"
    timeout     = "3m"
    private_key = file("tf-private.key")
  }
  provisioner "remote-exec" {
    //when       = destroy
    on_failure = continue
    inline = [
      "sudo iscsiadm -m node -o new -T ${self.iqn} -p ${self.ipv4}:${self.port}",
      "sudo iscsiadm -m node -o update -T ${self.iqn} -n node.startup -v automatic",
      "sudo iscsiadm -m node -T ${self.iqn} -p ${self.ipv4}:${self.port} -l",
      "sudo parted /dev/sdb mklabel gpt ; sudo parted /dev/sdb mkpart primary ext4 0% 100% ; sudo parted /dev/sdb name 1 my-data",
      "sudo mkfs.ext4 /dev/sdb1",
      "sudo mkdir -p /data; sudo mount /dev/sdb1 /data",
    ]
  }
}
