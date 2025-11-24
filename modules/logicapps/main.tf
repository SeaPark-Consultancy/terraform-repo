

data "azurerm_resource_group" "existing" {
  name = var.resource_group_name # Name of the RG you created manually
}

data "azurerm_storage_account" "existing" {
  name                = var.storarge_account_name
  resource_group_name = data.azurerm_resource_group.existing.name
}

////////////////////////////////////////////////////////////////////////////////////////

resource "azurerm_storage_share" "share" {
  name               = "sharename-${var.environment}"
  storage_account_id = data.azurerm_storage_account.existing.id
  quota              = 50

}

resource "azurerm_service_plan" "service_plan" {
  name                = "sp-${var.environment}-001"
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = data.azurerm_resource_group.existing.location
  sku_name            = "WS1"
  os_type             = "Windows"


}

resource "azurerm_user_assigned_identity" "uai" {
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = data.azurerm_resource_group.existing.location
  name                = "uai-${var.environment}-001"
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                       = "logic-${var.logic_app_name}-${var.environment}-001"
  location                   = data.azurerm_resource_group.existing.location
  resource_group_name        = data.azurerm_resource_group.existing.name
  app_service_plan_id        = azurerm_service_plan.service_plan.id
  storage_account_name       = data.azurerm_storage_account.existing.name
  storage_account_access_key = data.azurerm_storage_account.existing.primary_access_key
  storage_account_share_name = azurerm_storage_share.share.name

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"

  }


}