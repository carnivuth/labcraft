resource "proxmox_lxc" "umbreon" {
  target_node     = var.proxmox_host
  hostname        = "umbreon"
  tags            = "dns"
  pool            = "prod"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 1
  memory          = 512
  onboot          = true
  start           = true

  rootfs {
    storage = var.main_pool
    size    = "8G"
  }
  features {
    nesting = true
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.97/24"
    gw     = var.guest_gw
  }
}
resource "proxmox_lxc" "espeon" {
  target_node     = var.proxmox_host
  hostname        = "espeon"
  tags            = "dns"
  pool            = "prod"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 1
  memory          = 512
  onboot          = true
  start           = true

  rootfs {
    storage = var.main_pool
    size    = "8G"
  }

  features {
    nesting = true
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.96/24"
    gw     = var.guest_gw
  }
}
