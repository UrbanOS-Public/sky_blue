#Create Resource Group for databricks
resource "azurerm_resource_group" "databricks" {
  name     = module.nameadb.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.nameadb ]
}

resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-adb"
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

resource "azurerm_key_vault_key" "cmkdisk" {
  name         = "cmk-adb-disk"
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


resource "azurerm_key_vault_key" "cmkworkspace" {
  name         = "cmk-adb-workspace"
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

# data "azuread_application" "databricks" {
#   application_id = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d"
# }

resource "azurerm_key_vault_access_policy" "adb_identity" {
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  #object_id    = "b61b070e-25a8-4d6a-aea4-d3fd427a28b4" #!!!!to add appid automaticly    data.azuread_application.databricks.object_id #azurerm_databricks_workspace.dp_workspace.storage_account_identity.0.principal_id
  object_id    = data.azuread_service_principal.databricks_spn.object_id 
  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    #azurerm_databricks_workspace.dp_workspace,
    azurerm_key_vault_key.cmk
  ]
}
resource "azurerm_key_vault_access_policy" "databricks_disk_policy" {
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_databricks_workspace.dp_workspace.managed_disk_identity[0].principal_id

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    azurerm_databricks_workspace.dp_workspace,
    azurerm_key_vault_key.cmk
  ]
}

resource "azurerm_key_vault_access_policy" "databricks_policy" {
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_databricks_workspace.dp_workspace.storage_account_identity[0].principal_id

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    azurerm_databricks_workspace.dp_workspace,
    azurerm_key_vault_key.cmk
  ]
}


resource "azurerm_databricks_workspace" "dp_workspace" {
  name                                  = module.nameadb.databricks_workspace.name
  resource_group_name                   = module.nameadb.resource_group.name
  location                              = var.location
  sku                                   = "premium"
  tags                                  = var.tags
  public_network_access_enabled         = false #var.public_network_access_enabled
  network_security_group_rules_required = "NoAzureDatabricksRules"
  customer_managed_key_enabled          = true
  infrastructure_encryption_enabled     = true
  managed_services_cmk_key_vault_key_id = azurerm_key_vault_key.cmk.id
  managed_disk_cmk_key_vault_key_id     = azurerm_key_vault_key.cmkdisk.id
  managed_disk_cmk_rotation_to_latest_version_enabled = true
  managed_resource_group_name           = "${module.nameadb.databricks_workspace.name}-db"
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = data.azurerm_virtual_network.spoke.id
    private_subnet_name                                  = azurerm_subnet.dp_private.name
    public_subnet_name                                   = azurerm_subnet.dp_public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.dp_public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.dp_private.id
    storage_account_name                                 = module.nameadb.data_lake_store.name_unique
  }
  depends_on = [
    azurerm_resource_group.databricks,
    azurerm_key_vault_key.cmk,
    azurerm_key_vault_access_policy.adb_identity,
    azurerm_subnet_network_security_group_association.dp_public,
    azurerm_subnet_network_security_group_association.dp_private
  ]
}

# resource "azurerm_databricks_workspace" "test" {
#   name                        = "db-test"
#   resource_group_name         = module.nameadb.resource_group.name
#   location                    = "WestUS"
#   sku                         = "premium"
#   managed_resource_group_name = "rg-dbtest-workspace"
#   tags                        = var.tags
# }



resource "azurerm_databricks_access_connector" "adf" {
  name                = "${module.nameadb.databricks_workspace.name}-conn"
  resource_group_name = module.nameadb.resource_group.name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}


resource "azurerm_role_assignment" "blob_contributor_metastore" {
  scope                = module.metastore.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.adf.identity.0.principal_id
  depends_on = [ 
    module.metastore,
    azurerm_databricks_access_connector.adf
  ]
}

resource "azurerm_role_assignment" "blob_contributor_adl" {
  scope                = data.azurerm_storage_account.lake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.adf.identity.0.principal_id
  depends_on = [ 
    azurerm_databricks_access_connector.adf
  ]
}


resource "azurerm_databricks_workspace_customer_managed_key" "databricks_workspace_key" {
  key_vault_key_id = azurerm_key_vault_key.cmkworkspace.id
  workspace_id     = azurerm_databricks_workspace.dp_workspace.id

  depends_on = [
    azurerm_key_vault_key.cmkworkspace,
    azurerm_databricks_workspace.dp_workspace,
    azurerm_key_vault_access_policy.databricks_policy
  ]
}