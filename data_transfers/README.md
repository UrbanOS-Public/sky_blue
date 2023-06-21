<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.55.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.55.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./modules/key_vault | n/a |
| <a name="module_namedata"></a> [namedata](#module\_namedata) | Azure/naming/azurerm | 0.3.0 |
| <a name="module_namelaw"></a> [namelaw](#module\_namelaw) | Azure/naming/azurerm | 0.3.0 |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.cmk_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_resource_group.data](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_container.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_admin_enabled"></a> [acr\_admin\_enabled](#input\_acr\_admin\_enabled) | Specifies whether admin is enabled for the container registry | `bool` | `true` | no |
| <a name="input_acr_georeplication_locations"></a> [acr\_georeplication\_locations](#input\_acr\_georeplication\_locations) | (Optional) A list of Azure locations where the container registry should be geo-replicated. | `list(string)` | `[]` | no |
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | Specifies the name of the container registry | `string` | `"Premium"` | no |
| <a name="input_additional_node_pool_availability_zones"></a> [additional\_node\_pool\_availability\_zones](#input\_additional\_node\_pool\_availability\_zones) | (Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_additional_node_pool_enable_auto_scaling"></a> [additional\_node\_pool\_enable\_auto\_scaling](#input\_additional\_node\_pool\_enable\_auto\_scaling) | (Optional) Whether to enable auto-scaler. Defaults to false. | `bool` | `true` | no |
| <a name="input_additional_node_pool_enable_host_encryption"></a> [additional\_node\_pool\_enable\_host\_encryption](#input\_additional\_node\_pool\_enable\_host\_encryption) | (Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_additional_node_pool_enable_node_public_ip"></a> [additional\_node\_pool\_enable\_node\_public\_ip](#input\_additional\_node\_pool\_enable\_node\_public\_ip) | (Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_additional_node_pool_max_count"></a> [additional\_node\_pool\_max\_count](#input\_additional\_node\_pool\_max\_count) | (Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min\_count. | `number` | `10` | no |
| <a name="input_additional_node_pool_max_pods"></a> [additional\_node\_pool\_max\_pods](#input\_additional\_node\_pool\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | `50` | no |
| <a name="input_additional_node_pool_min_count"></a> [additional\_node\_pool\_min\_count](#input\_additional\_node\_pool\_min\_count) | (Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max\_count. | `number` | `3` | no |
| <a name="input_additional_node_pool_mode"></a> [additional\_node\_pool\_mode](#input\_additional\_node\_pool\_mode) | (Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User. | `string` | `"User"` | no |
| <a name="input_additional_node_pool_name"></a> [additional\_node\_pool\_name](#input\_additional\_node\_pool\_name) | (Required) Specifies the name of the node pool. | `string` | `"user"` | no |
| <a name="input_additional_node_pool_node_count"></a> [additional\_node\_pool\_node\_count](#input\_additional\_node\_pool\_node\_count) | (Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min\_count - max\_count. | `number` | `3` | no |
| <a name="input_additional_node_pool_node_labels"></a> [additional\_node\_pool\_node\_labels](#input\_additional\_node\_pool\_node\_labels) | (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created. | `map(any)` | `{}` | no |
| <a name="input_additional_node_pool_node_taints"></a> [additional\_node\_pool\_node\_taints](#input\_additional\_node\_pool\_node\_taints) | (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "CriticalAddonsOnly=true:NoSchedule"<br>]</pre> | no |
| <a name="input_additional_node_pool_os_disk_type"></a> [additional\_node\_pool\_os\_disk\_type](#input\_additional\_node\_pool\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created. | `string` | `"Managed"` | no |
| <a name="input_additional_node_pool_os_type"></a> [additional\_node\_pool\_os\_type](#input\_additional\_node\_pool\_os\_type) | (Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux. | `string` | `"Linux"` | no |
| <a name="input_additional_node_pool_priority"></a> [additional\_node\_pool\_priority](#input\_additional\_node\_pool\_priority) | (Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created. | `string` | `"Regular"` | no |
| <a name="input_additional_node_pool_subnet_address_prefix"></a> [additional\_node\_pool\_subnet\_address\_prefix](#input\_additional\_node\_pool\_subnet\_address\_prefix) | Specifies the address prefix of the subnet that hosts the additional node pool | `list(string)` | n/a | yes |
| <a name="input_additional_node_pool_subnet_name"></a> [additional\_node\_pool\_subnet\_name](#input\_additional\_node\_pool\_subnet\_name) | Specifies the name of the subnet that hosts the default node pool | `string` | `"UserSubnet"` | no |
| <a name="input_additional_node_pool_vm_size"></a> [additional\_node\_pool\_vm\_size](#input\_additional\_node\_pool\_vm\_size) | (Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created. | `string` | `"Standard_B2ms"` | no |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) Specifies the admin username of the jumpbox virtual machine and AKS worker nodes. | `string` | `"azadmin"` | no |
| <a name="input_aks_vnet_address_space"></a> [aks\_vnet\_address\_space](#input\_aks\_vnet\_address\_space) | Specifies the address prefix of the AKS subnet | `list(string)` | n/a | yes |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, and stable. | `string` | `"stable"` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | (Optional) Should the Azure Policy Add-On be enabled? For more details please visit Understand Azure Policy for Azure Kubernetes Service | `bool` | `true` | no |
| <a name="input_azure_rbac_enabled"></a> [azure\_rbac\_enabled](#input\_azure\_rbac\_enabled) | (Optional) Is Role Based Access Control based on Azure AD enabled? | `bool` | `true` | no |
| <a name="input_default_node_pool_availability_zones"></a> [default\_node\_pool\_availability\_zones](#input\_default\_node\_pool\_availability\_zones) | Specifies the availability zones of the default node pool | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_default_node_pool_enable_auto_scaling"></a> [default\_node\_pool\_enable\_auto\_scaling](#input\_default\_node\_pool\_enable\_auto\_scaling) | (Optional) Whether to enable auto-scaler. Defaults to false. | `bool` | `true` | no |
| <a name="input_default_node_pool_enable_host_encryption"></a> [default\_node\_pool\_enable\_host\_encryption](#input\_default\_node\_pool\_enable\_host\_encryption) | (Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_default_node_pool_enable_node_public_ip"></a> [default\_node\_pool\_enable\_node\_public\_ip](#input\_default\_node\_pool\_enable\_node\_public\_ip) | (Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_default_node_pool_max_count"></a> [default\_node\_pool\_max\_count](#input\_default\_node\_pool\_max\_count) | (Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min\_count. | `number` | `10` | no |
| <a name="input_default_node_pool_max_pods"></a> [default\_node\_pool\_max\_pods](#input\_default\_node\_pool\_max\_pods) | (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created. | `number` | `50` | no |
| <a name="input_default_node_pool_min_count"></a> [default\_node\_pool\_min\_count](#input\_default\_node\_pool\_min\_count) | (Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max\_count. | `number` | `3` | no |
| <a name="input_default_node_pool_name"></a> [default\_node\_pool\_name](#input\_default\_node\_pool\_name) | Specifies the name of the default node pool | `string` | `"system"` | no |
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | (Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min\_count - max\_count. | `number` | `3` | no |
| <a name="input_default_node_pool_node_labels"></a> [default\_node\_pool\_node\_labels](#input\_default\_node\_pool\_node\_labels) | (Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created. | `map(any)` | `{}` | no |
| <a name="input_default_node_pool_node_taints"></a> [default\_node\_pool\_node\_taints](#input\_default\_node\_pool\_node\_taints) | (Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_default_node_pool_os_disk_type"></a> [default\_node\_pool\_os\_disk\_type](#input\_default\_node\_pool\_os\_disk\_type) | (Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created. | `string` | `"Managed"` | no |
| <a name="input_default_node_pool_subnet_address_prefix"></a> [default\_node\_pool\_subnet\_address\_prefix](#input\_default\_node\_pool\_subnet\_address\_prefix) | Specifies the address prefix of the subnet that hosts the default node pool | `list(string)` | n/a | yes |
| <a name="input_default_node_pool_subnet_name"></a> [default\_node\_pool\_subnet\_name](#input\_default\_node\_pool\_subnet\_name) | Specifies the name of the subnet that hosts the default node pool | `string` | `"SystemSubnet"` | no |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | Specifies the vm size of the default node pool | `string` | `"Standard_B2ms"` | no |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | Specifies the domain name for the jumbox virtual machine | `string` | `"jumpbox"` | no |
| <a name="input_firewall_sku_name"></a> [firewall\_sku\_name](#input\_firewall\_sku\_name) | (Required) SKU name of the Firewall. Possible values are AZFW\_Hub and AZFW\_VNet. Changing this forces a new resource to be created. | `string` | `"AZFW_VNet"` | no |
| <a name="input_firewall_sku_tier"></a> [firewall\_sku\_tier](#input\_firewall\_sku\_tier) | (Required) SKU tier of the Firewall. Possible values are Premium, Standard, and Basic. | `string` | `"Standard"` | no |
| <a name="input_firewall_threat_intel_mode"></a> [firewall\_threat\_intel\_mode](#input\_firewall\_threat\_intel\_mode) | (Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny. Defaults to Alert. | `string` | `"Alert"` | no |
| <a name="input_firewall_zones"></a> [firewall\_zones](#input\_firewall\_zones) | Specifies the availability zones of the Azure Firewall | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | (Optional) Should HTTP Application Routing be enabled? | `bool` | `false` | no |
| <a name="input_hub_address_space"></a> [hub\_address\_space](#input\_hub\_address\_space) | Specifies the address space of the hub virtual virtual network | `list(string)` | n/a | yes |
| <a name="input_hub_bastion_subnet_address_prefix"></a> [hub\_bastion\_subnet\_address\_prefix](#input\_hub\_bastion\_subnet\_address\_prefix) | Specifies the address prefix of the firewall subnet | `list(string)` | n/a | yes |
| <a name="input_hub_firewall_subnet_address_prefix"></a> [hub\_firewall\_subnet\_address\_prefix](#input\_hub\_firewall\_subnet\_address\_prefix) | Specifies the address prefix of the firewall subnet | `list(string)` | n/a | yes |
| <a name="input_image_cleaner_enabled"></a> [image\_cleaner\_enabled](#input\_image\_cleaner\_enabled) | (Optional) Specifies whether Image Cleaner is enabled. | `bool` | `true` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Enable or disable hierarchical namespace. This is required for Azure Data Lake Storage Gen 2. | `bool` | `false` | no |
| <a name="input_keda_enabled"></a> [keda\_enabled](#input\_keda\_enabled) | (Optional) Specifies whether KEDA Autoscaler can be used for workloads. | `bool` | `false` | no |
| <a name="input_key_vault_bypass"></a> [key\_vault\_bypass](#input\_key\_vault\_bypass) | (Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None. | `string` | `"AzureServices"` | no |
| <a name="input_key_vault_default_action"></a> [key\_vault\_default\_action](#input\_key\_vault\_default\_action) | (Required) The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. Possible values are Allow and Deny. | `string` | `"Allow"` | no |
| <a name="input_key_vault_enable_rbac_authorization"></a> [key\_vault\_enable\_rbac\_authorization](#input\_key\_vault\_enable\_rbac\_authorization) | (Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to false. | `bool` | `false` | no |
| <a name="input_key_vault_enabled_for_deployment"></a> [key\_vault\_enabled\_for\_deployment](#input\_key\_vault\_enabled\_for\_deployment) | (Optional) Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false. | `bool` | `true` | no |
| <a name="input_key_vault_enabled_for_disk_encryption"></a> [key\_vault\_enabled\_for\_disk\_encryption](#input\_key\_vault\_enabled\_for\_disk\_encryption) | (Optional) Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false. | `bool` | `true` | no |
| <a name="input_key_vault_enabled_for_template_deployment"></a> [key\_vault\_enabled\_for\_template\_deployment](#input\_key\_vault\_enabled\_for\_template\_deployment) | (Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false. | `bool` | `true` | no |
| <a name="input_key_vault_purge_protection_enabled"></a> [key\_vault\_purge\_protection\_enabled](#input\_key\_vault\_purge\_protection\_enabled) | (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false. | `bool` | `true` | no |
| <a name="input_key_vault_sku_name"></a> [key\_vault\_sku\_name](#input\_key\_vault\_sku\_name) | (Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| <a name="input_key_vault_soft_delete_retention_days"></a> [key\_vault\_soft\_delete\_retention\_days](#input\_key\_vault\_soft\_delete\_retention\_days) | (Optional) The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days. | `number` | `30` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specifies the AKS Kubernetes version | `string` | `"1.21.1"` | no |
| <a name="input_loc"></a> [loc](#input\_loc) | Aberbation of location/region where Azure resource will be created. | `string` | `"eus"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where Azure resource will be created. | `string` | `"EastUS"` | no |
| <a name="input_log_analytics_retention_days"></a> [log\_analytics\_retention\_days](#input\_log\_analytics\_retention\_days) | Specifies the number of days of the retention policy | `number` | `30` | no |
| <a name="input_network_dns_service_ip"></a> [network\_dns\_service\_ip](#input\_network\_dns\_service\_ip) | Specifies the DNS service IP | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Specifies the network plugin of the AKS cluster | `string` | `"azure"` | no |
| <a name="input_network_service_cidr"></a> [network\_service\_cidr](#input\_network\_service\_cidr) | Specifies the service CIDR | `string` | n/a | yes |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | (Optional) Enable or Disable the OIDC issuer URL. | `bool` | `true` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | (Optional) Is Open Service Mesh enabled? For more details, please visit Open Service Mesh for AKS. | `bool` | `true` | no |
| <a name="input_pod_subnet_address_prefix"></a> [pod\_subnet\_address\_prefix](#input\_pod\_subnet\_address\_prefix) | Specifies the address prefix of the pod subnet | `list(string)` | n/a | yes |
| <a name="input_pod_subnet_name"></a> [pod\_subnet\_name](#input\_pod\_subnet\_name) | Specifies the name of the pod subnet. | `string` | `"PodSubnet"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free. | `string` | `"Free"` | no |
| <a name="input_solution_plan_map"></a> [solution\_plan\_map](#input\_solution\_plan\_map) | Specifies solutions to deploy to log analytics workspace | `map(any)` | <pre>{<br>  "ContainerInsights": {<br>    "product": "OMSGallery/ContainerInsights",<br>    "publisher": "Microsoft"<br>  }<br>}</pre> | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | (Required) Specifies the SSH public key for the jumpbox virtual machine and AKS worker nodes. | `string` | `"*****Key*****\n"` | no |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | (Optional) Specifies the account kind of the storage account | `string` | `"StorageV2"` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | (Optional) Specifies the replication type of the storage account | `string` | `"LRS"` | no |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | (Optional) Specifies the account tier of the storage account | `string` | `"Standard"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a map of tags to be applied to the resources created. | `map(any)` | n/a | yes |
| <a name="input_vertical_pod_autoscaler_enabled"></a> [vertical\_pod\_autoscaler\_enabled](#input\_vertical\_pod\_autoscaler\_enabled) | (Optional) Specifies whether Vertical Pod Autoscaler should be enabled. | `bool` | `true` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Specifies the name of the jumpbox virtual machine | `string` | `"TestVm"` | no |
| <a name="input_vm_os_disk_image"></a> [vm\_os\_disk\_image](#input\_vm\_os\_disk\_image) | Specifies the os disk image of the virtual machine | `map(string)` | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "18.04-LTS",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_vm_os_disk_storage_account_type"></a> [vm\_os\_disk\_storage\_account\_type](#input\_vm\_os\_disk\_storage\_account\_type) | Specifies the storage account type of the os disk of the jumpbox virtual machine | `string` | `"Premium_LRS"` | no |
| <a name="input_vm_public_ip"></a> [vm\_public\_ip](#input\_vm\_public\_ip) | (Optional) Specifies whether create a public IP for the virtual machine | `bool` | `false` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Specifies the size of the jumpbox virtual machine | `string` | `"Standard_DS1_v2"` | no |
| <a name="input_vm_subnet_address_prefix"></a> [vm\_subnet\_address\_prefix](#input\_vm\_subnet\_address\_prefix) | Specifies the address prefix of the jumbox subnet | `list(string)` | n/a | yes |
| <a name="input_vm_subnet_name"></a> [vm\_subnet\_name](#input\_vm\_subnet\_name) | Specifies the name of the jumpbox subnet | `string` | `"VmSubnet"` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | (Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->