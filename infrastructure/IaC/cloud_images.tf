resource "proxmox_virtual_environment_download_file" "debian_vm_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = "https://cloud.debian.org/images/cloud/trixie/20250814-2204/debian-13-generic-amd64-20250814-2204.qcow2"
  # need to rename the file to *.qcow2 to indicate the actual file format for import
  file_name = "trixie-server-cloudimg-amd64.qcow2"
}
resource "proxmox_virtual_environment_download_file" "debian_ct_cloud_image" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve"
  url          = "http://download.proxmox.com/images/system/debian-13-standard_13.1-2_amd64.tar.zst"
}
