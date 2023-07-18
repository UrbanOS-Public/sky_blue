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

data "azurerm_client_config" "current" {}

#Create Resource Group for solution
resource "azurerm_resource_group" "data" {
  name     = module.namedata.resource_group.name
  location = var.location
  tags     = var.tags
  depends_on = [ module.namedata ]
}





