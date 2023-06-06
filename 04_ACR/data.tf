data "azurerm_resources" "key_vault" {
    type ="Microsoft.KeyVault/vaults"
    resource_group_name = module.namespoke.resource_group.name
    name = module.namespoke.key_vault.name
}

data "azurerm_log_analytics_workspace" "law" {
  name                = module.namelaw.log_analytics_workspace.name
  resource_group_name = module.namelaw.resource_group.name
}

data "azurerm_subnet" "spoke_vm_subnet" {
  name                 = var.vm_subnet_name
  virtual_network_name = module.namespoke.virtual_network.name
  resource_group_name  = module.namespoke.resource_group.name
}
