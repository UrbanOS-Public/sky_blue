resource "azurerm_key_vault_key" "cmk_storage" {
  name         = "cmk-storage"
  key_vault_id = module.key_vault.id
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

  depends_on = [ 
    module.key_vault,
    azurerm_key_vault_access_policy.agent,
    azurerm_key_vault_access_policy.admin
  ]

}

module "storage_account" {
  source                      = "./modules/storage_account"
  name                        = module.namedatalake.data_lake_store.name #_unique
  location                    = var.location
  resource_group_name         = azurerm_resource_group.data.name
  account_kind                = var.storage_account_kind
  account_tier                = var.storage_account_tier
  replication_type            = var.storage_account_replication_type
  key_vault_id                = module.key_vault.id
  key_vault_key_name          = azurerm_key_vault_key.cmk_storage.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  is_hns_enabled              = var.is_hns_enabled
  tags                        = var.tags
}


resource "azurerm_storage_data_lake_gen2_filesystem" "rawdata" {
  storage_account_id = module.storage_account.id
  name               = "datastory"
}

resource "azurerm_storage_data_lake_gen2_path" "rawdata" {
  path               = "rawdata"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rawdata.name
  storage_account_id =  module.storage_account.id
  resource           = "directory"
}