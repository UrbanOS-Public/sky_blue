resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-acr"
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


module "container_registry" {
  source                       = "/modules/container_registry"
  name                         = module.namespoke.container_registry.name
  resource_group_name          = module.namespoke.resource_group.name
  location                     = var.location
  sku                          = var.acr_sku
  admin_enabled                = var.acr_admin_enabled
  georeplication_locations     = var.acr_georeplication_locations
  log_analytics_workspace_id   = data.azurerm_log_analytics_workspace.law.id
  log_analytics_retention_days = var.log_analytics_retention_days
  key_vault_id                 = data.azurerm_resources.key_vault.resources[0].id
  key_vault_key_id             = azurerm_key_vault_key.cmk.versionless_id
  tenant_id                    = data.azurerm_client_config.current.tenant_id
}


