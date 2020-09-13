#####################################################
# Managed Disk Options
# https://www.terraform.io/docs/providers/azurerm/r/managed_disk.html
#####################################################

variable "managed_disk_name" {
  description = "Managed disk name. This needs to be unique across the board."
  type        = string
}

variable "region" {
  description = "Location of the managed disk should match the VM location"
  type = string
}

variable "resourge_group" {
  description = "Resource group for the managed disk. should match the VM resource group."
  type = string
}

variable "managed_disk_account_type" {
  description = "Managed disk account type"
  type        = string
  default     = "Standard_LRS"
}

variable "managed_disk_create_option" {
  description = "How to create the disk. Will usually be empty."
  type        = string
  default     = "Empty"
}

variable "managed_disk_size" {
  description = "Managed Disk Size in GB"
  type        = number
}


#####################################################
# Connect the disk to a VM
# https://www.terraform.io/docs/providers/azurerm/r/virtual_machine_data_disk_attachment.html
#####################################################

variable "virtual_machine" {
  description = "Virtual Machine ID to attach the disk to"
  type        = ID
}

variable "disk_lun" {
  description = "LUN to use for the disk on the VM as a string. Must be unique per VM"
  type        = string
}

variable "disk_caching" {
  description = "What type of caching to have for the disk"
  type        = string
  default     = "None"
}

#####################################################
# Tags
#####################################################

variable "tags" {
  description = "Tags for finding or sorting resources"
  type = map(string)
  default = {}
}