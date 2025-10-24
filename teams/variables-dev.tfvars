subnet_config = {
    "data-factory" = {
    subnet_cidr       = "10.0.1.0/24"
    service_endpoints = []
    delegation        = null
    }
  "storage-account" = {
    subnet_cidr       = "10.0.2.0/24"
    service_endpoints = []
    delegation        = null
  }
  "key-vault" = {
    subnet_cidr       = "10.0.3.0/24"
    service_endpoints = []
    delegation        = null
  }
}

sa_config = {
        name = "storagecontainer1"
        endpoints = {
           blob = {
               type = "blob"
               ip_address = "10.0.2.5"
           }
        }
        containers = ["container001", "container002", "container003"]
        account_kind = "StorageV2"
        storage_tier = "Standard"
        replication_type = "LRS"
        
    }


key_vault_ip_address = "10.0.3.5"
data_factory_ip_address = "10.0.1.5"
address_space = "10.0.0.0/22"

subscription = "b7a556dd-1e24-4a47-8184-7aa893f77e58"
tenant = "791dbe2a-50a0-4d28-ae27-8c987f8570dc"
resource_group_name = "rg-terraform-test-zone"
