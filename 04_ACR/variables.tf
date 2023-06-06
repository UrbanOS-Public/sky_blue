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

variable "acr_sku" {
  description = "Specifies the SKU of the container registry"
  type        = string
  default     = "Premium"

  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "The container registry sku is invalid."
  }
}

variable "acr_admin_enabled" {
  description = "Specifies whether admin is enabled for the container registry"
  type        = bool
  default     = true
}

variable "acr_georeplication_locations" {
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = []
}

variable "vm_subnet_name" {
  description = "Specifies the name of the jumpbox subnet"
  default     = "VmSubnet"
  type        = string
}