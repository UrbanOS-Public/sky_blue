prefix   = "urbanos"
suffix   = "dev"
loc      = "eus"

location = "EastUS"
tags = {
  terraform     = "true",
  environment   = "DEV",
  solution      = "UrbanOS"
}
kubernetes_version = 1.26
aks_vnet_address_space = ["10.0.0.0/16"]
hub_address_space = ["10.1.0.0/16"]
hub_firewall_subnet_address_prefix = ["10.1.0.0/24"]
hub_bastion_subnet_address_prefix  = ["10.1.1.0/24"]
default_node_pool_subnet_address_prefix =  ["10.0.0.0/20"]
additional_node_pool_subnet_address_prefix = ["10.0.16.0/20"]
pod_subnet_address_prefix = ["10.0.32.0/20"]
vm_subnet_address_prefix = ["10.0.48.0/20"]
network_dns_service_ip = "10.2.0.10"
network_service_cidr = "10.2.0.0/24"
admin_group_object_ids = ["63babf21-108e-40c9-9851-be3434d5cdfb"]
log_analytics_retention_days = 30
default_node_pool_vm_size = "Standard_B2ms"
additional_node_pool_vm_size = "Standard_B2ms"
acr_georeplication_locations = ["WestUS2"]