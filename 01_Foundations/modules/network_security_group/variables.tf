variable "name" {
  description = "(Required) Specifies the name of the network security group"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the resource group name of the network security group"
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location of the network security group"
  type        = string
}

variable "security_rules" {
  description = "(Optional) Specifies the security rules of the network security group"
  type        = list(object)
  default     = []
}

variable "tags" {
  description = "(Optional) Specifies the tags of the network security group"
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace resource id"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 7
}


variable network_watcher_name {
  description = "(Required) The name of the Network Watcher. Changing this forces a new resource to be created."
  type = string
  default = "NetworkWatcher_eastus"
}

variable network_watcher_resource_group_name {
  description = "(Required) The name of the resource group in which the Network Watcher was deployed. Changing this forces a new resource to be created"
  type = string
  default = "NetworkWatcherRG"
}

variable "diagnostics_storage_account_id" {
  description = "(Required) The ID of the Storage Account where flow logs are stored."
  type = string
}