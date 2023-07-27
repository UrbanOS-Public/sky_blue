resource "azurerm_key_vault_key" "cmk_metastore" {
  name         = "cmk-adl-adf"
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P360D"
    notify_before_expiry = "P29D"
  }
}

module "metastore" {
  source                      = "./modules/storage_account"
  name                        = module.nameadb.data_lake_store.name
  location                    = var.location
  resource_group_name         = module.nameadb.resource_group.name
  account_kind                = var.storage_account_kind
  account_tier                = var.storage_account_tier
  replication_type            = var.storage_account_replication_type
  key_vault_id                = data.azurerm_resources.key_vault.resources[0].id
  key_vault_key_name          = azurerm_key_vault_key.cmk_metastore.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  is_hns_enabled              = var.is_hns_enabled
  tags                        = var.tags
}

resource "azurerm_role_assignment" "blob_contributor_admin" {
  count = length(var.admin_group_object_ids)
  scope                = module.metastore.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.admin_group_object_ids[count.index]
  depends_on = [ 
    module.metastore
  ]
}


 resource "azurerm_storage_data_lake_gen2_filesystem" "metastore" {
   storage_account_id = module.metastore.id
   name               = "metastore"
 }


 resource "azurerm_storage_data_lake_gen2_path" "aim" {
   path               = "aim"
   filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.metastore.name
   storage_account_id = module.metastore.id
   resource           = "directory"
 }


module "diagnostic_settings" {
  source = "./modules/diagnostic_setting"
  diagnostics_settings_name  = "DiagnosticSettings"
  target_resource_id         = module.metastore.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  logs                       = [
                                  "allLogs"
                               ]
  metrics                    = [
                                 "Transaction", "Capacity"
                               ]
  retention_policy_days      = var.retention_policy_days
}