module "virtual_machine" {
  source                              = "./modules/virtual_machine"
  name                                = replace(module.namespoke.linux_virtual_machine.name, "spoke", "jumpbox") 
  size                                = var.vm_size
  location                            = var.location
  public_ip                           = var.vm_public_ip
  vm_user                             = var.admin_username
  admin_ssh_public_key                = data.azurerm_key_vault_secret.ssh_public_key.value #tls_private_key.this.public_key_openssh
  os_disk_image                       = var.vm_os_disk_image
  domain_name_label                   = var.domain_name_label
  resource_group_name                 = module.namespoke.resource_group.name
  subnet_id                           = data.azurerm_subnet.spoke_vm_subnet.id #module.spoke_network.subnet_ids[var.vm_subnet_name]
  os_disk_storage_account_type        = var.vm_os_disk_storage_account_type
  boot_diagnostics_storage_account    = data.azurerm_storage_account.st.primary_blob_endpoint #module.storage_account.primary_blob_endpoint
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
}