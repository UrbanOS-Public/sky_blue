resource "azurerm_data_factory_data_flow" "data_flow_files" {
  for_each = local.data_flow
  name            = each.key
  data_factory_id = azurerm_data_factory.adf.id

  # source {
  #   name = "source1"

  #   linked_service {
  #     name = each.value.source_link
  #   }
  # }

  sink {
    name = "sink1"

    linked_service {
      name = each.value.sink_link
    }
  }

  script = <<JSON
        ${(file("./data_flow/${each.value.fileName}"))}
  JSON

  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf,
    azurerm_data_factory_custom_dataset.data,
    azurerm_data_factory_custom_dataset.rawstore,
    azurerm_data_factory_custom_dataset.data_rest
  ]
}
