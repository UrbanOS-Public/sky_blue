variable "suffix" {
  type = string
  default = "CloudLabM"
}

variable "prefix" {
  type = string
  default = "Enviroment"
}

variable "account_replication_type" {
  type = string
  default = "LRS"
}

variable "location" {
  type = string
  default = "EastUS"
  description = "The location/region where Azure resource will be created."
}

variable "tags" {
  type        = map(any)
  description = "Specifies a map of tags to be applied to the resources created."
}