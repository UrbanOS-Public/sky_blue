resource "azurerm_public_ip" "public_ip" {
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = lower(var.domain_name_label)
  count               = var.public_ip ? 1 : 0
  tags                = var.tags

 lifecycle {
   ignore_changes = [
        tags
    ]
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  

  lifecycle {
   ignore_changes = [
        tags
    ]
  }
}


resource "azurerm_network_security_rule" "rules" {
  for_each = { for sg in var.security_rules : sg.name => sg } 
  
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  
  depends_on = [ 
    azurerm_network_security_group.nsg 
  ]
}


resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "Configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = try(azurerm_public_ip.public_ip[0].id, null)
  }

   lifecycle {
     ignore_changes = [
       tags
     ]
   }
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [azurerm_network_security_group.nsg]
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.nic.id]
  size                          = var.size
  computer_name                 = var.name
  admin_username                = var.vm_user
  tags                          = var.tags
  encryption_at_host_enabled    = true
  patch_assessment_mode         = "AutomaticByPlatform"
  provision_vm_agent            = true
  patch_mode                    = "AutomaticByPlatform"

  os_disk {
    name                 = "${var.name}-os"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  admin_ssh_key {
     username   = var.vm_user
     public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    offer     = lookup(var.os_disk_image, "offer", null)
    publisher = lookup(var.os_disk_image, "publisher", null)
    sku       = lookup(var.os_disk_image, "sku", null)
    version   = lookup(var.os_disk_image, "version", null)
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account == "" ? null : var.boot_diagnostics_storage_account
  }

  identity {
    type = "SystemAssigned"    
  }

 lifecycle {
  ignore_changes = [
       tags
   ]
 }

  depends_on = [
    azurerm_network_interface.nic,
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_virtual_machine_extension" "custom_script" {
  name                    = "CustomScript"
  virtual_machine_id      = azurerm_linux_virtual_machine.virtual_machine.id
  publisher               = "Microsoft.Azure.Extensions"
  type                    = "CustomScript"
  type_handler_version    = "2.0"

  lifecycle {
    ignore_changes = [
     # tags,
      settings,
      protected_settings
    ]
  }
}

resource "azurerm_virtual_machine_extension" "monitor_agent" {
  name                       = "MonitoringAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.virtual_machine.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.12"
  auto_upgrade_minor_version = true
 
  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_workspace_id}"
    }
  SETTINGS
 
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${var.log_analytics_workspace_key}"
    }
  PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [azurerm_virtual_machine_extension.custom_script]
}

resource "azurerm_virtual_machine_extension" "dependency_agent" {
  name                       = "DependencyAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.virtual_machine.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.10"
  auto_upgrade_minor_version = true
 
  settings = <<SETTINGS
    {
      "workspaceId": "${var.log_analytics_workspace_id}"
    }
  SETTINGS
 
  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey": "${var.log_analytics_workspace_key}"
    }
  PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [azurerm_virtual_machine_extension.monitor_agent]
}

resource "azurerm_monitor_diagnostic_setting" "nsg_settings" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_network_security_group.nsg.id
  log_analytics_workspace_id = var.log_analytics_workspace_resource_id

  enabled_log {
    category = "NetworkSecurityGroupEvent"
    #enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }

 enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
    #enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_analytics_retention_days
    }
  }
}



resource "azurerm_virtual_machine_extension" "aad" {
  name                       = "AADLoginForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.virtual_machine.id
  publisher                  = "Microsoft.Azure.ActiveDirectory.LinuxSSH"
  type                       = "AADLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_role_assignment" "assign-vm-role" {
  count = length(var.admin_group_object_ids)
    scope                = azurerm_linux_virtual_machine.virtual_machine.id
    role_definition_name = "Virtual Machine Administrator Login"
    principal_id         = var.admin_group_object_ids[count.index]
}

resource "azurerm_network_watcher_flow_log" "network_logs" {
  name = "${var.name}-nwfl"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_resource_group_name

  network_security_group_id = azurerm_network_security_group.nsg.id
  storage_account_id        = var.diagnostics_storage_account_id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = var.log_analytics_retention_days
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = var.log_analytics_workspace_id
    workspace_region      = var.location
    workspace_resource_id = var.log_analytics_workspace_resource_id
    interval_in_minutes   = 10
  }
}