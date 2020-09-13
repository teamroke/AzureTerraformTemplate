# https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
resource "azurerm_virtual_network" "azure-tf-vnet" {
  name                = var.virtual_net_name
  address_space       = var.virtual_network_address_space
  location            = var.region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

data "azurerm_virtual_network" "azure-tf-vnet" {
  name                = azurerm_virtual_network.azure-tf-vnet.name
  resource_group_name = azurerm_virtual_network.azure-tf-vnet.resource_group_name
  depends_on          = [azurerm_virtual_network.azure-tf-vnet]
}