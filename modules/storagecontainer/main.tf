locals {
  sanitized_sa_name = replace(replace(lower("adls${var.sa_config.name}${var.environment}"), "[^a-z0-9]", ""), "-", "")
}



data "azurerm_resource_group" "existing" {
  name = var.resource_group_name  # Name of the RG you created manually
}

# data "azurerm_subnet" "storage_container_subnet" {
#   name                 = var.subnet_name
#   resource_group_name  = data.azurerm_resource_group.existing.name
#   virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
# }

////////////////////////////////////////////////////////////////////////////////////////////////////

resource azurerm_storage_account "sa" { 
  name = local.sanitized_sa_name
  location = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  account_kind = var.sa_config.account_kind
  account_tier  = var.sa_config.storage_tier

  tags = var.tag
  account_replication_type = var.sa_config.replication_type

  #public_network_access_enabled = false
  #is_hns_enabled = true

  network_rules {
    default_action = "Allow"
  }

  blob_properties {
    versioning_enabled = true
    change_feed_enabled = true
  }
}


resource "azurerm_storage_data_lake_gen2_filesystem" "sa-filesystem" {
  for_each           = var.sa_config.containers
  name               = each.value
  storage_account_id = resource.azurerm_storage_account.sa.id
}

#Create private Endpoint for each SA blob
resource "azurerm_private_endpoint" "saendpoint" {
  for_each              = var.sa_config.endpoints
  name                  = "${azurerm_storage_account.sa.name}pe"
  location              = data.azurerm_resource_group.existing.location
  resource_group_name   = data.azurerm_resource_group.existing.name
  # subnet_id             = [data.azurerm_subnet.storage_container_subnet.id]
  subnet_id             = var.subnet_id

  private_service_connection {
    name                           = "${azurerm_storage_account.sa.name}pscpe"
    private_connection_resource_id = azurerm_storage_account.sa.id
    is_manual_connection           = false
    subresource_names              = [each.value.type]

  }
  ip_configuration {
    name                           = "${azurerm_storage_account.sa.name}pscpe${each.value.type}ipconf"
    private_ip_address             = each.value.ip_address
    subresource_name               = each.value.type 
  }
      
}

resource "azurerm_private_dns_a_record" "sadns" {
  for_each              = { for k,v in var.sa_config.endpoints : k=>v if can(var.dns_zone_names[v]) }
  name                  = azurerm_storage_account.sa.name
  zone_name             = var.dns_zone_names[each.value.type]
  resource_group_name   = var.resource_group_name
  ttl                   = 3600
  records               = [ each.value.ip_address ]
}

