locals{
  dns_servers = [
    {
        name = "espeon"
        address = "96"
      },
    {
        name = "umbreon"
        address = "97"
      },
  ]
}
resource "proxmox_lxc" "dns-test" {
  count = 2
  target_node     = var.proxmox_host
  hostname        = "ct-test-${local.dns_servers[count.index].name}"
  tags            = "test"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 1
  pool           = "test"
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
    ip     = "192.168.1.${local.dns_servers[count.index].address}/24"
    gw     = var.guest_gw
  }
}
