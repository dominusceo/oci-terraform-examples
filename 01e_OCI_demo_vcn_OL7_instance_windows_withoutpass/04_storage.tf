resource "oci_core_volume" "storage_volume" {

  compartment_id = var.oci_root_compartment
  size_in_gbs    = 50
  display_name        = "bv_oci_windows"
  availability_domain = var.availability_domains[0]
}

/*
resource "oci_core_volume_attachment" "storage_attachment" {
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.windows.id
  display_name    = oci_core_instance.windows.display_name
  volume_id       = oci_core_volume.storage_volume.id
    connection {
        type     = "winrm"
        insecure = true
        https    = true
        port     = 5986
        host     = "${oci_core_instance.windows.public_ip}"
        user     = "${data.oci_core_instance_credentials.api_credential.username}"
        password = "${data.oci_core_instance_credentials.api_credential.password}"
    }
  provisioner "remote-exec" {
    inline = [
      "  Powershell New-IscsiTargetPortal –TargetPortalAddress ${self.ipv4}",
      "  Powershell Connect-IscsiTarget -NodeAddress ${self.iqn} -TargetPortalAddress ${self.ipv4} -IsPersistent $True",
    ]
  }  # disconnect and unregister on destroy
  provisioner "remote-exec" {
    #when       = "destroy"
    #on_failure = "continue"  
    inline = [
      "  Powershell \"Get-IscsiTargetPortal -TargetPortalAddress ${self.ipv4} | ForEach-Object {Get-IscsiSession -IscsiTargetPortal $_} | ForEach-Object {Unregister-IscsiSession -SessionIdentifier $_.SessionIdentifier}\"",
      "  Powershell Disconnect-IscsiTarget -NodeAddress ${self.iqn} -Confirm:$false",
      "  Powershell Remove-IscsiTargetPortal -TargetPortalAddress ${self.ipv4} -Confirm:$false",
    ]
  }
}
*/
# Attach the new block volume to the Windows compute instance after it is created
resource oci_core_volume_attachment storage_volume_attach {
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.windows.id
  volume_id       = oci_core_volume.storage_volume.id
}