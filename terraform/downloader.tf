
resource "proxmox_lxc" "metapod" {
  target_node     = var.proxmox_host
  hostname        = "metapod"
  tags            = "reverse_proxy"
  pool            = "prod"
  ostemplate      = var.dev_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.nameserver
  cores           = 2
  memory          = 2048
  onboot          = true
  start           = true

  features {
    nesting = true
  }
  rootfs {
    storage = var.main_pool
    size    = "80G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.100/24"
    gw     = var.guest_gw
  }
}
