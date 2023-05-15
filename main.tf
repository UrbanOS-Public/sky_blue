terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.0.2"
    }
  }

  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "example-organization"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
        name = "example-workspace"
    }
  }
}

provider "azurerm" {
  features {}
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.2.0"
  suffix  = [var.suffix]
}

resource "azurerm_resource_group" "urbanos" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_storage_account" "urbanos" {
  name                      = module.naming.storage_account.name_unique
  resource_group_name       = azurerm_resource_group.tfstate.name
  location                  = azurerm_resource_group.tfstate.location
  account_tier              = "Standard"
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  infrastructure_encryption_enabled = true

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "urbanos" {
  name                  = module.naming.storage_container.name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}