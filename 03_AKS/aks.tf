
module "aks_cluster" {
  source                                   = "./modules/aks"
  name                                     = module.namespoke.kubernetes_cluster.name
  location                                 = var.location
  resource_group_name                      = module.namespoke.resource_group.name
  resource_group_id                        = data.azurerm_resource_group.spoke.id
  kubernetes_version                       = var.kubernetes_version
  dns_prefix                               = lower(module.namespoke.kubernetes_cluster.name)
  private_cluster_enabled                  = true
  automatic_channel_upgrade                = var.automatic_channel_upgrade
  sku_tier                                 = var.sku_tier
  default_node_pool_name                   = var.default_node_pool_name
  default_node_pool_vm_size                = var.default_node_pool_vm_size
  vnet_subnet_id                           = data.azurerm_subnet.spoke_network_default.id #module.spoke_network.subnet_ids[var.default_node_pool_subnet_name]
  default_node_pool_availability_zones     = var.default_node_pool_availability_zones
  default_node_pool_node_labels            = var.default_node_pool_node_labels
  default_node_pool_node_taints            = var.default_node_pool_node_taints
  default_node_pool_enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
  default_node_pool_enable_host_encryption = var.default_node_pool_enable_host_encryption
  default_node_pool_enable_node_public_ip  = var.default_node_pool_enable_node_public_ip
  default_node_pool_max_pods               = var.default_node_pool_max_pods
  default_node_pool_max_count              = var.default_node_pool_max_count
  default_node_pool_min_count              = var.default_node_pool_min_count
  default_node_pool_node_count             = var.default_node_pool_node_count
  default_node_pool_os_disk_type           = var.default_node_pool_os_disk_type
  tags                                     = var.tags
  network_dns_service_ip                   = var.network_dns_service_ip
  network_plugin                           = var.network_plugin
  outbound_type                            = "userDefinedRouting"
  network_service_cidr                     = var.network_service_cidr
  log_analytics_workspace_id               = data.azurerm_resources.log_analytics_workspace.resources[0].id
  role_based_access_control_enabled        = var.role_based_access_control_enabled
  tenant_id                                = data.azurerm_client_config.current.tenant_id
  admin_group_object_ids                   = var.admin_group_object_ids
  azure_rbac_enabled                       = var.azure_rbac_enabled
  admin_username                           = var.admin_username
  ssh_public_key                           = data.azurerm_key_vault_secret.ssh_public_key.value  #tls_private_key.this.public_key_openssh
  keda_enabled                             = var.keda_enabled
  vertical_pod_autoscaler_enabled          = var.vertical_pod_autoscaler_enabled
  workload_identity_enabled                = var.workload_identity_enabled
  oidc_issuer_enabled                      = var.oidc_issuer_enabled
  open_service_mesh_enabled                = var.open_service_mesh_enabled
  image_cleaner_enabled                    = var.image_cleaner_enabled
  azure_policy_enabled                     = var.azure_policy_enabled
  http_application_routing_enabled         = var.http_application_routing_enabled

 # depends_on = [
  #  module.routetable,
 #   azurerm_key_vault_secret.privatekey,
 #   azurerm_key_vault_secret.publickey,
 #   tls_private_key.this

 # ]
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = data.azurerm_resource_group.spoke.id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks_cluster.aks_identity_principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr_pull" {
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.container_registry.id
  principal_id         = module.aks_cluster.kubelet_identity_object_id
  skip_service_principal_aad_check = true
}


module "node_pool" {
  source = "./modules/node_pool"
  resource_group_name          = module.namespoke.resource_group.name
  kubernetes_cluster_id        = module.aks_cluster.id
  name                         = var.additional_node_pool_name
  vm_size                      = var.additional_node_pool_vm_size
  mode                         = var.additional_node_pool_mode
  node_labels                  = var.additional_node_pool_node_labels
  node_taints                  = var.additional_node_pool_node_taints
  availability_zones           = var.additional_node_pool_availability_zones
  vnet_subnet_id               = data.azurerm_subnet.spoke_network_additional.id #module.spoke_network.subnet_ids[var.additional_node_pool_subnet_name]
  enable_auto_scaling          = var.additional_node_pool_enable_auto_scaling
  enable_host_encryption       = var.additional_node_pool_enable_host_encryption
  enable_node_public_ip        = var.additional_node_pool_enable_node_public_ip
  orchestrator_version         = var.kubernetes_version
  max_pods                     = var.additional_node_pool_max_pods
  max_count                    = var.additional_node_pool_max_count
  min_count                    = var.additional_node_pool_min_count
  node_count                   = var.additional_node_pool_node_count
  os_disk_type                 = var.additional_node_pool_os_disk_type
  os_type                      = var.additional_node_pool_os_type
  priority                     = var.additional_node_pool_priority
  tags                         = var.tags

  #depends_on                   = [module.routetable]
}