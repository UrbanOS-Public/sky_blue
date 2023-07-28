#Create Resource Group for solution
resource "azurerm_resource_group" "spoke" {
  name     = module.namespoke.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namespoke ]
}

#Create Resource Group for hub
resource "azurerm_resource_group" "hub" {
  name     = module.namehub.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namehub ]
}

module "hub_network" {
  source                       = "./modules/virtual_network"
  resource_group_name          = azurerm_resource_group.hub.name
  location                     = var.location
  vnet_name                    = module.namehub.virtual_network.name
  address_space                = var.hub_address_space
  tags                         = var.tags
  log_analytics_workspace_id   = data.azurerm_log_analytics_workspace.law.id
  log_analytics_retention_days = var.log_analytics_retention_days

  subnets = [
    {
      name : "AzureFirewallSubnet" #DO NOT CHANGE FWSUBNET_NAME - This is currently a requirement for Azure Firewall
      address_prefixes : var.hub_firewall_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : "AzureBastionSubnet"
      address_prefixes : var.hub_bastion_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    }
  ]
}


module "spoke_network" {
  source                       = "./modules/virtual_network"
  resource_group_name          = azurerm_resource_group.spoke.name
  location                     = var.location
  vnet_name                    = module.namespoke.virtual_network.name #var.aks_vnet_name
  address_space                = var.spoke_address_space
  log_analytics_workspace_id   = data.azurerm_log_analytics_workspace.law.id
  log_analytics_retention_days = var.log_analytics_retention_days
  tags                         = var.tags
  subnets = [
    {
      name : var.default_node_pool_subnet_name
      address_prefixes : var.default_node_pool_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : var.additional_node_pool_subnet_name
      address_prefixes : var.additional_node_pool_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : var.pod_subnet_name
      address_prefixes : var.pod_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    },
    {
      name : var.vm_subnet_name
      address_prefixes : var.vm_subnet_address_prefix
      enforce_private_link_endpoint_network_policies : true
      enforce_private_link_service_network_policies : false
    }
  ]
}

module "vnet_peering" {
  source              = "./modules/virtual_network_peering"
  vnet_1_name         = module.hub_network.name
  vnet_1_id           = module.hub_network.vnet_id
  vnet_1_rg           = azurerm_resource_group.hub.name
  vnet_2_name         = module.spoke_network.name
  vnet_2_id           = module.spoke_network.vnet_id
  vnet_2_rg           = azurerm_resource_group.spoke.name
  peering_name_1_to_2 = "${module.hub_network.name}To${module.spoke_network.name}"
  peering_name_2_to_1 = "${module.spoke_network.name}To${module.hub_network.name}"
}


module "firewall" {
  source                       = "./modules/firewall"
  name                         = module.namehub.firewall.name #var.firewall_name
  resource_group_name          = azurerm_resource_group.hub.name
  zones                        = var.firewall_zones
  threat_intel_mode            = var.firewall_threat_intel_mode
  location                     = var.location
  sku_name                     = var.firewall_sku_name 
  sku_tier                     = var.firewall_sku_tier
  pip_name                     = module.namehub.public_ip.name #"${module.namehub.firewall.name}PublicIp"
  subnet_id                    = module.hub_network.subnet_ids["AzureFirewallSubnet"]
  log_analytics_workspace_id   = data.azurerm_log_analytics_workspace.law.id
  log_analytics_retention_days = var.log_analytics_retention_days
  tags                         = var.tags
}

module "routetable" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.hub.name
  location             = var.location
  route_table_name     = local.route_table_name
  route_name           = local.route_name
  firewall_private_ip  = module.firewall.private_ip_address
  tags                 = var.tags
  subnets_to_associate = {
    (var.default_node_pool_subnet_name) = {
      subscription_id      = data.azurerm_client_config.current.subscription_id
      resource_group_name  = azurerm_resource_group.spoke.name
      virtual_network_name = module.spoke_network.name
    }
    (var.additional_node_pool_subnet_name) = {
      subscription_id      = data.azurerm_client_config.current.subscription_id
      resource_group_name  = azurerm_resource_group.spoke.name
      virtual_network_name = module.spoke_network.name
    }
  }
  depends_on = [ 
    module.spoke_network,
    module.hub_network,
    module.firewall
  ]
}