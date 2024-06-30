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



resource "proxmox_lxc" "dedenne" {
  target_node     = var.proxmox_host
  hostname        = "dedenne"
  ostemplate      = var.dev_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key

  // Terraform will crash without rootfs defined
  rootfs {
    storage = var.storage_pool
    size    = "50G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.85/24"
    gw     = var.guest_gw
  }
}
