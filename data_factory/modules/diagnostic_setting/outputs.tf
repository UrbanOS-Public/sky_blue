output "id" {
  value = azurerm_monitor_diagnostic_setting.this.id
  description = "The ID of the Diagnostic Setting."
}

output "log_category_type" {
  value = data.azurerm_monitor_diagnostic_categories.this.log_category_type
  description = "The log_category_type of the Diagnostic Setting."
}

output "log_category_groups" {
  value = data.azurerm_monitor_diagnostic_categories.this.log_category_groups
  description = "The log_category_groups of the Diagnostic Setting."
}