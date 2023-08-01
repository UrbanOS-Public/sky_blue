data "azurerm_key_vault" "key_vault" {
    resource_group_name = module.namespoke.resource_group.name
    name = module.namespoke.key_vault.name
}

data "azurerm_log_analytics_workspace" "law" {
  name                = module.namelaw.log_analytics_workspace.name
  resource_group_name = module.namelaw.resource_group.name
}

data "azurerm_key_vault_secret" "win_pwd" {
  name      = "jumpbox-win-pwd"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_resource_group" "spoke" {
  name = module.namespoke.resource_group.name
}

data "azurerm_resource_group" "hub" {
  name = module.namehub.resource_group.name
}
data "azurerm_subnet" "spoke_vm_subnet" {
  name                 = var.vm_subnet_name
  virtual_network_name = module.namespoke.virtual_network.name
  resource_group_name  = module.namespoke.resource_group.name
}
data "azurerm_subnet" "spoke_bastion_subnet" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = module.namehub.virtual_network.name
  resource_group_name  = module.namehub.resource_group.name
}
data "azurerm_storage_account" "st" {
  name                = module.namespoke.storage_account.name
  resource_group_name = module.namespoke.resource_group.name
}