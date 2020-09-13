#####################################################
# SubNet Options
# https://www.terraform.io/docs/providers/azurerm/r/subnet.html
#####################################################

variable "subnet_name" {
  description = "The name fore the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Resourcegroup name. Should be the infrastructure resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network to attach it to."
  type        = string
}

variable "subnet_address_prefix" {
  description = "This is address range for the subnet. Must be a valid subnet of the virtual network"
  type        = list(string)
}

#####################################################
# Network Security Group Options
# https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html
#####################################################

variable "nsg_name" {
  description = "The name fore the nsg"
  type        = string
}

variable "region" {
  description = "Location of the nsg should match the vnet location"
  type = string
}

# resouce group pulled from above.

#####################################################
# Subnet Association fro the NSG options.
# https://www.terraform.io/docs/providers/azurerm/r/subnet_network_security_group_association.html
#####################################################

# Subnet is pulled from the subnet created above.
# Network security group is pulled form the one created above.

#####################################################
# Tags
#####################################################

variable "tags" {
  description = "Tags for finding or sorting resources"
  type = map(string)
  default = {}
}