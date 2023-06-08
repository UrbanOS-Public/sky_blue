resource "azurerm_container_registry" "acr" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku  
  admin_enabled            = var.admin_enabled
  tags                     = var.tags
  public_network_access_enabled = false
  network_rule_bypass_option = "AzureServices"
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }
  
  encryption {
    enabled            = true
    key_vault_key_id   = var.key_vault_key_id
    identity_client_id = azurerm_user_assigned_identity.acr_identity.client_id
  }

  dynamic "georeplications" {
    for_each = var.georeplication_locations

    content {
      location = georeplications.value
      zone_redundancy_enabled = true
      tags     = var.tags
    }
  }
  
  depends_on = [ 
    azurerm_user_assigned_identity.acr_identity,
    azurerm_key_vault_access_policy.acr_identity
  ]
  lifecycle {
      ignore_changes = [
          tags
      ]
  }
}

resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${var.name}-uai"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_container_registry_agent_pool" "dedicated" {
  name                    = "agentpool"
  resource_group_name     = var.resource_group_name
  location                = var.location
  container_registry_name = azurerm_container_registry.acr.id
  instance_count = 1
  tier = "S1"
  virtual_network_subnet_id = var.subnet_id
  tags                = var.tags
}


resource "azurerm_key_vault_access_policy" "acr_identity" {
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.acr_identity.principal_id 

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt", "WrapKey" ,"UnwrapKey"
  ]
  depends_on = [ 
    azurerm_user_assigned_identity.acr_identity
  ]
}

resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "ContainerRegistryRepositoryEvents"
    #enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  enabled_log {
    category = "ContainerRegistryLoginEvents"
    #enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
}