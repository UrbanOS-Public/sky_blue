resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-sql"
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

resource "azurerm_user_assigned_identity" "sql_identity" {
  resource_group_name = module.namedatalake.resource_group.name
  location            = var.location
  tags                = var.tags

  name = "${module.namedatalake.mssql_server.name}-uai"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_key_vault_access_policy" "sql_identity" {
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.sql_identity.principal_id 

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    azurerm_user_assigned_identity.sql_identity,
    azurerm_key_vault_key.cmk
  ]
}

resource "azurerm_mssql_server" "aim" {
  name                         = module.namedatalake.mssql_server.name
  resource_group_name          = module.namedatalake.resource_group.name
  location                     = var.location
  version                      = "12.0"
  minimum_tls_version          = "1.2"
  
  public_network_access_enabled = false

  tags                = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sql_identity.id]
  }

  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.sql_identity.id
  transparent_data_encryption_key_vault_key_id = azurerm_key_vault_key.cmk.id

  azuread_administrator {
    azuread_authentication_only = true
    login_username              = "SQL_dev_admin"
    object_id                   = var.admin_group_object_ids[0]
  }
  depends_on = [  
    azurerm_key_vault_key.cmk,
    azurerm_user_assigned_identity.sql_identity,
    azurerm_key_vault_access_policy.sql_identity

  ]
}