#####################################################
# Network Security Rule Options
# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
#####################################################

variable "securityrule_name" {
  description = "Name of this security roup. Try to make it releavant."
  type        = string
}

variable "securityrule_priority" {
  description = "Priority as a digit. Start at 100 and move up. Must be unuqiwue for the security group."
  type        = number
}

variable "securityrule_direction" {
  description = "Can be Inbound or Outbound"
  type        = string
}

variable "securityrule_access" {
  description = "Can be Allow or Deny"
  type        = string
  default     = "Allow"
}

variable "securityrule_protocol" {
  description = "Can be UDP or TCP. Most likely TCP"
  type        = string
  default     = "Tcp"
}

variable "securityrule_source_portrange" {
  description = "A string but really a number. default is *"
  type        = string
  default     = "*"
}

variable "securityrule_destination_portrange" {
  description = "A string but really a number. default is *"
  type        = string
  default     = "*"
}

variable "securityrule_source_prefix" {
  description = "Either CIDR or IP Address list . default is *"
  type        = string
  default     = "*"
}

variable "securityrule_destination_prefix" {
  description = "Either CIDR or IP Address list . default is *"
  type        = string
  default     = "*"
}

variable "resource_group" {
  description = "Resourcegroup name. Should be the infrastructure resource group"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group to assign this too"
  type        = string
}

