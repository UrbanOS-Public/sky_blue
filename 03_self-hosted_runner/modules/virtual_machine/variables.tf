variable resource_group_name {
  description = "(Required) Specifies the resource group name of the virtual machine"
  type = string
}

variable name {
  description = "(Required) Specifies the name of the virtual machine"
  type = string
}

variable size {
  description = "(Required) Specifies the size of the virtual machine"
  type = string
}

variable "os_disk_image" {
  type        = map(string)
  description = "(Optional) Specifies the os disk image of the virtual machine"
  default     = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS" 
    version   = "latest"
  }
}

variable "os_disk_storage_account_type" {
  description = "(Optional) Specifies the storage account type of the os disk of the virtual machine"
  default     = "StandardSSD_LRS"
  type        = string

  validation {
    condition = contains(["Premium_LRS", "Premium_ZRS", "StandardSSD_LRS", "StandardSSD_ZRS",  "Standard_LRS"], var.os_disk_storage_account_type)
    error_message = "The storage account type of the OS disk is invalid."
  }
}

variable public_ip {
  description = "(Optional) Specifies whether create a public IP for the virtual machine"
  type = bool
  default = false
}

variable location {
  description = "(Required) Specifies the location of the virtual machine"
  type = string
}

variable domain_name_label {
  description = "(Required) Specifies the DNS domain name of the virtual machine"
  type = string
}

variable subnet_id {
  description = "(Required) Specifies the resource id of the subnet hosting the virtual machine"
  type        = string
}

variable vm_user {
  description = "(Required) Specifies the username of the virtual machine"
  type        = string
  default     = "azadmin"
}

variable "boot_diagnostics_storage_account" {
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}

variable "log_analytics_workspace_key" {
  description = "Specifies the log analytics workspace key"
  type        = string
}

variable "log_analytics_workspace_resource_id" {
  description = "Specifies the log analytics workspace resource id"
  type        = string
}


variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 7
}

variable "admin_ssh_public_key" {
  description = "Specifies the public SSH key"
  type        = string
}

variable "script_storage_account_name" {
  description = "(Required) Specifies the name of the storage account that contains the custom script."
  type        = string
}

variable "script_storage_account_key" {
  description = "(Required) Specifies the name of the storage account that contains the custom script."
  type        = string
}

variable "container_name" {
  description = "(Required) Specifies the name of the container that contains the custom script."
  type        = string
}

variable "script_name" {
  description = "(Required) Specifies the name of the custom script."
  type        = string
}

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the jumpbox."
  #default     = ["6e5de8c1-5a4b-409b-994f-0706e4403b77", "78761057-c58c-44b7-aaa7-ce1639c6c4f5"]
  type        = list(string)
}

variable "security_rules" {
  description = "A list of security rules to be created."
  type = list(object({
    name      = string
    priority  = number
    direction = string 
    access    = string
    protocol  = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
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