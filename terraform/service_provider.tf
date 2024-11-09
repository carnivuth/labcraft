terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = var.pm_tls_insecure
}

# VIRTUAL MACHINES
resource "proxmox_vm_qemu" "wailord" {
  name        = "wailord"
  tags        = "service_manager"
  cores       = 8
  sockets     = 1
  memory      = 16384
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

# LXC CONTAINERS
//resource "proxmox_lxc" "dedenne" {
//  target_node     = var.proxmox_host
//  hostname        = "dedenne"
//  ostemplate      = var.dev_ct_template
//  password        = var.guest_password
//  unprivileged    = true
//  ssh_public_keys = var.ssh_pub_key
//  nameserver      = var.nameserver
//  cores           = 4
//  memory          = 4096
//  onboot          = true
//  start           = true
//
//  rootfs {
//    storage = var.main_pool
//    size    = "50G"
//  }
//
//  network {
//    name   = "eth0"
//    bridge = "vmbr0"
//    ip     = "192.168.1.91/24"
//    gw     = var.guest_gw
//  }
//}
