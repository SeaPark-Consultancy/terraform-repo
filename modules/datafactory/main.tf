data "azurerm_resource_group" "existing" {
  name = "rg-terraform-test-zone"  # Name of the RG you created manually
}

resource azurerm_data_factory "datafactory" {
  name                = "mftestdatafactory002"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  identity {
    type = "SystemAssigned"
  }

}