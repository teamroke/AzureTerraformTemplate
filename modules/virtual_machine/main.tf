#####################################################
# NIC 
# https://www.terraform.io/docs/providers/azurerm/r/network_interface.html
#####################################################
resource "azurerm_network_interface" "azure-tf-nic" {
  name                          = var.nic_name
  location                      = var.region
  resource_group_name           = var.resource_group
  # https://docs.microsoft.com/en-us/azure/virtual-network/create-vm-accelerated-networking-cli
  enable_accelerated_networking = var.nic_accelerated

  ip_configuration {
    name                          = var.ipconfiguration_name
    subnet_id                     = var.ipconfiguration_subnet_id
    private_ip_address_allocation = var.ipconfiguration_privateip_alloc
    private_ip_address            = var.ipconfiguration_privateip
  }
}
#####################################################
# Random ID
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
#####################################################
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.resource_group
  }
  byte_length    = 8
}

#####################################################
# Boot Diagnostic Storage Account
# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html
#####################################################
resource "azurerm_storage_account" "azure-tf-strg" {
  name                        = "${var.storage_accnt_name}${random_id.randomId.hex}"
  resource_group_name         = var.resource_group
  location                    = var.region
  account_tier                = var.storage_accnt_tier
  account_replication_type    = var.storage_accnt_replication
}

#####################################################
# Virtual Machine 
# https://www.terraform.io/docs/providers/azurerm/r/linux_virtual_machine.html
#####################################################
resource "azurerm_linux_virtual_machine" "azure-tf-vm" {
  name                  = var.vm_name
  location              = var.region
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.azure-tf-nic.id]
  size                  = var.vm_size

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  computer_name                   = var.computername
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.azure-tf-strg.primary_blob_endpoint
  }

  tags = var.tags
}
