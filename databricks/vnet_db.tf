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

resource "azurerm_network_security_rule" "dp_aad" {
  name                        = "AllowAAD-dp"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureActiveDirectory"
  resource_group_name         = module.nameadb.resource_group.name
  network_security_group_name = azurerm_network_security_group.dp_sg.name
}

resource "azurerm_network_security_rule" "dp_azfrontdoor" {
  name                        = "AllowAzureFrontDoor-dp"
  priority                    = 201
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "AzureFrontDoor.Frontend"
  resource_group_name         = module.nameadb.resource_group.name
  network_security_group_name = azurerm_network_security_group.dp_sg.name
}

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