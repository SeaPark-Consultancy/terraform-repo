variable "tag" {
  type    = map(string)
  default = {}

}


variable "database_name" {
  description = "The name of the database."
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
  default     = "rg-terraform-test-zone"
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
  default     = "dev"
}
variable "subnet_id" {
  description = "The ID of the subnet to deploy the Data Factory."
  type        = string
}

variable "ip_address" {
  description = "The private IP address for the Data Factory private endpoint."
  type        = string
}

variable "sku_type" {
  description = "The SKU type for the SQL Database."
  type        = string
  default     = "Basic"
}