
data "azurerm_resource_group" "existing" {
  name = var.resource_group_name  # Name of the RG you created manually
}

//check of the virtual network already exists
data "azurerm_virtual_network" "existing_vnet" {
  count = var.existing_vnet != null ? 1 : 0
  name                = var.existing_vnet.name
  resource_group_name = data.azurerm_resource_group.existing.name
}

//Create VNET
resource "azurerm_virtual_network" "sp_vnet" {

  count = var.existing_vnet == null ? 1 : 0
  resource_group_name = data.azurerm_resource_group.existing.name

  name                = "vnet-dmu-${var.environment}-001" 
  tags = var.tag

  address_space       = [var.vnet_address_space]
  location            = data.azurerm_resource_group.existing.location
  
}

//Create Subnets 
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet_config
  name                 = "snet-dmu-${var.environment}-${each.key}-001" 
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.existing_vnet != null ? data.azurerm_virtual_network.existing_vnet[0].name : resource.azurerm_virtual_network.sp_vnet[0].name
  address_prefixes     = [ each.value.subnet_cidr ]
  service_endpoints    = each.value.service_endpoints
  dynamic "delegation" {
    for_each = each.value.delegation != null? [1] : []
    content {
      name = each.value.delegation.name
      service_delegation {
        name = each.value.delegation.delegation-name
        actions = each.value.delegation.actions
      } 
    }
  }

}

//Create NSGs
resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg_config
  tags = var.tag
  name = "sp-nsg-${each.key}"
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each = var.nsg_config
  subnet_id                 = azurerm_subnet.subnet[each.value.associate_with].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}


//Create DNS Zones
resource "azurerm_private_dns_zone" "dns_zone" {
  for_each = var.dns_zones
  name = each.value
  resource_group_name = data.azurerm_resource_group.existing.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vnet_link" {
  for_each = azurerm_private_dns_zone.dns_zone
  name                  = "${each.value.name}-dnszonelink"
  resource_group_name   = data.azurerm_resource_group.existing.name
  private_dns_zone_name = each.value.name
  virtual_network_id    = var.existing_vnet != null ? data.azurerm_virtual_network.existing_vnet[0].id : resource.azurerm_virtual_network.sp_vnet[0].id
}


