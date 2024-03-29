module "sql_dns_zone" {
  source                       = "./modules/private_dns_zone"
  name                         = "privatelink.database.windows.net"
  resource_group_name          = module.namespoke.resource_group.name
  tags = var.tags
  virtual_networks_to_link     = {
    (module.namehub.virtual_network.name) = {
      subscription_id = data.azurerm_client_config.current.subscription_id
      resource_group_name = module.namehub.resource_group.name
    }
    (module.namespoke.virtual_network.name) = {
      subscription_id = data.azurerm_client_config.current.subscription_id
      resource_group_name = module.namespoke.resource_group.name
    }
  }
}