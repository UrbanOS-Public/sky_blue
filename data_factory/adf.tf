resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-adf"
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

resource "azurerm_user_assigned_identity" "adf_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${module.namedatalake.data_factory.name}-uai"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_key_vault_access_policy" "adf_identity" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.adf_identity.principal_id 

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    azurerm_user_assigned_identity.adf_identity
  ]
}


resource "azurerm_data_factory" "adf" {
  name                = module.namedatalake.data_factory.name
  location            = var.location
  resource_group_name = module.namedatalake.resource_group.name
  public_network_enabled = false
  customer_managed_key_id  = azurerm_key_vault_key.cmk.id
  customer_managed_key_identity_id = azurerm_user_assigned_identity.adf_identity.id
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.adf_identity.id
    ]
  }
}

resource "azurerm_data_factory_pipeline" "example" {
  name            = "example"
  data_factory_id = azurerm_data_factory.adf.id
}