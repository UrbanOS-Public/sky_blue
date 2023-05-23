data "azurerm_resources" "key_vault" {
    type ="Microsoft.KeyVault/vaults"
    resource_group_name = module.namespoke.resource_group.name
    name = module.namespoke.key_vault.name
}

data "azurerm_resources" "log_analytics_workspace" {
    #type = "Microsoft.KeyVault"
    resource_group_name = module.namehub.resource_group.name
    name = module.namehub.log_analytics_workspace.name
}