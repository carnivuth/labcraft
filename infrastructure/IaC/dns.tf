resource "proxmox_virtual_environment_container" "glaceon" {
  description = "Dns server"
  tags        = ["dns","test"]
  pool_id = "test"

  node_name = "pve"
  vm_id     = 201

  unprivileged = true

  features {
    nesting = true
  }

  initialization {
    hostname = "glaceon"

    dns {
      domain = "carnivuth.org"
      servers = ["192.168.1.96","192.168.1.97"]

    }
    ip_config {
      ipv4 {
        address = "192.168.1.201/24"
        gateway = "192.168.1.1"
      }
    }

    user_account {
      password = var.password
      keys = [
        var.ssh_pub_key
      ]
    }
  }

  network_interface {
    name = "veth0"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 5
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.debian_ct_cloud_image.id
    type             = "debian"
  }


  startup {
    order      = "1"
  }
}
resource "proxmox_virtual_environment_container" "flareon" {
  description = "Dns server"
  tags        = ["dns","test"]
  pool_id = "test"

  node_name = "pve"
  vm_id     = 202

  unprivileged = true

  features {
    nesting = true
  }

  initialization {
    hostname = "flareon"

    dns {
      domain = "carnivuth.org"
      servers = ["192.168.1.96","192.168.1.97"]

    }
    ip_config {
      ipv4 {
        address = "192.168.1.208/24"
        gateway = "192.168.1.1"
      }
    }

    user_account {
      password = var.password
      keys = [
        var.ssh_pub_key
      ]
    }
  }

  network_interface {
    name = "veth0"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 5
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.debian_ct_cloud_image.id
    type             = "debian"
  }


  startup {
    order      = "2"
  }
}
