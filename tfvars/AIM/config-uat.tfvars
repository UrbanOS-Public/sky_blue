prefix   = "aim"
suffix   = "uat"
loc      = "eus"

spoke_name = "spk"
hub_name = "hub"
logs_name = "logs"

location = "EastUS"
tags = {
  terraform     = "true",
  environment   = "UAT",
  solution      = "AIM"
}
kubernetes_version = 1.26
spoke_address_space = ["10.10.0.0/16"]
hub_address_space = ["10.11.0.0/16"]
hub_firewall_subnet_address_prefix = ["10.1.0.0/24"]
hub_bastion_subnet_address_prefix  = ["10.11.1.0/24"]
default_node_pool_subnet_address_prefix =  ["10.10.0.0/20"]
additional_node_pool_subnet_address_prefix = ["10.10.16.0/20"]
pod_subnet_address_prefix = ["10.10.32.0/20"]
vm_subnet_address_prefix = ["10.10.48.0/20"]
network_dns_service_ip = "10.12.0.10"
network_service_cidr = "10.12.0.0/24"
admin_group_object_ids = ["76c5ff26-3bc4-413f-9325-7154426ff21f"]
log_analytics_retention_days = 30
default_node_pool_vm_size = "Standard_B2ms"
additional_node_pool_vm_size = "Standard_B2ms"