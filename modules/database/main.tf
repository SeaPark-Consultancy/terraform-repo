data "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_location
}

resource "azurerm_mssql_server" "example" {
  name                         = "${var.database_name}-sqlserver-001"
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  location                     = data.azurerm_resource_group.resource_group.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "example" {
  name         = "db-${var.database_name}-${var.environment}"
  server_id    = azurerm_mssql_server.example.id
  max_size_gb  = 2
  sku_name     = var.sku_type
  enclave_type = "VBS"

  tags = var.tag

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

# resource "azurerm_private_endpoint" "adf_private_endpoint" {
#   name = "pe-${azurerm_mssql_database.example.name}-${var.environment}"
#   location = data.azurerm_resource_group.existing.location
#   resource_group_name = data.azurerm_resource_group.existing.name
#   subnet_id = var.subnet_id

#   private_service_connection {
#     name = "psc-${azurerm_mssql_database.example.name}-${var.environment}"
#     private_connection_resource_id = azurerm_mssql_database.example.id
#     is_manual_connection = false
#     subresource_names = ["example"]
#   }

#   ip_configuration {
#     name = "ip-config-${azurerm_mssql_database.example.name}-${var.environment}"
#     private_ip_address = var.ip_address
#     subresource_name = "example"
# }
# }