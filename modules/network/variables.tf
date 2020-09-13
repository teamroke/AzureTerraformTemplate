#####################################################
# Virtual Netowrk Options
# https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
#####################################################

variable "virtual_net_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Virtual Network IP Range"
  type        = list(string)
}

variable "region" {
  description = "Region it is located in."
  type = string
}

variable "resource_group_name" {
  description = "Resource Group. Should be the Infrastructure group for the project"
  type        = string
}

#####################################################
# Tags
#####################################################

variable "tags" {
  description = "Tags for finding or sorting resources"
  type = map(string)
  default = {}
}