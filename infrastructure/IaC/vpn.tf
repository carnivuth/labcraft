#resource "proxmox_virtual_environment_container" "malamar" {
#  description = "vpn server"
#  tags        = ["vpn","test"]
#  pool_id = "test"
#
#  node_name = "pve"
#  vm_id     = 205
#
#  unprivileged = true
#
#  features {
#    nesting = true
#  }
#
#  initialization {
#    hostname = "malamar"
#
#    dns {
#      domain = "carnivuth.org"
#      servers = ["192.168.1.96","192.168.1.97"]
#
#    }
#    ip_config {
#      ipv4 {
#        address = "192.168.1.205/24"
#        gateway = "192.168.1.1"
#      }
#    }
#
#    user_account {
#      keys = [
#        var.ssh_pub_key
#      ]
#      password= var.password
#    }
#  }
#
#  network_interface {
#    name = "veth0"
#  }
#
#  disk {
#    datastore_id = "local-lvm"
#    size         = 5
#  }
#
#  operating_system {
#    template_file_id = proxmox_virtual_environment_download_file.debian_ct_cloud_image.id
#    type             = "debian"
#  }
#
#
#  startup {
#    order      = "3"
#  }
#}
