
#resource "proxmox_virtual_environment_vm" "wailord" {
#  name      = "wailord"
#  node_name = "pve"
#  vm_id     = 204
#  pool_id = "test"
#  # should be true if qemu agent is not installed / enabled on the VM
#  stop_on_destroy = true
#  tags        = ["service_runner","blue_cluster","test"]
#
#  initialization {
#    user_account {
#      # do not use this in production, configure your own ssh key instead!
#      username = "user"
#      password = "password"
#    }
#    dns {
#        domain = "carnivuth.org"
#        servers = ["192.168.1.96","192.168.1.97"]
#
#      }
#    ip_config {
#      ipv4 {
#        address = "192.168.1.204/24"
#        gateway = "192.168.1.1"
#      }
#    }
#  }
#  network_device {
#    bridge = "vmbr0"
#  }
#
#  disk {
#    datastore_id = "data"
#    import_from  = proxmox_virtual_environment_download_file.debian_vm_cloud_image.id
#    interface    = "virtio0"
#    iothread     = true
#    discard      = "on"
#    size         = 30
#  }
#}
#
#resource "proxmox_virtual_environment_vm" "snorlax" {
#  name      = "snorlax"
#  node_name = "pve"
#  vm_id     = 203
#  pool_id = "test"
#
#  # should be true if qemu agent is not installed / enabled on the VM
#  stop_on_destroy = true
#  tags        = ["nfs","blue_cluster","test"]
#
#  initialization {
#    user_account {
#      # do not use this in production, configure your own ssh key instead!
#      username = "user"
#      password = var.password
#    }
#    dns {
#        domain = "carnivuth.org"
#        servers = ["192.168.1.96","192.168.1.97"]
#
#      }
#    ip_config {
#      ipv4 {
#        address = "192.168.1.203/24"
#        gateway = "192.168.1.1"
#      }
#    }
#  }
#  network_device {
#    bridge = "vmbr0"
#  }
#
#  disk {
#    datastore_id = "data"
#    import_from  = proxmox_virtual_environment_download_file.debian_vm_cloud_image.id
#    interface    = "virtio0"
#    iothread     = true
#    discard      = "on"
#    size         = 400
#  }
#}
