locals { 
  pipelines = { for value in fileset("./pipelines", "*.json") : value => jsondecode(file("./pipelines/${value}")) }
}

resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each = local.pipelines
  name            = each.value.name
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = <<JSON
        ${each.value}
  JSON
}