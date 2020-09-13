# Configure the Microsoft Azure Provider
provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

# Resouce group for Oracle.
module "resource_group" {
  source               = "../modules/resource_group"
  resourcegroup_name   = "core_resource_group"
  region               = var.region

  tags   = {
        environment = "Core"
    }
}

# Create virtual network
module "virtual_network" {
  source                        = "../modules/network"
  virtual_net_name              = "core_network"
  virtual_network_address_space = ["10.25.136.0/21"]
  resource_group_name           = module.resource_group.resource_group.name
  region                        = var.region
  tags = {
          environment = "Core"
          }
}

# Create subnet, network security group and security rules
module "subnet_nsg" {
  source = "../modules/subnet_nsg"

  # Create subnet
  subnet_name           = "core_subnet"
  resource_group_name    = module.resource_group.resource_group.name
  virtual_network_name  = module.virtual_network.virtual_network.name
  subnet_address_prefix = ["10.25.137.0/24"]

  # Create Network Security Group
  nsg_name = "core-nsg"
  region   = var.region
}

module "sr_ssh" {
  source = "../modules/network_security_rule"
  securityrule_name                  = "SSH"
  securityrule_priority              = 100
  securityrule_direction             = "Inbound"
  securityrule_access                = "Allow"
  securityrule_protocol              = "Tcp"
  securityrule_source_portrange      = "*"
  securityrule_destination_portrange = "22"
  securityrule_source_prefix         = "VirtualNetwork"
  securityrule_destination_prefix    = "VirtualNetwork"
  resource_group                     = module.resource_group.resource_group.name
  nsg_name                           = module.subnet_nsg.network_security_group.name
}

module "sr_oracle" {
  source = "../modules/network_security_rule"
  securityrule_name                  = "Oracle"
  securityrule_priority              = 101
  securityrule_direction             = "Inbound"
  securityrule_access                = "Allow"
  securityrule_protocol              = "Tcp"
  securityrule_source_portrange      = "*"
  securityrule_destination_portrange = "1521"
  securityrule_source_prefix         = "VirtualNetwork"
  securityrule_destination_prefix    = "VirtualNetwork"
  resource_group                     = module.resource_group.resource_group.name
  nsg_name                           = module.subnet_nsg.network_security_group.name
}

module "sr_oem" {
  source = "../modules/network_security_rule"
  securityrule_name                  = "OracleEnterpriseManager"
  securityrule_priority              = 102
  securityrule_direction             = "Inbound"
  securityrule_access                = "Allow"
  securityrule_protocol              = "Tcp"
  securityrule_source_portrange      = "*"
  securityrule_destination_portrange = "5502"
  securityrule_source_prefix         = "VirtualNetwork"
  securityrule_destination_prefix    = "VirtualNetwork"
  resource_group                     = module.resource_group.resource_group.name
  nsg_name                           = module.subnet_nsg.network_security_group.name
}

module "sr_occ" {
  source = "../modules/network_security_rule"
  securityrule_name                  = "OracleCloudControl"
  securityrule_priority              = 103
  securityrule_direction             = "Inbound"
  securityrule_access                = "Allow"
  securityrule_protocol              = "Tcp"
  securityrule_source_portrange      = "*"
  securityrule_destination_portrange = "7788"
  securityrule_source_prefix         = "VirtualNetwork"
  securityrule_destination_prefix    = "VirtualNetwork"
  resource_group                     = module.resource_group.resource_group.name
  nsg_name                           = module.subnet_nsg.network_security_group.name
}

module "sr_lb" {
  source = "../modules/network_security_rule"
  securityrule_name                  = "AllowLB"
  securityrule_priority              = 1000
  securityrule_direction             = "Inbound"
  securityrule_access                = "Allow"
  securityrule_protocol              = "Tcp"
  securityrule_source_portrange      = "*"
  securityrule_destination_portrange = "*"
  securityrule_source_prefix         = "AzureLoadBalancer"
  securityrule_destination_prefix    = "*"
  resource_group                     = module.resource_group.resource_group.name
  nsg_name                           = module.subnet_nsg.network_security_group.name
}

module "sr_din" {
  source = "../modules/network_security_rule"
  securityrule_name                  = "DenyInBound"
  securityrule_priority              = 1001
  securityrule_direction             = "Inbound"
  securityrule_access                = "Deny"
  securityrule_protocol              = "Tcp"
  securityrule_source_portrange      = "*"
  securityrule_destination_portrange = "*"
  securityrule_source_prefix         = "VirtualNetwork"
  securityrule_destination_prefix    = "VirtualNetwork"
  resource_group                     = module.resource_group.resource_group.name
  nsg_name                           = module.subnet_nsg.network_security_group.name
}

module "main_vm" {
  source = "../modules/virtual_machine" 

  nic_name                        = "main_nic01"
  region                          = var.region
  resource_group                  = module.resource_group.resource_group.name
  ipconfiguration_name            = "main_ip_config"
  ipconfiguration_subnet_id       = module.subnet_nsg.subnet.id
  ipconfiguration_privateip       = ""

  vm_name                         = "main"
  vm_size                         = "Standard_A1_v2"
  os_disk_name                    = "mainvm_os_disk"
  storage_accnt_name              = "main"

  image_publisher                 = "Canonical"
  image_offer                     = "UbuntuServer"
  image_sku                       = "18.04-LTS"
  image_version                   = "latest"
  computername                    = "main"
  admin_username                  = "ThisIsNotAdmin"
  admin_password                  = "Th!sIsN0tAnAdminPassword"
  disable_password_authentication = false
}