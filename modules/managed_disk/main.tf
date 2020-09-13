# Primary DB disks Disks
resource "azurerm_managed_disk" "azure-tf-manageddisk" {
  name                 = var.managed_disk_name
  location             = var.region
  resource_group_name  = var.resourge_group
  storage_account_type = var.managed_disk_account_type
  create_option        = var.managed_disk_create_option
  disk_size_gb         = var.managed_disk_size
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "azure-tf-vmdisk" {
  managed_disk_id    = azurerm_managed_disk.manageddisk.id
  virtual_machine_id = var.virtual_machine
  lun                = var.disk_lun
  caching            = var.disk_caching
}