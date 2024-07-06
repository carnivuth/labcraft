resource "proxmox_lxc" "avalug" {
  target_node     = var.proxmox_host
  hostname        = "avalug"
  tags            = "develop"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.nameserver
  cores           = 2
  memory          = 512
  onboot          = true
  start           = true

  rootfs {
    storage = var.storage_pool
    size    = "8G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.98/24"
    gw     = var.guest_gw
  }
}
