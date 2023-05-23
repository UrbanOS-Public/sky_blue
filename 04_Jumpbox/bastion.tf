module "bastion_host" {
   source                       = "./modules/bastion_host"
   name                         = module.namespoke.bastion_host.name
   location                     = var.location
   resource_group_name          = module.namespoke.resource_group.name
   subnet_id                    = data.azurerm_subnet.spoke_bastion_subnet.id #module.hub_network.subnet_ids["AzureBastionSubnet"]
   log_analytics_workspace_id   = data.azurerm_log_analytics_workspace.law.id
   log_analytics_retention_days = var.log_analytics_retention_days
}