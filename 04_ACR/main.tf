terraform {
  required_version = "~> 1.5.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.65.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

locals {
  route_table_name       = "DefaultRouteTable"
  route_name             = "RouteToAzureFirewall"
}

data "azurerm_client_config" "current" {}





