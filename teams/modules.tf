terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = var.subscription
  tenant_id = var.tenant
}



module "networking" {
  source = "../../modules/networking"

  # Mandatory variables  
  resource_group_name = var.resource_group_name
  vnet_address_space =  var.address_space # to be confirmed



  # Optional variables
   nsg_config = var.nsg_config
   subnet_config = var.subnet_config
   dns_zones = var.dns_zone_names
}

module "storage" {
    source = "../../modules/storagecontainer"

    resource_group_name = var.resource_group_name
    subnet_id = module.networking.subnet_ids["storage-account"].id
    # tag = var.tag
    sa_config = var.sa_config
    dns_zone_names = var.dns_zone_names
}

module "keyvault" {
  source = "../../modules/keyvault"

  resource_group_name = var.resource_group_name
  keyvault_name = "dmu-keyvault"
  subnet_id = module.networking.subnet_ids["key-vault"].id
  enable_private_endpoint = true
  ip_address = var.key_vault_ip_address
}

module "datafactory" {
  source = "../../modules/datafactory"

  resource_group_name = var.resource_group_name
  subnet_id           = module.networking.subnet_ids["data-factory"].id
  datafactory_name    = "dmu-datafactory"
  ip_address          = var.data_factory_ip_address
  
}
