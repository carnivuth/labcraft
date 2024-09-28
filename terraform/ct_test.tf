
# VIRTUAL MACHINES
resource "proxmox_vm_qemu" "provisioner" {
  name        = "provisioner"
  tags        = "test"
  cores       = 4
  sockets     = 1
  memory      = 4096
  target_node = var.proxmox_host
  clone       = "arch-cloudinit-template"
  ipconfig0   = "gw=192.168.1.1,ip=192.168.1.201/24"
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

resource "proxmox_lxc" "ct-test" {
  target_node     = var.proxmox_host
  hostname        = "ct-test"
  tags            = "test;reverse_proxy;grocy"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 1
  memory          = 512
  onboot          = true
  start           = true
  //hookscript      = "local:snippets/update.sh"

  rootfs {
    storage = var.main_pool
    size    = "8G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.200/24"
    gw     = var.guest_gw
  }
}
