output "database_id" {
    value       = azurerm_mssql_database.example.id
    description = "The ID of the SQL Database"
}

output "sql_server_name" {
    value       = azurerm_mssql_server.example.name
    description = "The name of the SQL Server"
}
