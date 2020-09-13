#####################################################
# Network Security Rule
# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
#####################################################
resource "azurerm_network_security_rule" "azure-tf-securityrule" {
  name                        = var.securityrule_name
  priority                    = var.securityrule_priority
  direction                   = var.securityrule_direction
  access                      = var.securityrule_access
  protocol                    = var.securityrule_protocol
  source_port_range           = var.securityrule_source_portrange
  destination_port_range      = var.securityrule_destination_portrange
  source_address_prefix       = var.securityrule_source_prefix
  destination_address_prefix  = var.securityrule_destination_prefix
  resource_group_name         = var.resource_group
  network_security_group_name = var.nsg_name
}