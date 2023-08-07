locals {
  security_rules = [
    {
     name                       : "Deny_All_OutBound"
     priority                   : 4096
     direction                  : "Outbound"
     access                     : "Deny"
     protocol                   : "*"
     source_port_range          : "*"
     destination_port_range     : "*"
     source_address_prefix      : "*"
     destination_address_prefix : "*"
    },
    {
     name                       : "Allow_Vnet_OutBound"
     priority                   : 100
     direction                  : "Outbound"
     access                     : "Allow"
     protocol                   : "*"
     source_port_range          : "*"
     destination_port_range     : "*"
     source_address_prefix      : "VirtualNetwork"
     destination_address_prefix : "VirtualNetwork"
    }, 
    {
     name                       : "Allow_Internet_OutBound"
     priority                   : 110
     direction                  : "Outbound"
     access                     : "Allow"
     protocol                   : "Tcp"
     source_port_range          : "*"
     destination_port_range     : "443"
     source_address_prefix      : "*"
     destination_address_prefix : "Internet"
    },
    {
     name                       : "Allow_Web_OutBound"
     priority                   : 120
     direction                  : "Outbound"
     access                     : "Allow"
     protocol                   : "Tcp"
     source_port_range          : "*"
     destination_port_range     : "80"
     source_address_prefix      : "*"
     destination_address_prefix : "Internet"
    },
    {
     name                       : "Deny_All_InBound"
     priority                   : 4096
     direction                  : "Inbound"
     access                     : "Deny"
     protocol                   : "*"
     source_port_range          : "*"
     destination_port_range     : "*"
     source_address_prefix      : "*"
     destination_address_prefix : "*"
    },
    {
     name                       : "Allow_Vnet_InBound"
     priority                   : 100
     direction                  : "Inbound"
     access                     : "Allow"
     protocol                   : "*"
     source_port_range          : "*"
     destination_port_range     : "*"
     source_address_prefix      : "VirtualNetwork"
     destination_address_prefix : "VirtualNetwork"
    },
    {
     name                       : "Allow_Vnet_AzureLoadBalancerInBound"
     priority                   : 110
     direction                  : "Inbound"
     access                     : "Allow"
     protocol                   : "*"
     source_port_range          : "*"
     destination_port_range     : "*"
     source_address_prefix      : "AzureLoadBalancer"
     destination_address_prefix : "*"
    },
    {
      name                        = "AllowAAD-dp"
      priority                    = 200
      direction                   = "Outbound"
      access                      = "Allow"
      protocol                    = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "443"
      source_address_prefix       = "VirtualNetwork"
      destination_address_prefix  = "AzureActiveDirectory"
    },
    {
      name                        = "AllowAzureFrontDoor-dp"
      priority                    = 201
      direction                   = "Outbound"
      access                      = "Allow"
      protocol                    = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "443"
      source_address_prefix       = "VirtualNetwork"
      destination_address_prefix  = "AzureFrontDoor.Frontend"
    }   
  ]
}


resource "azurerm_subnet" "dp_public" {
  name                 = "DatabricksSubnet-Public"
  resource_group_name  = module.namespoke.resource_group.name
  virtual_network_name = module.namespoke.virtual_network.name
  address_prefixes     = var.adb_public_subnet_address_prefix 

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_subnet" "dp_private" {
  name                 = "DatabricksSubnet-Private"
  resource_group_name  = module.namespoke.resource_group.name
  virtual_network_name = module.namespoke.virtual_network.name
  address_prefixes     = var.adb_private_subnet_address_prefix

  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = true

  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }

  service_endpoints = [] #var.private_subnet_endpoints
}

resource "azurerm_network_security_group" "dp_sg" {
  name                = "${module.nameadb.databricks_workspace.name}-nsg"
  location            = var.location
  resource_group_name = module.nameadb.resource_group.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "rules" {
  for_each = { for sg in locals.security_rules : sg.name => sg } 
  
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = module.nameadb.resource_group.name
  network_security_group_name = azurerm_network_security_group.dp_sg.name
  
  depends_on = [ 
    azurerm_network_security_group.dp_sg 
  ]
}



# resource "azurerm_network_security_rule" "dp_aad" {
#   name                        = "AllowAAD-dp"
#   priority                    = 200
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "443"
#   source_address_prefix       = "VirtualNetwork"
#   destination_address_prefix  = "AzureActiveDirectory"
#   resource_group_name         = module.nameadb.resource_group.name
#   network_security_group_name = azurerm_network_security_group.dp_sg.name
# }

# resource "azurerm_network_security_rule" "dp_azfrontdoor" {
#   name                        = "AllowAzureFrontDoor-dp"
#   priority                    = 201
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "443"
#   source_address_prefix       = "VirtualNetwork"
#   destination_address_prefix  = "AzureFrontDoor.Frontend"
#   resource_group_name         = module.nameadb.resource_group.name
#   network_security_group_name = azurerm_network_security_group.dp_sg.name
# }

resource "azurerm_subnet_network_security_group_association" "dp_public" {
  subnet_id                 = azurerm_subnet.dp_public.id
  network_security_group_id = azurerm_network_security_group.dp_sg.id
}

resource "azurerm_subnet_network_security_group_association" "dp_private" {
  subnet_id                 = azurerm_subnet.dp_private.id
  network_security_group_id = azurerm_network_security_group.dp_sg.id
}



resource "azurerm_network_watcher_flow_log" "network_logs" {
  name = "${module.nameadb.databricks_workspace.name}-nwfl"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_resource_group_name

  network_security_group_id = azurerm_network_security_group.dp_sg.id
  storage_account_id        = data.azurerm_storage_account.st.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = var.log_analytics_retention_days
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.law.workspace_id
    workspace_region      = var.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.law.id
    interval_in_minutes   = 10
  }
}