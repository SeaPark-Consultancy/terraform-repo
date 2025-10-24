variable "tag" {
    type = map(string)
    default ={}

}

variable "datafactory_name" {
    description = "The name of the Data Factory."
    type        = string
}
variable "resource_location" {
    description = "The Azure region where resources will be created."
    type        = string
    default     = "North Europe"
}

variable "resource_group_name" {
    description = "The name of the resource group."
    type        = string
    default = "rg-terraform-test-zone"
}

variable "environment_name" {
    description = "The environment name (e.g., dev, prod)."
    type        = string
    default = "dev"
}
variable "subnet_id" {
    description = "The ID of the subnet to deploy the Data Factory."
    type        = string
}

variable "ip_address" {
    description = "The private IP address for the Data Factory private endpoint."
    type        = string
}

////////////////////////////////////////////////////////////////////////////
//other variables that might be useful 

# variable "storage-account-resources" {
#   type = any
#   description = "map of storage account resources"
# }

# variable "key-vaults" {
#   type = map(object({
#     name = string
#     id = string
#   }))
#   description = "Key Vaults to create linked sservices for"
#   default = {}
# }

# variable "data-factory-config" {
#   type = object({
#     name = string
#     azure-managed-runtimes = set(string)
#     self-hosted-runtimes = set(string)
#     linked-storage-accounts = set(string)
#   })
# }
