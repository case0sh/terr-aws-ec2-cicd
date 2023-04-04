variable "do_token" {
  description = "DigitalOcean API token"
    type        = string
    sensitive   = true
}
variable "ssh_name" {
  description   = "Ssh keys in DigitalOcean"
    type        = string
    default     = "case" 
}
variable "droplet_image" {
  description   = "Image identifier of the OS in DigitalOcean"
    type        = string
    default     = "ubuntu-20-04-x64"
}
variable "droplet_region" {
  description = "Droplet region identifier where the droplet will be created"
    type        = string
    default = "fra1"
}
variable "droplet_size" {
  description = "Droplet size identifier"
    type        = string
    default = "s-1vcpu-2gb"
}
variable "user" {
  description = "Username"
    type        = string
    default = "root"
}
variable "privatekeypath" {
  description = "Privat ssh key"
    type        = string
    default = "~/.ssh/id_ed25519"
}

variable "publicekeypath" {
  description = "Public ssh key"
    type        = string
    default = "~/.ssh/id_ed25519.pub"
}

