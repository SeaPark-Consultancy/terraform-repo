data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}


resource "azurerm_logic_app_workflow" "example" {
  name                = "workflow1"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  identity {
    type = "SystemAssigned"
    #type = "User Assigned"
  }

  /* 
  Only needs uncommented if using User Assigned Identity
  depends on = [azurerm_user_assigned_identity.uai]
  */

}



/* 
Used to create User Assigned Identity if needed however system assigned is used in this module
resource "azurerm_user_assigned_identity" "uai" {
  name = var.uai_name
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}
*/
