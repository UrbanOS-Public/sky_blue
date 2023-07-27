
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