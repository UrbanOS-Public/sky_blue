variable "target_resource_id" {
  description = "(Required) The ID of an existing Resource on which to configure Diagnostic Settings. Changing this forces a new resource to be created."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "(Required) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
   type        = string
}

variable "retention_policy_days" {
  description = "(Optional) The number of days for which this Retention Policy should apply."
  type        = number
  default     = 30
}

variable "diagnostics_settings_name" {
  description = "(Required) Specifies the name Diagnostics Data."
  type        = string
  default     = "diagnostics"
}


variable "log_analytics_destination_type" {
  description = "(Optional) When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
  type        = string
  default     = "Dedicated"
}

variable "storage_account_id" {
  description = "(Optional) The ID of the Storage Account where logs should be sent. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "eventhub_name" {
  description = "(Optional) Specifies the name of the Event Hub where Diagnostics Data should be sent. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "eventhub_authorization_rule_id" {
  description = "(Optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "logs" {
  description = "(Optional) Specifies a list of log categories to enable."
  type        = list(string)
  default     = []
}

variable "metrics" {
  description = "(Optional) Specifies a list of metrics to enable."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}