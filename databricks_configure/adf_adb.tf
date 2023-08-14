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