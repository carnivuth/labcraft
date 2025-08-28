resource "proxmox_vm_qemu" "avalug" {
  name        = "avalug"
  tags        = "docker;service_manager;red;prod"
  pool        = "prod"
  cores       = 4
  sockets     = 1
  memory      = 8192
  target_node = var.proxmox_host
  clone       = "debian-13-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.202/24"
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0;net0"
  cipassword  = var.guest_password
  ciuser      = var.guest_user
  sshkeys     = var.ssh_pub_key
  nameserver  = var.nameserver
  onboot      = true
  vm_state    = "running"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.main_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "250G"
          storage = var.main_pool
        }
      }
      scsi1 {
        disk {
          size    = "500G"
          storage = var.data_pool
        }
      }
    }
  }
}

resource "proxmox_vm_qemu" "wailord" {
  name        = "wailord"
  tags        = "docker;test"
  pool        = "prod"
  cores       = 4
  sockets     = 1
  memory      = 8192
  target_node = var.proxmox_host
  clone       = "ubuntu-2404-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.94/24"
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0;net0"
  cipassword  = var.guest_password
  ciuser      = var.guest_user
  sshkeys     = var.ssh_pub_key
  nameserver  = var.nameserver
  onboot      = true
  vm_state    = "running"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.main_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "400G"
          storage = var.main_pool
        }
      }
    }
  }
}
