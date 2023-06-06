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
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | ./modules/container_registry | n/a |
| <a name="module_namehub"></a> [namehub](#module\_namehub) | Azure/naming/azurerm | 0.2.0 |
| <a name="module_namespoke"></a> [namespoke](#module\_namespoke) | Azure/naming/azurerm | 0.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resources.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_admin_enabled"></a> [acr\_admin\_enabled](#input\_acr\_admin\_enabled) | Specifies whether admin is enabled for the container registry | `bool` | `true` | no |
| <a name="input_acr_georeplication_locations"></a> [acr\_georeplication\_locations](#input\_acr\_georeplication\_locations) | (Optional) A list of Azure locations where the container registry should be geo-replicated. | `list(string)` | `[]` | no |
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | Specifies the SKU of the container registry | `string` | `"Premium"` | no |
| <a name="input_loc"></a> [loc](#input\_loc) | n/a | `string` | `"eus"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where Azure resource will be created. | `string` | `"EastUS"` | no |
| <a name="input_log_analytics_retention_days"></a> [log\_analytics\_retention\_days](#input\_log\_analytics\_retention\_days) | Specifies the number of days of the retention policy | `number` | `30` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a map of tags to be applied to the resources created. | `map(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->