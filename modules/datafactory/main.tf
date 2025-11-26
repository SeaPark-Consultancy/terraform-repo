data "azurerm_resource_group" "existing" {
  name = var.resource_group_name  # Name of the RG you created manually
}

resource azurerm_data_factory "datafactory" {
  name                = "adfdmu-${var.datafactory_name}-${var.environment}-001"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  tags = var.tag
  managed_virtual_network_enabled = true


  identity {
    type = "SystemAssigned"
  }

}

resource "azurerm_data_factory_integration_runtime_self_hosted" "SHIR" {
  name            = "adfdmu-dataplatform-shir-001"
  data_factory_id = azurerm_data_factory.datafactory.id
}


resource "azurerm_private_endpoint" "adf_private_endpoint" {
  name = "pe-${azurerm_data_factory.datafactory.name}-${var.environment}"
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  subnet_id = var.subnet_id

  private_service_connection {
    name = "psc-${azurerm_data_factory.datafactory.name}-${var.environment}"
    private_connection_resource_id = azurerm_data_factory.datafactory.id
    is_manual_connection = false
    subresource_names = ["dataFactory"]
  }

  ip_configuration {
    name = "ipconfig-${azurerm_data_factory.datafactory.name}-${var.environment}"
    private_ip_address = var.ip_address
    subresource_name = "dataFactory"
  }
}


