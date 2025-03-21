variable "region" {
  default = "West Europe"
}

variable "vm_size" {
  default = "Standard_B1ms"
}

variable "aks_node_size" {
  default = "Standard_B2s"
}

variable "resource_group_name" {
  default = "rg-terraform-practica"
}

variable "virtual_network_name" {
  default = "my-vnet"
}

variable "virtual_subnetwork_name" {
  default = "my-subnet"
}

variable "public_ip_name" {
  default = "vm-public-ip"
}

variable "acr_name" {
  default = "jodelaencdevops"
}

variable "aks_name" {
  default = "aks_practica"
}

variable "dns_aks_name" {
  default = "aksdnspractica"
}