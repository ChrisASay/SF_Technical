variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

variable "datacenter" {}
variable "datastore" {}
variable "cluster" {}

variable "external_network" {}
variable "internal_network" {}

variable "template" {}

variable "vm_name" {
  default = "ubuntu‑secure"
}

variable "external_ip" {}
variable "internal_ip" {}
variable "gateway" {}