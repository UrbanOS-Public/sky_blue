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
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.adf_identity.id
    ]
  }
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

resource "azurerm_data_factory_linked_custom_service" "arcgis" {
  name                = "arcgis"
  data_factory_id     = azurerm_data_factory.adf.id
  type                = "HttpServer"
   type_properties_json = <<JSON
    {
      "url": "https://services1.arcgis.com/",
      "enableServerCertificateValidation": true,
      "authenticationType": "Anonymous"
    }
    JSON
}


resource "azurerm_data_factory_custom_dataset" "intersectiondata" {
  name                = "intersection_data_json"
  data_factory_id     = azurerm_data_factory.adf.id
  type                = "Json"

  linked_service {
    name = azurerm_data_factory_linked_custom_service.arcgis.name
  }
  
  type_properties_json = <<JSON
    {
      "location": {
        "type": "HttpServerLocation",
        "relativeUrl": "O1JpcwDW8sjYuddV/arcgis/rest/services/Intersection_TDA/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"
      }
    }
  JSON
}

resource "azurerm_data_factory_custom_dataset" "datastore" {
  name                = "adl_intersection_data_json"
  data_factory_id     = azurerm_data_factory.adf.id
  type                = "Microsoft.DataFactory/factories/dataset"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.link.name
  }
  
  type_properties_json = <<JSON
    {
      "location": {
        "type": "AzureBlobFSLocation",
        "fileName": "1.json",
        "folderPath": "rawdata",
        "fileSystem": "datastory"
      }
    }
  JSON
}



resource "azurerm_data_factory_pipeline" "example" {
  name            = "example"
  data_factory_id = azurerm_data_factory.adf.id
}