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
  managed_virtual_network_enabled = true #!
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

module "diagnostic_settings" {
  source = "./modules/diagnostic_setting"
  diagnostics_settings_name  = "DiagnosticSettings"
  resource_id                = azurerm_data_factory.adf.id
  law_id                     = data.azurerm_log_analytics_workspace.law.id
  logs                       = [
                                  "AuditEvent"
                               ]
  metrics                    = [
                                 "AllMetrics"
                               ]
  retention_days             = var.retention_days
}



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


resource "azurerm_role_assignment" "adf" {
  count = length(var.admin_group_object_ids)
  scope                = azurerm_data_factory.adf.id
  role_definition_name = "Data Factory Contributor"
  principal_id         = var.admin_group_object_ids[count.index]
  depends_on = [ 
    azurerm_data_factory.adf
  ]
}

resource "azurerm_role_assignment" "rg" {
  count = length(var.admin_group_object_ids)
  scope                = data.azurerm_resource_group.datalake.id
  role_definition_name = "Data Factory Contributor"
  principal_id         = var.admin_group_object_ids[count.index]
  depends_on = [ 
    azurerm_data_factory.adf
  ]
}

resource "azurerm_data_factory_integration_runtime_azure" "aim" {
  for_each = local.integration_runtime
  name              = each.key
  data_factory_id   = azurerm_data_factory.adf.id
  location          = var.location
  core_count        = each.value.core_count
  compute_type      = each.value.compute_type
  description       = each.value.description
  time_to_live_min  = each.value.time_to_live_min
  cleanup_enabled   = true
  virtual_network_enabled = each.value.virtual_network_enabled
}

# Interactive authoring is not supported - TO DO: possible workaround
# resource "azapi_resource_action" "df" {
#   for_each = local.integration_runtime
#   type = "Microsoft.DataFactory/factories/integrationRuntimes@2018-06-01"
#   resource_id = azurerm_data_factory_integration_runtime_azure.aim[each.key].id
#   action = "enableInteractiveQuery"
#   body = jsonencode({
#     autoTerminationMinutes = 10
#   })
# }

#After creation, a private endpoint request will be generated that must get approved by an owner of the data source.
resource "azurerm_data_factory_managed_private_endpoint" "adl" {
  name               = "adf-${(data.azurerm_storage_account.lake.name)}-pe"
  data_factory_id    = azurerm_data_factory.adf.id
  target_resource_id = data.azurerm_storage_account.lake.id
  subresource_name   = "dfs"
  depends_on = [ 
    azurerm_data_factory.adf
  ]
}

resource "azurerm_data_factory_managed_private_endpoint" "sql" {
   name               = "adf-${(data.azurerm_mssql_server.aim.name)}-pe"
   data_factory_id    = azurerm_data_factory.adf.id
   target_resource_id = data.azurerm_mssql_server.aim.id
   subresource_name   = "sqlServer"
   depends_on = [ 
     azurerm_data_factory.adf
   ]
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "link" {
  name                  = module.namedatalake.data_factory_linked_service_data_lake_storage_gen2.name
  data_factory_id       = azurerm_data_factory.adf.id
  use_managed_identity  = true
  url                   = "https://${(data.azurerm_storage_account.lake.name)}.dfs.core.windows.net"
  description           = "Link with Data Lake storage via private link"
  integration_runtime_name = "vnetRuntime"
  depends_on = [ 
    azurerm_role_assignment.blob_contributor,
    azurerm_data_factory_integration_runtime_azure.aim,
    azurerm_data_factory_managed_private_endpoint.adl
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
  folder = each.value.folder
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
  folder = each.value.folder
  type_properties_json = <<JSON
    {
        "relativeUrl": "${each.value.relativeUrl}",
        "requestMethod": "GET",
        "paginationRules": {
                "AbsoluteUrl.{offset}": "RANGE:0:500000:5000",
                "EndCondition:$.exceededTransferLimit": "NonExist"
        }
    }
  JSON
  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf
  ]

}


resource "azurerm_data_factory_linked_service_azure_sql_database" "aim" {
  for_each = local.linked_sql
  name              = each.key
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = each.value.connection_string
  integration_runtime_name = each.value.integration_runtime_name
  use_managed_identity = true
  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf,
    azurerm_data_factory_integration_runtime_azure.aim,
    azurerm_data_factory_managed_private_endpoint.sql,
    azurerm_data_factory.adf
  ]
}

resource "azurerm_data_factory_custom_dataset" "sql_tables" {
  for_each = local.linked_sql_table
  name                = each.key
  data_factory_id     = azurerm_data_factory.adf.id
  type                = "AzureSqlTable"

  linked_service {
    name = each.value.linked_service_name
  }
  description = each.value.description
  folder      = each.value.folder
  type_properties_json = <<JSON
        {
            "tableName": "[dbo].[${each.value.table_name}]"
        }
  JSON
  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf
  ]


}
