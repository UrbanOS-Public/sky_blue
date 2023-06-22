locals { 
  pipelines = { for jsonname in fileset("./pipelines", "*.json") : jsonfile => jsondecode(file("./pipelines/${jsonname}")) }
}

resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each = local.pipelines
  name            = each.value.namjsonnamee
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = <<JSON
        ${each.jsonfile}
  JSON
}