#Create Resource Group for solution
resource "azurerm_resource_group" "law" {
  name     = module.namelaw.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namelaw ]
}


module "log_analytics_workspace" {
  source                           = "./modules/log_analytics"
  name                             = module.namelaw.log_analytics_workspace.name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.law.name
  solution_plan_map                = var.solution_plan_map
}
