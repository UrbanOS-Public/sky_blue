
resource "azurerm_data_factory_custom_dataset" "rawstore" {
  for_each = local.raw_data
  name                = each.key
  data_factory_id     = azurerm_data_factory.adf.id
  type                = each.value.data_type
  description         = each.value.desc
  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.link.name
  }
  folder = each.value.folder
  type_properties_json = <<JSON
    ${(file("./adl_datasets/${each.key}.json"))}
  JSON

  depends_on = [  
    azurerm_data_factory_linked_custom_service.adf,
    azurerm_data_factory_linked_service_data_lake_storage_gen2.link
  ]
}