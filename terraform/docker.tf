resource "proxmox_vm_qemu" "docker" {
  name        = "docker"
  tags        = "docker"
  pool        = "test"
  cores       = 4
  sockets     = 1
  memory      = 4096
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
          size    = "40G"
          storage = var.main_pool
        }
      }
    }
  }
}
