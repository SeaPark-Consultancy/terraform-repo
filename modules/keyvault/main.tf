data "azurerm_resource_group" "existing" {
  name = "rg-terraform-test-zone"  # Name of the RG you created manually
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = "vnet-terraform-test-zone"
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "key_vault_subnet" {
  name                 = "snet-keyvault"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
}

resource azurerm_key_vault "example" {
  name                        = "mfkeyvault002"
  location                    = data.azurerm_resource_group.existing.location
  resource_group_name         = data.azurerm_resource_group.existing.name
  tenant_id = var.tenant
  sku_name = "standard"

  network_acls {
    default_action = "Deny"
    virtual_network_subnet_ids = [data.azurerm_subnet.key_vault_subnet.id]
    bypass = "None"
  }

}
