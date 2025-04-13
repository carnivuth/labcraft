# VIRTUAL MACHINES
resource "proxmox_vm_qemu" "kube" {
  name        = "kube"
  tags        = "test"
  pool        = "test"
  cores       = 4
  sockets     = 1
  memory      = 8192
  target_node = var.proxmox_host
  clone       = "ubuntu-2404-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.211/24"
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
          size    = "50G"
          storage = var.main_pool
        }
      }
    }
  }
}
