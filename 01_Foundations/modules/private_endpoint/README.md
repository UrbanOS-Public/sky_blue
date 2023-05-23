<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | (Optional) Specifies whether the private endpoint connection requires manual approval from the remote resource owner. | `string` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the private endpoint. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | (Required) Specifies the resource id of the private link service | `string` | n/a | yes |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | n/a | `map` | `{}` | no |
| <a name="input_private_dns_zone_group_ids"></a> [private\_dns\_zone\_group\_ids](#input\_private\_dns\_zone\_group\_ids) | (Required) Specifies the list of Private DNS Zones to include within the private\_dns\_zone\_group. | `list(string)` | n/a | yes |
| <a name="input_private_dns_zone_group_name"></a> [private\_dns\_zone\_group\_name](#input\_private\_dns\_zone\_group\_name) | (Required) Specifies the Name of the Private DNS Zone Group. Changing this forces a new private\_dns\_zone\_group resource to be created. | `string` | n/a | yes |
| <a name="input_request_message"></a> [request\_message](#input\_request\_message) | (Optional) Specifies a message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Specifies the resource id of the subnet | `string` | n/a | yes |
| <a name="input_subresource_name"></a> [subresource\_name](#input\_subresource\_name) | (Optional) Specifies a subresource name which the Private Endpoint is able to connect to. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Specifies the tags of the network security group | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the private endpoint. |
| <a name="output_private_dns_zone_configs"></a> [private\_dns\_zone\_configs](#output\_private\_dns\_zone\_configs) | Specifies the private dns zone(s) configuration |
| <a name="output_private_dns_zone_group"></a> [private\_dns\_zone\_group](#output\_private\_dns\_zone\_group) | Specifies the private dns zone group of the private endpoint. |
<!-- END_TF_DOCS -->