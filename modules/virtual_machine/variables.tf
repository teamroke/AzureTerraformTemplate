#####################################################
# NIC Options
# https://www.terraform.io/docs/providers/azurerm/r/network_interface.html
#####################################################
variable "nic_name" {
  description = "NIC Name needs to be unique per resource group. Might want to name it after the cumputername followed by nic number."
  type        = string
}

variable "region" {
  description = "Location of the nsg should match the vnet location"
  type = string
}

variable "resource_group" {
  description = "Resource group name. Should be the infrastructure resource group"
  type        = string
}

# https://docs.microsoft.com/en-us/azure/virtual-network/create-vm-accelerated-networking-cli
variable "nic_accelerated" {
  description = "This is true or false"
  type        = bool
  default     = false
}

# Ip Configuration Section

variable "ipconfiguration_name" {
  description = "Name of ipconfiguration"
  type        = string
}

variable "ipconfiguration_subnet_id" {
  description = "subnet_id to attach the nic to"
  type        = string
}

variable "ipconfiguration_privateip_alloc" {
  description = "How to get the ip address of for the nic. Can be Dynamic or Static"
  type        = string
  default     = "Dynamic"
}

# This only takes effect if the above is set to static
variable "ipconfiguration_privateip" {
  description = "If the allocation for private ip is static you need to provide an ip address to give it from the allocation of ips in the subnet"
  type        = string
}

#####################################################
# Boot Diagnostic Storage Account Options
# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html
#####################################################
variable "storage_accnt_name" {
  description = "Prepend for the storage name. It will add an extra eight numbers to the end to make it globally unique."
  type        = string
}

# Region and resource gorup pulled from above.

variable "storage_accnt_tier" {
  description = "Tier should be Standard or Premium"
  type        = string
  default     = "Standard"  
}

variable "storage_accnt_replication" {
  description = "Replication for the accountt should be just LRS for most times"
  type        = string
  default     = "LRS"
}

#####################################################
# Virtual Machine 
# https://www.terraform.io/docs/providers/azurerm/r/linux_virtual_machine.html
#####################################################
variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

# Region and resource gorup pulled from above.
# NIC pulled from above

variable "vm_size" {
  description = "Pull from https://docs.microsoft.com/en-us/azure/virtual-machines/sizes"
  type        = string
}

# OS Disk section

variable "os_disk_name" {
  description = "Os Disk Name. Needs ot be unique"
  type        = string
}

variable "os_disk_caching" {
  description = "Caching on the OS Disk. Recommended read/write"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_type" {
  description = "Performance level. Should default to Standard_LRS for cost"
  type        = string
  default     = "Standard_LRS"
}

# End OS Disk section

# Source Image Section
# Look at the VM Image marketplace to see if something exists for your need. https://azuremarketplace.microsoft.com/en-us/marketplace/apps?filters=virtual-machine-images

variable "image_publisher" {
  description = "This will be provided by the publisher"
  type        = string
}

variable "image_offer" {
  description = "Provided byt he publisher"
  type        = string
}

variable "image_sku" {
  description = "Provided by the publisher"
  type        = string
}

variable "image_version" {
  description = "Provided by publisher"
  type        = string
}

# End Source Image Section

variable "computername" {
  description = "I orginally copied this fomra template so now we are stuck with it. If not present the name of the VM will be used"
  type       = string
}

variable "admin_username" {
  description = "The username to be used for the admi user"
  type        = string
}

variable "admin_password" {
  description = "Password for the above account"
  type        = string
}

variable "disable_password_authentication" {
  description = "Password authentication disabled by default. Set to false if you want to sign in with a password"
  type        = bool
}

#####################################################
# Tags
#####################################################

variable "tags" {
  description = "Tags for finding or sorting resources"
  type = map(string)
  default = {}
}