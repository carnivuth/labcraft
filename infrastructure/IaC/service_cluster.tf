resource "proxmox_lxc" "snorlax" {
  target_node     = var.proxmox_host
  hostname        = "snorlax"
  tags            = "prod;red;nfs"
  ostemplate      = var.debian_12_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 1
  memory          = 2048
  onboot          = true
  start           = true

  rootfs {
    storage = var.main_pool
    size    = "8G"
  }
  features {
    nesting = true
  }
 mountpoint {
    key     = "0"
    slot    = 0
    storage = var.data_pool
    mp      = "/mnt/"
    size    = "200G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.101/24"
    gw     = var.guest_gw
  }
}
