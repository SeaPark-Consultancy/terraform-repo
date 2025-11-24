variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}


variable "tag" {
  type    = map(string)
  default = {}
}


variable "dns_zone_names" {
  type        = any
  description = "DNS Zone array"
}

variable "sa_config" {
  type = object({
    name = string
    endpoints = map(object({
      type       = string
      ip_address = string
    }))
    containers       = set(string)
    account_kind     = string
    storage_tier     = string
    replication_type = string
  })

}