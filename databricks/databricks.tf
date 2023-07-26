#Create Resource Group for databricks
resource "azurerm_resource_group" "databricks" {
  name     = module.nameadb.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.nameadb ]
}

