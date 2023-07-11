#Create Resource Group for purview
resource "azurerm_resource_group" "purview" {
  name     = module.namepurview.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namepurview ]
}



resource "azurerm_user_assigned_identity" "purview_identity" {
  resource_group_name = module.namepurview.resource_group.name
  location            = var.location
  tags                = var.tags

  name = "${module.namepurview.powerbi_embedded.name}-uai"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_purview_account" "aim" {
  name                = module.namepurview.powerbi_embedded.name
  resource_group_name = module.namepurview.resource_group.name
  location            = var.location
  tags                = var.tags

  public_network_enabled = true
  managed_resource_group_name = module.namepurview.resource_group.name
  identity {
    type = "SystemAssigned"
  }
}