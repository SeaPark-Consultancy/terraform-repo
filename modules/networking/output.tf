output "vnet_id" {
  value = var.existing_vnet != null ? data.azurerm_virtual_network.existing_vnet[0].id : azurerm_virtual_network.sp_vnet[0].id
  description = "The ID of the Virtual Network"
}

output "subnet_ids" {
  value = resource.azurerm_subnet.subnet
  description = "The Subnet resources created in the VNet"
}

output "nsg_ids" {
  value = azurerm_network_security_group.nsg
  description = "The Network Security Group IDs created"
}

output "nsg_associations" {
  value = azurerm_subnet_network_security_group_association.subnet_nsg_association
  description = "The NSG associations with subnets"
}

# output "dns_zone_names" {
#     value = { for index, zone in azurerm_private_dns_zone.dns_zone : index => zone.name }
# }

output "vnet_name" {
  value = var.existing_vnet != null ? data.azurerm_virtual_network.existing_vnet[0].name : azurerm_virtual_network.sp_vnet[0].name
  description = "The name of the Virtual Network"
}