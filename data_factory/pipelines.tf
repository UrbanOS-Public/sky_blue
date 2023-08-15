# resource "azurerm_data_factory_pipeline" "pipeline_files" {
#   for_each        = fileset("./pipelines", "*.json")
#   name            = replace(each.key, ".json", "")
#   data_factory_id = azurerm_data_factory.adf.id
#   folder = "Delete"
#   activities_json = <<JSON
#         ${(file("./pipelines/${each.key}"))}
#   JSON

#   depends_on = [  
#     azurerm_data_factory_linked_custom_service.adf,
#     azurerm_data_factory_custom_dataset.data,
#     azurerm_data_factory_custom_dataset.rawstore,
#     azurerm_data_factory_custom_dataset.data_rest
#   ]
# }

# resource "azurerm_data_factory_trigger_schedule" "pipeline_files" {
#   for_each        = fileset("./pipelines", "*.json")
#   name            = "tg-${(replace(each.key, ".json", ""))}"
#   data_factory_id = azurerm_data_factory.adf.id
#   pipeline_name   = replace(each.key, ".json", "")

#   interval   = 1
#   frequency  = "Day"
#   #start_time = "03:00:00"
#   #time_zone  = "EST"
  
#   schedule {
#     hours   = [3]
#     minutes = [0]
#   }

#   depends_on = [ 
#     azurerm_data_factory_pipeline.pipeline_files
#   ]
# }


resource "azurerm_data_factory_pipeline" "pipeline_files" {
  for_each = local.adf_pipelines
  name            = each.key
  data_factory_id = azurerm_data_factory.adf.id
  description     = each.value.desc
  folder          = each.value.folder
  concurrency     = each.value.concurrency
  activities_json = <<JSON
        ${(file("./pipelines/${each.key}.json"))}
  JSON

  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf,
    azurerm_data_factory_custom_dataset.data,
    azurerm_data_factory_custom_dataset.rawstore,
    azurerm_data_factory_custom_dataset.data_rest
  ]
}

resource "azurerm_data_factory_trigger_schedule" "pipeline_files" {
  for_each = local.adf_pipelines
  name            = "tg-${each.key}"
  data_factory_id = azurerm_data_factory.adf.id
  pipeline_name   = each.key
  description     = "tg set by tf"
  interval   = 1
  frequency  = "Week"
  #start_time = "03:00:00"
  #time_zone  = "EST"
  
  schedule {
    days_of_week = ["Sunday"]
    hours   = [3]
    minutes = [0]
  }

  depends_on = [ 
    azurerm_data_factory_pipeline.pipeline_files
  ]
}