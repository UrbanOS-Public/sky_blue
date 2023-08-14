#set Contributor role to adb for adf
resource "azurerm_role_assignment" "adb_contributor" {
  scope                = data.azurerm_databricks_workspace.this.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_data_factory.adf.identity[0].principal_id
}

#After creation, a private endpoint request will be generated that must get approved by an owner of the data source.
resource "azurerm_data_factory_managed_private_endpoint" "adl_boundaries_data_json" {
  name               = "adf-${(module.nameadb.databricks_workspace.name)}-pe"
  data_factory_id    = data.azurerm_data_factory.adf.id
  target_resource_id = data.azurerm_databricks_workspace.this.id
  subresource_name   = "databricks_ui_api"
}

resource "azurerm_data_factory_linked_service_azure_databricks" "msi_linked" {
  name                       = module.nameadb.databricks_workspace.name
  data_factory_id            = data.azurerm_data_factory.adf.id
  description                = "ADB Linked Service via MSI"
  adb_domain                 = "https://${data.azurerm_databricks_workspace.this.workspace_url}"
  msi_work_space_resource_id = data.azurerm_databricks_workspace.this.id
  integration_runtime_name   = "vnetRuntime"
  existing_cluster_id        = databricks_cluster.this[0].id
  depends_on = [ 
    databricks_cluster.this
  ]
}