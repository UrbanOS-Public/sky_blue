### Data Sources ###
data "azurerm_client_config" "current" {}

#Create a Resource Group
resource "azurerm_resource_group" "foundations" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}

#Create a Resource Group 
resource "azurerm_resource_group" "urbanos" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}

##Create Networking Resource Group for hub-spoke vnet
resource "azurerm_resource_group" "vnet-hub-rg" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "vnet-dev-rg" {
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}

#VNETs and Subnets
#add custom dns servers from customer
#dns server from Azure and my own dns is also defined here
resource "azurerm_virtual_network" "hub-vnet" {
  name                = "vnet-hub-${var.prefix}-weu-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet-hub-rg.name
  address_space       = ["10.0.0.0/20"]
  dns_servers         = ["10.5.0.4","168.63.129.16"]
  tags                = var.tags
}

resource "azurerm_virtual_network" "dev-vnet" {
  name                = "vnet-dev-${var.prefix}-weu-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.vnet-dev-rg.name
  address_space       = ["10.2.0.0/20"]
  dns_servers         = ["10.5.0.4","168.63.129.16"]
  tags                = var.tags
}