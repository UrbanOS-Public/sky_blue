#Create Resource Group for solution
resource "azurerm_resource_group" "data" {
  name     = module.namedatalake.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namedatalake ]
}

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

resource "azurerm_role_assignment" "blob_contributor_admin" {
  count = length(var.admin_group_object_ids)
  scope                = module.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.admin_group_object_ids[count.index]
  depends_on = [ 
    module.storage_account
  ]
}


#  resource "azurerm_storage_data_lake_gen2_filesystem" "adl_filesystem" {
#    for_each = local.adl_filesystem
#    storage_account_id = module.storage_account.id
#    name               = each.value.filesystem_name
#  }


#  resource "azurerm_storage_data_lake_gen2_path" "adl_directory" {
#    for_each = local.adl_directory
#    path               = each.value.dir_name
#    filesystem_name    = each.value.filesystem_name
#    resource           = each.value.resource
#    storage_account_id = module.storage_account.id
#    depends_on = [ 
#       azurerm_storage_data_lake_gen2_filesystem.adl_filesystem 
#    ]
#  }

resource "azurerm_storage_data_lake_gen2_filesystem" "raw_data" {
  storage_account_id = module.storage_account.id
  name               = "raw"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "enriched_data" {
  storage_account_id = module.storage_account.id
  name               = "enriched"
}

 resource "azurerm_storage_data_lake_gen2_filesystem" "standardized_data" {
   storage_account_id = module.storage_account.id
   name               = "standardized"
 }

resource "azurerm_storage_data_lake_gen2_path" "fdos" {
  path               = "fdos"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.raw_data.name
  storage_account_id =  module.storage_account.id
  resource           = "directory"
}

 resource "azurerm_storage_data_lake_gen2_path" "standardized_fdos" {
   path               = "fdos"
   filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.standardized_data.name
   storage_account_id =  module.storage_account.id
   resource           = "directory"
 }

