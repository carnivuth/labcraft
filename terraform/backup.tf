
resource "proxmox_lxc" "ditto" {
  target_node     = var.proxmox_host
  hostname        = "ditto"
  tags            = "pbs;backup_3ds"
  ostemplate      = var.prod_ct_template
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
 mountpoint {
    key     = "0"
    slot    = 0
    storage = var.backup2_pool
    mp      = "/mnt/datastore/backup"
    size    = "1000G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.93/24"
    gw     = var.guest_gw
  }
}
