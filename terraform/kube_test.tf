## Control Plane
#resource "proxmox_vm_qemu" "cp" {
#  name        = "cp"
#  tags        = "test,kubernetes_control_plane"
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
# provisioner "local-exec" {
#    command = "ansible-playbook -i inventory/inventory.proxmox.yml playbooks/kubernetes.yml -l cp"
#    working_dir = "../"
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
#
## Workers
#resource "proxmox_vm_qemu" "worker1" {
#  name        = "worker1"
#  tags        = "test,kubernetes_worker"
#  pool        = "test"
#  cores       = 4
#  sockets     = 1
#  memory      = 8192
#  target_node = var.proxmox_host
#  clone       = "ubuntu-2404-cloudinit-template"
#  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.212/24"
#  scsihw      = "virtio-scsi-pci"
#  boot        = "order=scsi0;net0"
#  cipassword  = var.guest_password
#  ciuser      = var.guest_user
#  sshkeys     = var.ssh_pub_key
#  nameserver  = var.nameserver
#  onboot      = false
#  vm_state    = "running"
# provisioner "local-exec" {
#    command = "ansible-playbook -i inventory/inventory.proxmox.yml playbooks/kubernetes.yml -l worker1"
#    working_dir = "../"
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
#resource "proxmox_vm_qemu" "worker2" {
#  name        = "worker2"
#  tags        = "test,kubernetes_worker"
#  pool        = "test"
#  cores       = 4
#  sockets     = 1
#  memory      = 8192
#  target_node = var.proxmox_host
#  clone       = "ubuntu-2404-cloudinit-template"
#  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.213/24"
#  scsihw      = "virtio-scsi-pci"
#  boot        = "order=scsi0;net0"
#  cipassword  = var.guest_password
#  ciuser      = var.guest_user
#  sshkeys     = var.ssh_pub_key
#  nameserver  = var.nameserver
#  onboot      = false
#  vm_state    = "running"
# provisioner "local-exec" {
#    command = "ansible-playbook -i inventory/inventory.proxmox.yml playbooks/kubernetes.yml -l worker2"
#    working_dir = "../"
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
#
#resource "proxmox_vm_qemu" "worker3" {
#  name        = "worker3"
#  tags        = "test,kubernetes_worker"
#  pool        = "test"
#  cores       = 4
#  sockets     = 1
#  memory      = 8192
#  target_node = var.proxmox_host
#  clone       = "ubuntu-2404-cloudinit-template"
#  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.214/24"
#  scsihw      = "virtio-scsi-pci"
#  boot        = "order=scsi0;net0"
#  cipassword  = var.guest_password
#  ciuser      = var.guest_user
#  sshkeys     = var.ssh_pub_key
#  nameserver  = var.nameserver
#  onboot      = false
#  vm_state    = "running"
# provisioner "local-exec" {
#    command = "ansible-playbook -i inventory/inventory.proxmox.yml playbooks/kubernetes.yml -l worker3"
#    working_dir = "../"
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
