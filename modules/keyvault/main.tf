data "azurerm_resource_group" "existing" {
  name = var.resource_group_name  # Name of the RG you created manually
}


data "azurerm_client_config" "current" {}



resource azurerm_key_vault "keyvault" {
  name                        = "kv-${var.keyvault_name}-${var.environment}-001"
  location                    = data.azurerm_resource_group.existing.location
  resource_group_name         = data.azurerm_resource_group.existing.name
  tenant_id = var.tenant
  sku_name = var.sku_name
  purge_protection_enabled = true

  network_acls {
    default_action = "Deny"
    #virtual_network_subnet_ids = [data.azurerm_subnet.key_vault_subnet.id]
    bypass = "None"
  
  }

  enable_rbac_authorization = true

}

resource "azurerm_private_endpoint" "keyvault_private_endpoint" {
  count = var.enable_private_endpoint ? 1 : 0
  name = "${azurerm_key_vault.keyvault.name}_pe"
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  subnet_id = var.subnet_id

  private_service_connection {
    name = "${azurerm_key_vault.keyvault.name}_psc"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection = false
    subresource_names = ["vault"]
  }

  ip_configuration {
    name = "${azurerm_key_vault.keyvault.name}_vault_ipconfig"
    private_ip_address = var.ip_address
    member_name = "default"
    subresource_name = "vault"
}
}

//////////////////////////////////////////////////////////////////////////////////
# USE RBAC INSTEAD OF ACCESS POLICIES
# resource "azurerm_key_vault_access_policy" "access_policy" {
#   for_each = var.access_policies
#   key_vault_id = azurerm_key_vault.keyvault.id
#   tenant_id    = each.value.tenant_id
#   object_id    = each.value.object_id

#   secret_permissions = each.value.secret_permissions
#   key_permissions    = each.value.key_permissions
#   certificate_permissions = each.value.certificate_permissions
# }


# resource "azurerm_key_vault_access_policy" "key_vault_ap" {

# key_vault_id = azurerm_key_vault.keyvault.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = data.azurerm_client_config.current.object_id

#   key_permissions = [
#     "Get",
#     "List",
#     "Update",
#     "Create",
#     "Import",
#     "Delete",
#     "Recover",
#     "Backup",
#     "Restore",
#     "Purge"
#   ]

#   secret_permissions = [
#     "Get",
#     "List",
#     "Set",
#     "Delete",
#     "Recover",
#     "Backup",
#     "Restore",
#     "Purge"
#   ]
# }