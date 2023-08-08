module "blob_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${module.nameadb.databricks_workspace.name}-adl-pe"
  location                       = var.location
  resource_group_name            = module.nameadb.resource_group.name
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id  # #module.spoke_network.subnet_ids[var.vm_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = module.metastore.id #data.azurerm_storage_account.st.id #
  is_manual_connection           = false
  subresource_name               = "blob"
  private_dns_zone_group_name    = "BlobPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [data.azurerm_private_dns_zone.blob.id] #[module.blob_private_dns_zone.id]
}


module "db_uiapi" {
  source                         = "./modules/private_endpoint"
  name                           = "${module.nameadb.databricks_workspace.name}-adb-uiapi-pe"
  location                       = var.location
  resource_group_name            = module.nameadb.resource_group.name
  subnet_id                      = azurerm_subnet.dp_transit.id  # #module.spoke_network.subnet_ids[var.vm_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = azurerm_databricks_workspace.dp_workspace.id
  is_manual_connection           = false
  subresource_name               = "databricks_ui_api"
  private_dns_zone_group_name    = "private-dns-zone-uiapi"
  private_dns_zone_group_ids     = [module.adb_dns_zone.id] #[module.blob_private_dns_zone.id]
}

module "db_auth" {
  source                         = "./modules/private_endpoint"
  name                           = "${module.nameadb.databricks_workspace.name}-adb-auth-pe"
  location                       = var.location
  resource_group_name            = module.nameadb.resource_group.name
  subnet_id                      = azurerm_subnet.dp_transit.id  # #module.spoke_network.subnet_ids[var.vm_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = azurerm_databricks_workspace.dp_workspace.id
  is_manual_connection           = false
  subresource_name               = "browser_authentication"
  private_dns_zone_group_name    = "private-dns-zone-auth"
  private_dns_zone_group_ids     = [module.adb_dns_zone.id] #[module.blob_private_dns_zone.id]
}