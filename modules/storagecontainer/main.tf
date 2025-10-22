data "azurerm_resource_group" "existing" {
  name = "rg-terraform-test-zone"  # Name of the RG you created manually
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = "vnet-terraform-test-zone"
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "storage_container_subnet" {
  name                 = "snet-storage-containers"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
}

////////////////////////////////////////////////////////////////////////////////////////////////////

resource azurerm_storage_account "example" { 
  name = "${var.name}${count.index}"
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  account_tier  = var.storage_tier

  # account_replication_type = var.replication_type
  account_replication_type = var.replication_type

  network_rules {
    default_action = var.default_action
    virtual_network_subnet_ids = [data.azurerm_subnet.storage_container_subnet.id]
  }

  count = var.sc_count

}

variable "storage_tier" {}
variable "replication_type" {}
variable "name" {}
variable "default_action" {}
variable "sc_count" {}
