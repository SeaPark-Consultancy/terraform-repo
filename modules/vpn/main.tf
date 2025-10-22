data "azurerm_resource_group" "existing" {
  name = "rg-terraform-test-zone"  # Name of the RG you created manually
}


resource "azurerm_virtual_network" "seapark_test_vnet" {
  name                = "vnet-terraform-test-zone"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
}

resource "azurerm_subnet" "storage_container_subnet" {
  name                 = "snet-storage-containers"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = azurerm_virtual_network.seapark_test_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "keyvault_container_subnet" {
  name                 = "snet-keyvault"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = azurerm_virtual_network.seapark_test_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints = ["Microsoft.KeyVault"]
}

resource "azurerm_subnet" "datafactory_container_subnet" {
  name                 = "snet-datafactory"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = azurerm_virtual_network.seapark_test_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}
