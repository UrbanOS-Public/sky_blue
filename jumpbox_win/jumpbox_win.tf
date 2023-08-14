
  #Create Resource Group for purview
resource "azurerm_resource_group" "jumpboxvm" {
  for_each = var.jumpbox_win
  name     = replace(module.namejump.resource_group.name,"jump",each.key)
  location = var.location
  tags     = var.tags
}

module "key_vault" {
  for_each = var.jumpbox_win
  source                          = "./modules/key_vault"
  name                            = replace(module.namejump.key_vault.name,"jump",each.key)
  location                        = var.location
  resource_group_name             = replace(module.namejump.resource_group.name,"jump",each.key)
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.key_vault_sku_name
  tags                            = var.tags
  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  enable_rbac_authorization       = var.key_vault_enable_rbac_authorization
  purge_protection_enabled        = var.key_vault_purge_protection_enabled
  soft_delete_retention_days      = var.key_vault_soft_delete_retention_days
  bypass                          = var.key_vault_bypass
  default_action                  = var.key_vault_default_action
  log_analytics_workspace_id      = data.azurerm_log_analytics_workspace.law.id
  log_analytics_retention_days    = var.log_analytics_retention_days
  public_network_access_enabled   = var.public_network_access_enabled
}


resource "azurerm_key_vault_access_policy" "agent" {
  for_each = var.jumpbox_win
  key_vault_id = module.key_vault[each.key].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id # "9863e455-912b-49b6-a143-4fb3c35918f1"

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]
  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  storage_permissions =[
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  depends_on = [ 
    module.key_vault
  ]
}

resource "azurerm_key_vault_access_policy" "localadmin" {
  for_each = var.jumpbox_win
  key_vault_id = module.key_vault[each.key].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.ObjectID

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]
  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"
  ]
  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]
  storage_permissions =[
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  depends_on = [ 
    module.key_vault
  ]
}

module "key_vault_private_endpoint" {
  for_each = var.jumpbox_win
  source                         = "./modules/private_endpoint"
  name                           = "${(replace(module.namejump.linux_virtual_machine.name, "jump", each.key))}-pe" #"${title(module.key_vault.name)}-pe"
  location                       = var.location
  resource_group_name            = replace(module.namejump.resource_group.name,"jump",each.key)
  subnet_id                      = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name] 
  tags                           = var.tags
  private_connection_resource_id = module.key_vault[each.key].id #data.azurerm_resources.key_vault.resources[0].id #
  is_manual_connection           = false
  subresource_name               = "vault"
  private_dns_zone_group_name    = "KeyVaultPrivateDnsZoneGroup"
  private_dns_zone_group_ids     = [data.azurerm_private_dns_zone.vault.id] #[module.key_vault_private_dns_zone.id]
}

resource "random_password" "set_password" {
  for_each = var.jumpbox_win
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "azurerm_key_vault_secret" "privatekey" {
  for_each = var.jumpbox_win
  name         = "pwd-${each.key}"
  value        = random_password.set_password[each.key].result
  key_vault_id = module.key_vault[each.key].id
  
  depends_on = [ 
    module.key_vault,
    azurerm_key_vault_access_policy.agent,
    random_password.set_password,
    module.key_vault_private_endpoint
  ]
}

module "virtual_machine" {
  for_each = var.jumpbox_win
  source                              = "./modules/virtual_machine_win"
  name                                = replace(module.namejump.linux_virtual_machine.name, "jump", each.key)
  vm_name                             = replace(replace(module.namejump.virtual_machine.name_unique, "jump", each.key),"-","")
  size                                = var.vm_size
  location                            = var.location
  public_ip                           = var.vm_public_ip
  vm_user                             = each.value.username
  admin_ssh_public_key                = random_password.set_password[each.key].result #tls_private_key.this.public_key_openssh
  os_disk_image                       = var.vm_os_disk_image
  domain_name_label                   = "jumpbox win" #var.domain_name_label
  resource_group_name                 = replace(module.namejump.resource_group.name,"jump",each.key)
  subnet_id                           = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name]
  os_disk_storage_account_type        = var.vm_os_disk_storage_account_type
  boot_diagnostics_storage_account    = data.azurerm_storage_account.st.primary_blob_endpoint #module.storage_account.primary_blob_endpoint
  diagnostics_storage_account_id      = data.azurerm_storage_account.st.id
  log_analytics_workspace_id          = data.azurerm_log_analytics_workspace.law.workspace_id #module.log_analytics_workspace.workspace_id
  log_analytics_workspace_key         = data.azurerm_log_analytics_workspace.law.primary_shared_key #module.log_analytics_workspace.primary_shared_key
  log_analytics_workspace_resource_id = data.azurerm_log_analytics_workspace.law.id #module.log_analytics_workspace.id
  log_analytics_retention_days        = var.log_analytics_retention_days
  script_storage_account_name         = var.script_storage_account_name
  script_storage_account_key          = "" #var.script_storage_account_key
  container_name                      = "" #var.container_name
  script_name                         = var.script_name
  admin_group_object_ids              = var.admin_group_object_ids
  tags = var.tags
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
    }   
  ]
    depends_on = [ 
      azurerm_resource_group.jumpboxvm,
      azurerm_key_vault_access_policy.agent,
      azurerm_key_vault_access_policy.localadmin,
      random_password.set_password,
      module.key_vault_private_endpoint,
      azurerm_key_vault_secret.privatekey
    ]
}


resource "azurerm_dev_test_global_vm_shutdown_schedule" "rg" {
  for_each = var.jumpbox_win
  virtual_machine_id = module.virtual_machine[each.key].id
  location           = var.location
  enabled            = true
  tags               = var.tags

  daily_recurrence_time = each.value.daily_recurrence_time
  timezone              = each.value.timezone


  notification_settings {
    enabled         = true
    email           = each.value.notification_email
  }
 }