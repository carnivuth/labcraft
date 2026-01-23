resource "proxmox_virtual_environment_vm" "kentra" {
  name      = "kentra"
  node_name = "pve"
  vm_id     = 206

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true
  tags        = ["k3s_master"]

  initialization {

    user_account {
      username = "root"
      keys     = var.ssh_keys
    }
    dns {
      domain = "carnivuth.org"
      servers = var.dns_servers
    }
    ip_config {
      ipv4 {
        address = "192.168.1.206/24"
        gateway = "192.168.1.1"
      }
    }
  }
  cpu {
    cores = 4
  }

  memory {
    dedicated = 4096
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

resource "proxmox_virtual_environment_pool" "kentra" {
  pool_id = "kentra"
}

resource "proxmox_virtual_environment_pool_membership" "kentra_vm_membership" {
  pool_id = proxmox_virtual_environment_pool.kentra.id
  vm_id   = proxmox_virtual_environment_vm.kentra.id
}
