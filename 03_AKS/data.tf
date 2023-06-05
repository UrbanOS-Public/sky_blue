data "azurerm_resources" "key_vault" {
    type ="Microsoft.KeyVault/vaults"
    resource_group_name = module.namespoke.resource_group.name
    name = module.namespoke.key_vault.name
}

data "azurerm_log_analytics_workspace" "law" {
  name                = module.namelaw.log_analytics_workspace.name
  resource_group_name = module.namelaw.resource_group.name
}

data "azurerm_container_registry" "container_registry" {
    resource_group_name = module.namespoke.resource_group.name
    name = module.namespoke.container_registry.name
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name      = "aks-public-sshkey"
  key_vault_id = data.azurerm_resources.key_vault.resources[0].id
}

data "azurerm_resource_group" "spoke" {
  name = module.namespoke.resource_group.name
}

data "azurerm_resource_group" "hub" {
  name = module.namehub.resource_group.name
}
data "azurerm_subnet" "spoke_network_default" {
  name                 = var.default_node_pool_subnet_name
  virtual_network_name = module.namespoke.virtual_network.name
  resource_group_name  = module.namespoke.resource_group.name
}

data "azurerm_subnet" "spoke_network_additional" {
  name                 = var.additional_node_pool_subnet_name
  virtual_network_name = module.namespoke.virtual_network.name
  resource_group_name  = module.namespoke.resource_group.name
}