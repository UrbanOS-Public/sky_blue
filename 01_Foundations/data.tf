data "azurerm_log_analytics_workspace" "law" {
  name                = module.namelaw.log_analytics_workspace.name
  resource_group_name = module.namelaw.resource_group.name
}
