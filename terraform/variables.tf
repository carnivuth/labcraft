variable "ssh_pub_key" {
  description = "default ssh pub key"
}
variable "storage_pool" {
  default     = "local-lvm"
  description = "proxmox storage for volumes"
}
variable "nameserver" {
  description = "network nameserver"
}
variable "external_nameserver" {
  description = "network nameserver"
}
variable "proxmox_host" {
  default     = "pve"
  description = "proxmox host where to store variables"
}
variable "pm_api_url" {
  description = "url for proxmox api"
}
variable "pm_api_token_id" {
  description = "token for proxmox api"
}
variable "pm_api_token_secret" {
  description = "secret for proxmox api"
}
variable "pm_tls_insecure" {
  default     = "true"
  description = "verify certificate"
}
variable "guest_user" {
  description = "user for ct/vm"
}
variable "guest_password" {
  description = "password for ct/vm"
}
variable "guest_gw" {
  default     = "192.168.1.1"
  description = "gateway for containers"
}
variable "dev_ct_template" {
  default     = "local:vztmpl/archlinux-base_20230608-1_amd64.tar.zst"
  description = "template for development containers"
}
variable "prod_ct_template" {
  default     = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  description = "template for production containers"
}

