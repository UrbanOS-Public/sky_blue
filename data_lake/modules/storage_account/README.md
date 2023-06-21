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
| [azurerm_key_vault_access_policy.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | (Optional) Specifies the account kind of the storage account | `string` | `"StorageV2"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Optional) Specifies the account tier of the storage account | `string` | `"Standard"` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | Allow or disallow public access to all blobs or containers in the storage accounts. The default interpretation is true for this property. | `string` | `"Allow"` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | Specifies IP rules for the storage account | `list(string)` | `[]` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Enable or disable hierarchical namespace. This is required for Azure Data Lake Storage Gen 2. | `bool` | `true` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Specifies id of key vault | `string` | n/a | yes |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | Specifies name of key vault key used for CMK encryption | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | (Optional) Specifies the kind of the storage account | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the location of the storage account | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the storage account | `string` | n/a | yes |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | (Optional) Specifies the replication type of the storage account | `string` | `"LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the resource group name of the storage account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Specifies the tags of the storage account | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Required) The tenant id of the system assigned identity which is used by master components. | `string` | n/a | yes |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | Specifies a list of resource ids for subnets | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the storage account |
| <a name="output_name"></a> [name](#output\_name) | Specifies the name of the storage account |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | Specifies the primary access key of the storage account |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | Specifies the primary blob endpoint of the storage account |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Specifies the principal id of the system assigned managed identity of the storage account |
<!-- END_TF_DOCS -->