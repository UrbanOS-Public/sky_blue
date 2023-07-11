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
  resource_group_name = module.namedatalake.resource_group.name
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
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.adf_identity.principal_id 

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    azurerm_user_assigned_identity.adf_identity,
    azurerm_key_vault_key.cmk
  ]
}


resource "azurerm_data_factory" "adf" {
  name                    = module.namedatalake.data_factory.name
  location                = var.location
  resource_group_name     = module.namedatalake.resource_group.name
  public_network_enabled  = false
  customer_managed_key_id = azurerm_key_vault_key.cmk.id
  customer_managed_key_identity_id = azurerm_user_assigned_identity.adf_identity.id
  purview_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${module.namepurview.resource_group.name}/providers/Microsoft.Purview/accounts/${module.namepurview.powerbi_embedded.name}"
  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.adf_identity.id
    ]
  }
  depends_on = [
    azurerm_key_vault_access_policy.adf_identity
  ]
}

# resource "azurerm_data_factory_managed_private_endpoint" "example" {
#   name               = "${(module.namedatalake.data_factory.name)}-mpe"
#   data_factory_id    = azurerm_data_factory.adf.id
#   target_resource_id = data.azurerm_storage_account.lake.id
#   subresource_name   = "blob"
# }

resource "azurerm_role_assignment" "blob_contributor" {
  scope                = data.azurerm_storage_account.lake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.adf_identity.principal_id
  depends_on = [ 
    azurerm_user_assigned_identity.adf_identity
  ]
}

resource "azurerm_role_assignment" "blob_contributor_adf" {
  scope                = data.azurerm_storage_account.lake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_factory.adf.identity.0.principal_id
  depends_on = [ 
    azurerm_data_factory.adf
  ]
}


resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "link" {
  name                  = module.namedatalake.data_factory_linked_service_data_lake_storage_gen2.name
  data_factory_id       = azurerm_data_factory.adf.id
  use_managed_identity  = true
  url                   = "https://${(data.azurerm_storage_account.lake.name)}.dfs.core.windows.net"
  description           = "Link with Data Lake storage"
  depends_on = [ 
    azurerm_role_assignment.blob_contributor 
  ]
}

resource "azurerm_data_factory_linked_custom_service" "adf" {
  for_each = local.linked_custom_service
  name                = each.value.linked_service_name
  data_factory_id     = azurerm_data_factory.adf.id
  type                = each.value.linked_type
   type_properties_json = <<JSON
    {
      "url": "${each.value.baseUrl}",
      "enableServerCertificateValidation": true,
      "authenticationType": "Anonymous"
    }
    JSON
}

resource "azurerm_data_factory_custom_dataset" "data" {
  for_each = local.custom_data
  name                = each.key
  data_factory_id     = azurerm_data_factory.adf.id
  type                = each.value.data_type

  linked_service {
    name = each.value.linked_service
  }
  
  type_properties_json = <<JSON
    {
      "location": {
        "type": "HttpServerLocation",
        "relativeUrl": "${each.value.relativeUrl}"
      }
    }
  JSON
  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf
  ]

}

resource "azurerm_data_factory_custom_dataset" "data_rest" {
  for_each = local.custom_data_rest
  name                = each.key
  data_factory_id     = azurerm_data_factory.adf.id
  type                = each.value.data_type

  linked_service {
    name = each.value.linked_service
  }
  
  type_properties_json = <<JSON
    {
        "relativeUrl": "${each.value.relativeUrl}"
    }
  JSON
  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf
  ]

}

# resource "azurerm_data_factory_custom_dataset" "rawstore" {
#   for_each = local.raw_data
#   name                = each.key
#   data_factory_id     = azurerm_data_factory.adf.id
#   type                = each.value.data_type

#   linked_service {
#     name = azurerm_data_factory_linked_service_data_lake_storage_gen2.link.name
#   }
  
#   type_properties_json = <<JSON
#     {
#       "location": {
#         "type": "AzureBlobFSLocation",
#         "fileName": "${each.value.fileName}",
#         "folderPath": "${each.value.folderPath}",
#         "fileSystem": "${each.value.fileSystem}"
#       }
#     }
#   JSON

#   depends_on = [  
#     azurerm_data_factory_linked_custom_service.adf
#   ]

# }

