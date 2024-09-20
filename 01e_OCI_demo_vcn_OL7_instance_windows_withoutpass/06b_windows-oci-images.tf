####################
## List VM Images ##
####################
# Get latest Windows Server 2019 Virtual Machine image
data "oci_core_images" "windows-2019" {
  compartment_id      = var.oci_root_compartment
  operating_system = "Windows"
  filter {
    name   = "display_name"
    values = ["^Windows-Server-2019-Standard-Edition-VM-([\\.0-9-]+)$"]
    regex  = true
  }
}