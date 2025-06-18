## Control Plane
#resource "proxmox_vm_qemu" "traefik" {
#  name        = "traefik"
#  tags        = "test"
#  pool        = "test"
#  cores       = 4
#  sockets     = 1
#  memory      = 4192
#  target_node = var.proxmox_host
#  clone       = "ubuntu-2404-cloudinit-template"
#  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.211/24"
#  scsihw      = "virtio-scsi-pci"
#  boot        = "order=scsi0;net0"
#  cipassword  = var.guest_password
#  ciuser      = var.guest_user
#  sshkeys     = var.ssh_pub_key
#  nameserver  = var.nameserver
#  onboot      = false
#  vm_state    = "running"
#
#  connection {
#    type     = "ssh"
#    user     = "root"
#    password = var.guest_password
#    host     = "192.168.1.211"
#  }
#
#  disks {
#    ide {
#      ide2 {
#        cloudinit {
#          storage = var.main_pool
#        }
#      }
#    }
#    scsi {
#      scsi0 {
#        disk {
#          size    = "50G"
#          storage = var.main_pool
#        }
#      }
#    }
#  }
#}
