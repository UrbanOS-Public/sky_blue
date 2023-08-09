# resource "databricks_user" "dummy" {
#   user_name    = "dummy+${data.databricks_current_user.me.alphanumeric}@example.com"
#   display_name = "Dummy ${data.databricks_current_user.me.alphanumeric}"
# }

resource "databricks_metastore" "this" {
  name = "primary"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    "metastore",
  module.nameadb.data_lake_store.name)
  force_destroy = true
}

# resource "databricks_metastore_data_access" "first" {
#   metastore_id = databricks_metastore.this.id
#   name         = "the-keys"
#   azure_managed_identity {
#     access_connector_id = data.azurerm_resources.azurerm_databricks_access_connector.id
#   }

#   is_default = true
# }

# resource "databricks_metastore_assignment" "this" {
#   workspace_id         = data.azurerm_databricks_workspace.this.workspace_id
#   metastore_id         = databricks_metastore.this.id
#   default_catalog_name = "hive_metastore"
# }