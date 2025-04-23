resource "proxmox_lxc" "koha" {
  target_node     = var.proxmox_host
  hostname        = "koha"
  tags            = "test"
  pool        = "test"
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
    size    = "50G"
  }
  features {
    nesting = true
  }
 mountpoint {
    key     = "0"
    slot    = 0
    storage = var.backup2_pool
    mp      = "/mnt/datastore"
    size    = "1000G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.222/24"
    gw     = var.guest_gw
  }
}
