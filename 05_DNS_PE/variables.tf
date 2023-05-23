variable "suffix" {
  type = string
}

variable "prefix" {
  type = string
}

variable "location" {
  type = string
  default = "EastUS"
  description = "The location/region where Azure resource will be created."
}

variable "loc" {
  type = string
  default = "eus"
}

variable "tags" {
  type        = map(any)
  description = "Specifies a map of tags to be applied to the resources created."
}

variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 30
}

variable "vm_public_ip" {
  description = "(Optional) Specifies whether create a public IP for the virtual machine"
  type = bool
  default = false
}

variable "vm_size" {
  description = "Specifies the size of the jumpbox virtual machine"
  default     = "Standard_DS1_v2"
  type        = string
}

variable "vm_os_disk_storage_account_type" {
  description = "Specifies the storage account type of the os disk of the jumpbox virtual machine"
  default     = "Premium_LRS"
  type        = string

  validation {
    condition = contains(["Premium_LRS", "Premium_ZRS", "StandardSSD_LRS", "StandardSSD_ZRS",  "Standard_LRS"], var.vm_os_disk_storage_account_type)
    error_message = "The storage account type of the OS disk is invalid."
  }
}

variable "vm_os_disk_image" {
  type        = map(string)
  description = "Specifies the os disk image of the virtual machine"
  default     = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS" 
    version   = "latest"
  }
}

variable "domain_name_label" {
  description = "Specifies the domain name for the jumbox virtual machine"
  default     = "jumpbox"
  type        = string
}

variable "admin_username" {
  description = "(Required) Specifies the admin username of the jumpbox virtual machine and AKS worker nodes."
  type        = string
  default     = "azadmin"
}

variable "vm_subnet_name" {
  description = "Specifies the name of the jumpbox subnet"
  default     = "VmSubnet"
  type        = string
}