
module "adf_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${(module.namedatalake.data_factory.name)}-pe" #"${title(module.key_vault.name)}-pe"
  location                       = var.location
  resource_group_name            = module.namedatalake.resource_group.name
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name] 
  tags                           = var.tags
  private_connection_resource_id = azurerm_mssql_server.aim.id
  is_manual_connection           = false
  subresource_name               = "sqlServer"
  private_dns_zone_group_name    = "SQLPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [module.sql_dns_zone.id]
}