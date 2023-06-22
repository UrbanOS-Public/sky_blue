resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each    = fileset("./pipelines", "*.json")
  name = replace(each.key, ".json", "")
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = <<JSON
        ${(file("./pipelines/${each.key}"))}
  JSON
}