resource "proxmox_virtual_environment_vm" "kttack" {
  name      = "kttack"
  node_name = "pve"
  vm_id     = 206
  pool_id = "test"
  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true
  tags        = ["k3s_master"]

  initialization {
    user_account {
      # do not use this in production, configure your own ssh key instead!
      username = "user"
      password = "password"
    }
    dns {
        domain = "carnivuth.org"
        servers = ["192.168.1.96","192.168.1.97"]

      }
    ip_config {
      ipv4 {
        address = "192.168.1.206/24"
        gateway = "192.168.1.1"
      }
    }
  }
  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = proxmox_virtual_environment_download_file.debian_vm_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 50
  }
}

