
resource "databricks_storage_credential" "external_mi" {
  name = "mi_credential"
  azure_managed_identity {
    access_connector_id = data.azurerm_resources.azurerm_databricks_access_connector.id
  }
  comment = "Managed identity credential managed by TF"
}

resource "databricks_external_location" "raw" {
  name = "external-ADL-raw"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    "raw",
    module.namedatalake.data_lake_store.name)
  credential_name = databricks_storage_credential.external_mi.id
  comment         = "External location ADL managed by TF"
}

# resource "databricks_grants" "some" {
#   external_location = databricks_external_location.some.id
#   grant {
#     principal  = "Data Engineers"
#     privileges = ["CREATE_TABLE", "READ_FILES"]
#   }
# }