#Create Resource Group for databricks
resource "azurerm_resource_group" "databricks" {
  name     = module.namepurview.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namepurview ]
}

