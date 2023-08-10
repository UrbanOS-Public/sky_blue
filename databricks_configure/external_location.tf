resource "databricks_storage_credential" "external_mi" {
  name = "mi_credential"
  azure_managed_identity {
    access_connector_id = "/subscriptions/c26f81cf-321b-4132-8526-3f97a01e19d2/resourceGroups/rg-aim-adb-dev-eus/providers/Microsoft.Databricks/accessConnectors/dbw-aim-adb-dev-eus-conn"
    #! TO DO FIND ID data.azurerm_resources.azurerm_databricks_access_connector.id
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
  depends_on = [ 
    databricks_storage_credential.external_mi
  ]
}

resource "databricks_grants" "raw" {
  external_location = databricks_external_location.raw.id
  grant {
    principal  = "account users"
    privileges = ["ALL_PRIVILEGES"]
  }
}