output "network_security_group" {
  value = azurerm_network_security_group.azure-tf-nsg
}

output "subnet" {
  value = azurerm_subnet.azure-tf-snet
}