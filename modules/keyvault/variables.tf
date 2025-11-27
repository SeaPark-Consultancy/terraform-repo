variable "resource_group_name" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "tenant" {
  type    = string
}

variable "sku_name" {
  type    = string
  default = "standard"
}

# variable "access_policies" {
#   description = "Map of access policies to apply to the Key Vault"
#   type = map(object({
#     tenant_id               = string
#     object_id               = string
#     secret_permissions      = list(string)
#     key_permissions         = list(string)
#     certificate_permissions = list(string)
#   }))
#   default = {}
# }

variable "enable_private_endpoint" {
  default = false
  type    = bool
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "ip_address" {
  type    = string
  default = null
}