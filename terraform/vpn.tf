resource "proxmox_lxc" "arcanine" {
  target_node     = var.proxmox_host
  hostname        = "arcanine"
  tags        = "vpn"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.nameserver
  cores           = 2
  memory          = 2048
  onboot          = true
  start           = true

  rootfs {
    storage = var.main_pool
    size    = "20G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.95/24"
    gw     = var.guest_gw
  }
}
