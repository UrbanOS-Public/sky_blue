<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.55.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.55.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_host"></a> [bastion\_host](#module\_bastion\_host) | ./modules/bastion_host | n/a |
| <a name="module_namehub"></a> [namehub](#module\_namehub) | Azure/naming/azurerm | 0.2.0 |
| <a name="module_namespoke"></a> [namespoke](#module\_namespoke) | Azure/naming/azurerm | 0.2.0 |
| <a name="module_virtual_machine"></a> [virtual\_machine](#module\_virtual\_machine) | ./modules/virtual_machine | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.ssh_public_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.hub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.spoke](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.st](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.spoke_bastion_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.spoke_vm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) Specifies the admin username of the jumpbox virtual machine and AKS worker nodes. | `string` | `"azadmin"` | no |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | Specifies the domain name for the jumbox virtual machine | `string` | `"jumpbox"` | no |
| <a name="input_loc"></a> [loc](#input\_loc) | n/a | `string` | `"eus"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where Azure resource will be created. | `string` | `"EastUS"` | no |
| <a name="input_log_analytics_retention_days"></a> [log\_analytics\_retention\_days](#input\_log\_analytics\_retention\_days) | Specifies the number of days of the retention policy | `number` | `30` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_script_name"></a> [script\_name](#input\_script\_name) | (Required) Specifies the name of the custom script. | `string` | `"configure-jumpbox-vm.sh"` | no |
| <a name="input_script_storage_account_name"></a> [script\_storage\_account\_name](#input\_script\_storage\_account\_name) | (Required) Specifies the name of the storage account that contains the custom script. | `string` | `"https://raw.githubusercontent.com/risticmarko/scripts/main"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a map of tags to be applied to the resources created. | `map(any)` | n/a | yes |
| <a name="input_vm_os_disk_image"></a> [vm\_os\_disk\_image](#input\_vm\_os\_disk\_image) | Specifies the os disk image of the virtual machine | `map(string)` | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "18.04-LTS",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_vm_os_disk_storage_account_type"></a> [vm\_os\_disk\_storage\_account\_type](#input\_vm\_os\_disk\_storage\_account\_type) | Specifies the storage account type of the os disk of the jumpbox virtual machine | `string` | `"Premium_LRS"` | no |
| <a name="input_vm_public_ip"></a> [vm\_public\_ip](#input\_vm\_public\_ip) | (Optional) Specifies whether create a public IP for the virtual machine | `bool` | `false` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Specifies the size of the jumpbox virtual machine | `string` | `"Standard_DS1_v2"` | no |
| <a name="input_vm_subnet_name"></a> [vm\_subnet\_name](#input\_vm\_subnet\_name) | Specifies the name of the jumpbox subnet | `string` | `"VmSubnet"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->