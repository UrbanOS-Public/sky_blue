module "acr_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${module.namespoke.container_registry.name}-pe"
  location                       = var.location
  resource_group_name            = module.namespoke.resource_group.name
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = data.azurerm_container_registry.container_registry.id #module.container_registry.id
  is_manual_connection           = false
  subresource_name               = "registry"
  private_dns_zone_group_name    = "AcrPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [module.acr_private_dns_zone.id]
}

module "key_vault_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${(module.namespoke.key_vault.name)}-pe" #"${title(module.key_vault.name)}-pe"
  location                       = var.location
  resource_group_name            = module.namespoke.resource_group.name
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = data.azurerm_resources.key_vault.resources[0].id #module.key_vault.id
  is_manual_connection           = false
  subresource_name               = "vault"
  private_dns_zone_group_name    = "KeyVaultPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [module.key_vault_private_dns_zone.id]
}

module "blob_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${(module.namespoke.storage_account.name)}-pe"
  location                       = var.location
  resource_group_name            = module.namespoke.resource_group.name
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name]
  tags                           = var.tags
  private_connection_resource_id = data.azurerm_storage_account.st.id #module.storage_account.id
  is_manual_connection           = false
  subresource_name               = "blob"
  private_dns_zone_group_name    = "BlobPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [module.blob_private_dns_zone.id]
}