variable "resource_group_name" { type = string }

variable "environment" {
  type    = string
  default = "dev"
}

variable "tag" {
  type    = map(string)
  default = {}
}

variable "nsg_config" {
  type = map(object({
    associate_with = string
  }))
  description = "Map of NSG configurations with subnet associations"
  default     = {}
}

variable "subnet_config" {
  type = map(object({
    subnet_cidr       = string
    service_endpoints = set(string)

    delegation = optional(object({
      name            = string
      delegation_name = string
      actions         = set(string)
    }))
  }))
  default     = {}
  description = "Map of subnet configurations"
}

variable "dns_zones" {
  type        = map(string)
  default     = {}
  description = "Map of Private DNS Zones to create"

}

variable "existing_vnet" {
  type = object({
    name                = string
    resource-group-name = string
  })
  default     = null
  description = "Provide a VNET ID of an existing VNET. There will be no VNET creation if this is provided"
}



variable "vnet_address_space" {
  type        = string
  description = "The address space for the virtual network."
}
