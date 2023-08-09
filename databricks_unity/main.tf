terraform {
  required_version = "~> 1.5.0"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.65.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "azuread" {
   tenant_id = data.azurerm_client_config.current.tenant_id
}

provider "databricks" {
  host                        = data.azurerm_databricks_workspace.this.workspace_url
  #azure_workspace_resource_id = data.azurerm_databricks_workspace.this.id

  # ARM_USE_MSI environment variable is recommended
  azure_use_msi = true
}
resource "databricks_service_principal" "sp" {
  provider       = databricks.azure_account
  application_id = "fa2db9fa-ce2d-422a-9b06-ba715fb7036e"
}
data "azurerm_client_config" "current" {}
# Retrieve domain information
data "azuread_domains" "example" {
  only_initial = true
}



