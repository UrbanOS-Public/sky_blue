
module "key_vault" {
  source                          = "./modules/key_vault"
  name                            = replace(module.namedatalake.key_vault.name,"adl","adf")
  location                        = var.location
  resource_group_name             = module.namedatalake.resource_group.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.key_vault_sku_name
  tags                            = var.tags
  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  enable_rbac_authorization       = var.key_vault_enable_rbac_authorization
  purge_protection_enabled        = var.key_vault_purge_protection_enabled
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
  bypass                          = var.key_vault_bypass
  default_action                  = var.key_vault_default_action
  log_analytics_workspace_id      = data.azurerm_log_analytics_workspace.law.id
  log_analytics_retention_days    = var.log_analytics_retention_days
  public_network_access_enabled   = var.public_network_access_enabled
}


resource "azurerm_key_vault_access_policy" "agent" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id # "9863e455-912b-49b6-a143-4fb3c35918f1"

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]
  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  storage_permissions =[
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  depends_on = [ 
    module.key_vault
  ]
}

resource "azurerm_key_vault_access_policy" "kv_adf_identity" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.adf_identity.principal_id 

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]
  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  storage_permissions =[
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  depends_on = [ 
    module.key_vault,
    azurerm_user_assigned_identity.adf_identity
  ]
}


resource "azurerm_key_vault_access_policy" "kv_adf" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_data_factory.adf.identity.0.principal_id

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]
  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  storage_permissions =[
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  depends_on = [ 
    module.key_vault,
    azurerm_data_factory.adf
  ]
}


module "key_vault_private_endpoint" {
  source                         = "./modules/private_endpoint"
  name                           = "${replace(module.namedatalake.key_vault.name,"adl","adf")}-pe" #"${title(module.key_vault.name)}-pe"
  location                       = var.location
  resource_group_name            = module.namedatalake.resource_group.name
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name] 
  tags                           = var.tags
  private_connection_resource_id = module.key_vault.id #data.azurerm_resources.key_vault.resources[0].id #
  is_manual_connection           = false
  subresource_name               = "vault"
  private_dns_zone_group_name    = "KeyVaultPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [data.azurerm_private_dns_zone.vault.id] #[module.key_vault_private_dns_zone.id]
}


resource "azurerm_data_factory_linked_service_key_vault" "example" {
  name            = replace(module.namedatalake.key_vault.name,"adl","adf")
  data_factory_id = azurerm_data_factory.adf.id
  key_vault_id    = module.key_vault.id
  integration_runtime_name = "vnetRuntime"
  description = "Keyvault linked to Azure Data Factory"


  depends_on = [ 
    module.key_vault,
    module.key_vault_private_endpoint,
    azurerm_data_factory_integration_runtime_azure.aim,
    azurerm_data_factory.adf
  ]
}