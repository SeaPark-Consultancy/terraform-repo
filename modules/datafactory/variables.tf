variable "tag" {
  type    = map(string)
  default = {}

}

variable "datafactory_name" {
  description = "The name of the Data Factory."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet to deploy the Data Factory."
  type        = string
}

variable "ip_address" {
  description = "The private IP address for the Data Factory private endpoint."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Tenant ID."
  type        = string
}

variable "account_name" {
  description = "The name of the Azure DevOps account."
  type        = string
}
variable "project_name" {
  description = "The name of the Azure DevOps project."
  type        = string
}
variable "repository_name" {
  description = "The name of the Azure DevOps repository."
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

