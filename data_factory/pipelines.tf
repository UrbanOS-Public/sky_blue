resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each    = fileset("./pipelines", "*.json")
  name = each.key
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = <<JSON
        ${jsondecode(file("./pipelines/${each.key}"))}
  JSON
}