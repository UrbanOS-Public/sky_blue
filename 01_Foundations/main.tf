terraform {
  required_version = "~> 1.4.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.55.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.suffix]
}





