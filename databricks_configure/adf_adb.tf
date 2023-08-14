#set Contributor role to adb for adf
resource "azurerm_role_assignment" "adb_contributor" {
  scope                = data.azurerm_databricks_workspace.this.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_data_factory.adf.identity[0].principal_id
}