output "id" {
  value = azurerm_mssql_server.aim.id
  description = "Specifies the resource id of the SQL"
}

output "fully_qualified_domain_name" {
  value = azurerm_mssql_server.aim.fully_qualified_domain_name
  description = "The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net)"
}

output "restorable_dropped_database_ids" {
  value = azurerm_mssql_server.aim.restorable_dropped_database_ids
  description = "A list of dropped restorable database IDs on the server"
}

output "principal_id" {
    description = "The Principal ID for the Service Principal associated with the Identity of this SQL Server."
    value       = azurerm_mssql_server.aim.identity[0].principal_id
}