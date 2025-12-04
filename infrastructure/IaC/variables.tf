variable "proxmox_endpoint" {
  description = "url for proxmox api"
}

variable "proxmox_api_token" {
  description = "secret for proxmox api"
}

variable "ssh_keys" {
  description = "default ssh pub key"
}

variable "dns_servers" {
  description = "dns servers"
}
