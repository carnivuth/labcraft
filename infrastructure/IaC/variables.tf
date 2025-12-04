variable "proxmox_endpoint" {
  description = "url for proxmox api"
}

variable "proxmox_api_token" {
  description = "secret for proxmox api"
}

variable "ssh_pub_key" {
  description = "default ssh pub key"
}

variable "password" {
  description = "vms and containers password"
}
variable "dns_servers" {
  description = "dns servers"
}
