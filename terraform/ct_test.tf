resource "proxmox_lxc" "ct-test" {
  target_node     = var.proxmox_host
  hostname        = "ct-test"
  tags            = "test;reverse_proxy;grocy"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 1
  memory          = 512
  onboot          = true
  start           = true
  //hookscript      = "local:snippets/update.sh"

  rootfs {
    storage = var.main_pool
    size    = "8G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.200/24"
    gw     = var.guest_gw
  }
}
