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
| [azurerm_virtual_network_peering.peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peering-back](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_peering_name_1_to_2"></a> [peering\_name\_1\_to\_2](#input\_peering\_name\_1\_to\_2) | (Optional) Specifies the name of the first to second virtual network peering | `string` | `"peering1to2"` | no |
| <a name="input_peering_name_2_to_1"></a> [peering\_name\_2\_to\_1](#input\_peering\_name\_2\_to\_1) | (Optional) Specifies the name of the second to first virtual network peering | `string` | `"peering2to1"` | no |
| <a name="input_vnet_1_id"></a> [vnet\_1\_id](#input\_vnet\_1\_id) | Specifies the resource id of the first virtual network | `string` | n/a | yes |
| <a name="input_vnet_1_name"></a> [vnet\_1\_name](#input\_vnet\_1\_name) | Specifies the name of the first virtual network | `string` | n/a | yes |
| <a name="input_vnet_1_rg"></a> [vnet\_1\_rg](#input\_vnet\_1\_rg) | Specifies the resource group name of the first virtual network | `string` | n/a | yes |
| <a name="input_vnet_2_id"></a> [vnet\_2\_id](#input\_vnet\_2\_id) | Specifies the resource id of the second virtual network | `string` | n/a | yes |
| <a name="input_vnet_2_name"></a> [vnet\_2\_name](#input\_vnet\_2\_name) | Specifies the name of the second virtual network | `string` | n/a | yes |
| <a name="input_vnet_2_rg"></a> [vnet\_2\_rg](#input\_vnet\_2\_rg) | Specifies the resource group name of the second virtual network | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->