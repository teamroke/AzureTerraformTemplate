#####################################################
# SubNet
# https://www.terraform.io/docs/providers/azurerm/r/subnet.html
#####################################################
resource "azurerm_subnet" "azure-tf-snet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefix
}

#####################################################
# Network Security Group 
# https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html
#####################################################
resource "azurerm_network_security_group" "azure-tf-nsg" {
  name                = var.nsg_name
  location            = var.region
  resource_group_name = var.resource_group_name
  tags                = var.tags
}


#####################################################
# Subnet Association fro the NSG
# https://www.terraform.io/docs/providers/azurerm/r/subnet_network_security_group_association.html
#####################################################
resource "azurerm_subnet_network_security_group_association" "azure-tf-genmomics-nsg" {
  subnet_id                 = azurerm_subnet.azure-tf-snet.id
  network_security_group_id = azurerm_network_security_group.azure-tf-nsg.id
}

# data "azurerm_network_security_group" "azure-tf-nsg" {
#   name                = azurerm_network_security_group.azure-tf-nsg.name
#   resource_group_name = azurerm_network_security_group.azure-tf-nsg.resource_group_name
#   id                  = azurerm_network_security_group.azure-tf-nsg.id
#   depends_on          = [azurerm_network_security_group.azure-tf-nsg]
# }

# data "azurerm_subnet" "azure-tf-snet" {
#   name                 = azurerm_subnet.azure-tf-snet.name 
#   resource_group_name  = azurerm_subnet.azure-tf-snet.resource_group_name
#   virtual_network_name = azurerm_subnet.azure-tf-snet.virtual_network_name
#   id                   = azurerm_subnet.azure-tf-snet.id
#   depends_on           = [azurerm_subnet.azure-tf-snet]
# }