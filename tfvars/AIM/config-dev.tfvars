prefix   = "aim"
suffix   = "dev"
loc      = "eus"

spoke_name = "spk"
hub_name = "hub"
logs_name = "logs"

location = "EastUS"
tags = {
  terraform     = "true",
  environment   = "DEV",
  solution      = "AIM"
}
kubernetes_version = 1.26
spoke_address_space = ["10.0.0.0/16"]
hub_address_space = ["10.1.0.0/16"]
hub_firewall_subnet_address_prefix = ["10.1.0.0/24"]
hub_bastion_subnet_address_prefix  = ["10.1.1.0/24"]
default_node_pool_subnet_address_prefix =  ["10.0.0.0/20"]
additional_node_pool_subnet_address_prefix = ["10.0.16.0/20"]
pod_subnet_address_prefix = ["10.0.32.0/20"]
vm_subnet_address_prefix = ["10.0.48.0/20"]
adb_public_subnet_address_prefix = ["10.0.64.0/23"]
adb_private_subnet_address_prefix = ["10.0.66.0/23"]
adb_link_subnet_address_prefix = ["10.0.68.0/23"]
network_dns_service_ip = "10.2.0.10"
network_service_cidr = "10.2.0.0/24"
admin_group_object_ids = ["592308cb-ed13-4076-b3f5-d420a56748ad"]
log_analytics_retention_days = 30
default_node_pool_vm_size = "Standard_B4ms"
additional_node_pool_vm_size = "Standard_B2ms"
acr_georeplication_locations = ["WestUS2"]
sql_fw_rules = {
  marko = {
    start_ip = "47.203.195.3",
    end_ip = "47.203.195.3"
  },
  tampa = {
    start_ip = "63.169.116.6",
    end_ip = "63.169.116.6"
  },
  fred = {
    start_ip = "108.254.161.94",
    end_ip = "108.254.161.94"
  },
  sheik = {
    start_ip = "106.201.181.2",
    end_ip = "106.201.181.2"
  },
  pallavi = {
    start_ip = "171.76.86.211",
    end_ip = "171.76.86.211"
  },
  pallavi2 = {
    start_ip = "171.76.85.167",
    end_ip = "171.76.85.167"
  }
}
db_clusters = {
  cluster01 = {
    name = "Test cluster",
    cluster_autotermination_minutes = 720,
    cluster_num_workers = 0,
    data_security_mode = "SINGLE_USER",
    single_user_name = "test01@acp202325.onmicrosoft.com", #lowercase
    availability = "ON_DEMAND_AZURE",
    first_on_demand = 1,
    spot_bid_max_price = -1,
    node_type_id = "Standard_DS3_v2",
    spark_version = "13.2.x-cpu-ml-scala2.12",
    runtime_engine = "STANDARD"
  },
}

jumpbox_win = {
    "jmp01" = {
      username = "marko.ristic",
      ObjectID = "1f2daa50-0dfc-44fd-82fe-978ecef07d6e",
      daily_recurrence_time = "2100"
      timezone = "Eastern Standard Time"
      notification_email = "marko.ristic@accenture.com"
    }
    # "jmp02" = {
    #   username = "fred.estabrook"
    # }
    # "jmp03" = {
    #   username = "pallavi.s.srivastava"
    # }
    # "jmp04" = {
    #   username = "sheik.jahangeer"
    # }
  }