data "azurerm_resource_group" "existing" {
  name = var.resource_group_name # Name of the RG you created manually
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                     = "kvdmu${var.keyvault_name}-${var.environment}"
  location                 = data.azurerm_resource_group.existing.location
  resource_group_name      = data.azurerm_resource_group.existing.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = var.sku_name
  purge_protection_enabled = true

  # RBAC ISSUES # 
  #rbac_authorization_enabled = true
  enable_rbac_authorization = true

  network_acls {
    default_action = "Allow"
    #virtual_network_subnet_ids = [data.azurerm_subnet.key_vault_subnet.id]
    bypass = "None"

  }



}

resource "azurerm_private_endpoint" "keyvault_private_endpoint" {
  count               = var.enable_private_endpoint ? 1 : 0
  name                = "pe-${azurerm_key_vault.keyvault.name}-${var.environment}"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-${azurerm_key_vault.keyvault.name}-${var.environment}"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  ip_configuration {
    name               = "ipconfig-${azurerm_key_vault.keyvault.name}-${var.environment}"
    private_ip_address = var.ip_address
    member_name        = "default"
    subresource_name   = "vault"
  }
}



