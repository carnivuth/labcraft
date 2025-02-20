//locals{
//  dns_servers = [
//    {
//        name = "espeon"
//        address = "201"
//      },
//    {
//        name = "umbreon"
//        address = "202"
//      },
//  ]
//}

//resource "proxmox_lxc" "dns-test" {
//  count = 2
//  target_node     = var.proxmox_host
//  hostname        = "ct-test-${local.dns_servers[count.index].name}"
//  tags            = "test"
//  ostemplate      = var.prod_ct_template
//  password        = var.guest_password
//  unprivileged    = true
//  ssh_public_keys = var.ssh_pub_key
//  nameserver      = var.external_nameserver
//  cores           = 1
//  pool           = "test"
//  memory          = 512
//  onboot          = true
//  start           = true
//
//  rootfs {
//    storage = var.main_pool
//    size    = "8G"
//  }
//  network {
//    name   = "eth0"
//    bridge = "vmbr0"
//    ip     = "192.168.1.${local.dns_servers[count.index].address}/24"
//    gw     = var.guest_gw
//  }
//}
resource "proxmox_lxc" "lesgofile" {
  target_node     = var.proxmox_host
  hostname        = "lesgofile"
  tags            = "test"
  ostemplate      = var.prod_ct_template
  password        = var.guest_password
  unprivileged    = true
  ssh_public_keys = var.ssh_pub_key
  nameserver      = var.external_nameserver
  cores           = 4
  pool           = "test"
  memory          = 2084
  onboot          = true
  start           = true

  rootfs {
    storage = var.main_pool
    size    = "15G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.150/24"
    gw     = var.guest_gw
  }
}
