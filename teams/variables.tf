variable "subscription" {}

variable "tenant" {}

variable "resource_group_name" {
    type = string
}


variable subnet_config {}
variable sa_config{}


variable nsg_config {
    default = {}

}
variable dns_zone_names {
    default = {}
}

variable key_vault_ip_address {}
variable data_factory_ip_address {}

variable "address_space" {}