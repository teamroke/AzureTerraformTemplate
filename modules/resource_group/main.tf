#####################################################
# Resouce Group
# https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
#####################################################
resource "azurerm_resource_group" "azure-tf-rg" {
  name     = var.resourcegroup_name
  location = var.region
  tags     = var.tags
}

data "azurerm_resource_group" "azure-tf-rg" {
  name = azurerm_resource_group.azure-tf-rg.name
  depends_on = [azurerm_resource_group.azure-tf-rg]
}