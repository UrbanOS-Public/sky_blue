resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each        = fileset("./pipelines", "*.json")
  name            = replace(each.key, ".json", "")
  data_factory_id = azurerm_data_factory.adf.id
  activities_json = <<JSON
        ${(file("./pipelines/${each.key}"))}
  JSON

  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf,
    azurerm_data_factory_custom_dataset.data,
    azurerm_data_factory_custom_dataset.rawstore
  ]
}

resource "azurerm_data_factory_trigger_schedule" "pipeline_files" {
  for_each        = fileset("./pipelines", "*.json")
  name            = "tg-${(replace(each.key, ".json", ""))}"
  data_factory_id = azurerm_data_factory.adf.id
  pipeline_name   = replace(each.key, ".json", "")

  interval   = 1
  frequency  = "Day"
  start_time = "03:00:00"
  time_zone  = "EST"
 
  depends_on = [ 
    azurerm_data_factory_pipeline.pipeline_files
  ]
}