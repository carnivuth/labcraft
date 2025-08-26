
resource "proxmox_lxc" "ditto" {
  target_node     = var.proxmox_host
  hostname        = "ditto"
  tags            = "backup"
  ostemplate      = var.debian_12_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 6
  memory          = 4096
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
    storage = var.backup_pool
    mp      = "/mnt/datastore"
    size    = "2000G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.93/24"
    gw     = var.guest_gw
  }
}
