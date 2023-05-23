prefix   = "urbanos"
suffix   = "uat"
loc      = "eus"

location = "EastUS"
tags = {
  terraform     = "true",
  environment   = "UAT",
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
admin_group_object_ids = ["183f9f5f-82fa-4d46-a3ee-a5a940be9ed8"]
log_analytics_retention_days = 30