data "azurerm_resource_group" "existing" {
  name = var.resource_group_name  # Name of the RG you created manually
}

resource azurerm_data_factory "datafactory" {
  name                = "adf-${var.datafactory_name}-${var.environment_name}-001"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  tags = var.tag
  managed_virtual_network_enabled = true


  identity {
    type = "SystemAssigned"
  }

}


resource "azurerm_private_endpoint" "adf_private_endpoint" {
  name = "${azurerm_data_factory.datafactory.name}_pe"
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  subnet_id = var.subnet_id

  private_service_connection {
    name = "${azurerm_data_factory.datafactory.name}_psc"
    private_connection_resource_id = azurerm_data_factory.datafactory.id
    is_manual_connection = false
    subresource_names = ["dataFactory"]
  }

  ip_configuration {
    name = "${azurerm_data_factory.datafactory.name}_ipconfig"
    private_ip_address = var.ip_address
    subresource_name = "dataFactory"
}
}

#private end point

