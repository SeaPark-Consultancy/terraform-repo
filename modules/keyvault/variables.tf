variable "resource_group_name" {
  default = "rg-terraform-test-zone"
}

variable "keyvault_name" {
  type = string
}

variable "environment" {
  default = "dev"
}

variable "tenant" {
  type    = string
  default = "791dbe2a-50a0-4d28-ae27-8c987f8570dc"
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
