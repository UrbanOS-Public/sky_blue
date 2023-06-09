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
  name                        = module.namedata.storage_account.name #_unique
  location                    = var.location
  resource_group_name         = azurerm_resource_group.data.name
  account_kind                = var.storage_account_kind
  account_tier                = var.storage_account_tier
  replication_type            = var.storage_account_replication_type
  key_vault_id                = module.key_vault.id
  key_vault_key_name          = azurerm_key_vault_key.cmk_storage.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  tags                        = var.tags
}

resource "azurerm_storage_container" "example" {
  name                  = "wejo"
  storage_account_name  = module.namedata.storage_account.name
  container_access_type = "private"
  depends_on = [
    module.storage_account
  ]
}