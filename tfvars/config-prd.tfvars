prefix   = "urbanos"
suffix   = "prd"
loc      = "eus"

location = "EastUS"
tags = {
  terraform     = "true",
  environment   = "PRD",
  solution      = "UrbanOS"
}
kubernetes_version = 1.26
aks_vnet_address_space = ["10.20.0.0/16"]
hub_address_space = ["10.21.0.0/16"]
hub_firewall_subnet_address_prefix = ["10.21.0.0/24"]
hub_bastion_subnet_address_prefix  = ["10.21.1.0/24"]
default_node_pool_subnet_address_prefix =  ["10.20.0.0/20"]
additional_node_pool_subnet_address_prefix = ["10.20.16.0/20"]
pod_subnet_address_prefix = ["10.20.32.0/20"]
vm_subnet_address_prefix = ["10.20.48.0/20"]
network_dns_service_ip = "10.22.0.10"
network_service_cidr = "10.22.0.0/24"
admin_group_object_ids = ["63babf21-108e-40c9-9851-be3434d5cdfb"]
log_analytics_retention_days = 30
default_node_pool_vm_size = "Standard_B2ms"
additional_node_pool_vm_size = "Standard_B2ms"