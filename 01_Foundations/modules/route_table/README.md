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
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_private_ip"></a> [firewall\_private\_ip](#input\_firewall\_private\_ip) | Firewall private IP | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location where RouteTable will be deployed | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group where RouteTable will be deployed | `string` | n/a | yes |
| <a name="input_route_name"></a> [route\_name](#input\_route\_name) | AKS route name | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | RouteTable name | `string` | n/a | yes |
| <a name="input_subnets_to_associate"></a> [subnets\_to\_associate](#input\_subnets\_to\_associate) | (Optional) Specifies the subscription id, resource group name, and name of the subnets to associate | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Specifies the tags of the storage account | `map` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->