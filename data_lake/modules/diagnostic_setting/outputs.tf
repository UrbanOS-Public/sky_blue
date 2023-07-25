output "id" {
  value = azurerm_monitor_diagnostic_setting.this.id
  description = "The ID of the Diagnostic Setting."
}

output "log_category_typed" {
  value = data.azurerm_monitor_diagnostic_categories.this.log_category_types
  description = " List of the supported log category types of this resource to send to the destination."
}

output "log_category_groups" {
  value = data.azurerm_monitor_diagnostic_categories.this.log_category_groups
  description = "List of the supported log category groups of this resource to send to the destination."
}

output "metrics" {
  value = data.azurerm_monitor_diagnostic_categories.this.metrics
  description = "List of the Metric Categories supported for this Resource."
}