<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_monitor_diagnostic_setting.nsg_settings](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_role_assignment.assign-vm-role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_machine_extension.aad](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.custom_script](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.dependency_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.monitor_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | (Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the jumpbox. | `list(string)` | n/a | yes |
| <a name="input_admin_ssh_public_key"></a> [admin\_ssh\_public\_key](#input\_admin\_ssh\_public\_key) | Specifies the public SSH key | `string` | n/a | yes |
| <a name="input_boot_diagnostics_storage_account"></a> [boot\_diagnostics\_storage\_account](#input\_boot\_diagnostics\_storage\_account) | (Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. | `any` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | (Required) Specifies the name of the container that contains the custom script. | `string` | n/a | yes |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | (Required) Specifies the DNS domain name of the virtual machine | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the location of the virtual machine | `string` | n/a | yes |
| <a name="input_log_analytics_retention_days"></a> [log\_analytics\_retention\_days](#input\_log\_analytics\_retention\_days) | Specifies the number of days of the retention policy | `number` | `7` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Specifies the log analytics workspace id | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_key"></a> [log\_analytics\_workspace\_key](#input\_log\_analytics\_workspace\_key) | Specifies the log analytics workspace key | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_id"></a> [log\_analytics\_workspace\_resource\_id](#input\_log\_analytics\_workspace\_resource\_id) | Specifies the log analytics workspace resource id | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the virtual machine | `string` | n/a | yes |
| <a name="input_os_disk_image"></a> [os\_disk\_image](#input\_os\_disk\_image) | (Optional) Specifies the os disk image of the virtual machine | `map(string)` | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "18.04-LTS",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | (Optional) Specifies the storage account type of the os disk of the virtual machine | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | (Optional) Specifies whether create a public IP for the virtual machine | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the resource group name of the virtual machine | `string` | n/a | yes |
| <a name="input_script_name"></a> [script\_name](#input\_script\_name) | (Required) Specifies the name of the custom script. | `string` | n/a | yes |
| <a name="input_script_storage_account_key"></a> [script\_storage\_account\_key](#input\_script\_storage\_account\_key) | (Required) Specifies the name of the storage account that contains the custom script. | `string` | n/a | yes |
| <a name="input_script_storage_account_name"></a> [script\_storage\_account\_name](#input\_script\_storage\_account\_name) | (Required) Specifies the name of the storage account that contains the custom script. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | (Required) Specifies the size of the virtual machine | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Specifies the resource id of the subnet hosting the virtual machine | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Specifies the tags of the storage account | `map` | `{}` | no |
| <a name="input_vm_user"></a> [vm\_user](#input\_vm\_user) | (Required) Specifies the username of the virtual machine | `string` | `"azadmin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Specifies the public IP address of the virtual machine |
| <a name="output_username"></a> [username](#output\_username) | Specifies the username of the virtual machine |
<!-- END_TF_DOCS -->