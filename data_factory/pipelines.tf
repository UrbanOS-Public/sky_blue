resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each    = fileset("./pipelines", "*.json")
  config_json = jsondecode(file("./pipelines/${each.key}"))
  name = each.key
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = <<JSON
        ${config_json}
  JSON
}