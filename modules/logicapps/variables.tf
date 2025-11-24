variable "resource_group_name" {
  type    = string
  default = "rg-terraform-test-zone"
}

variable "storarge_account_name" {
  type    = string
  default = "adlsstoragecontainter1dev"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "logic_app_name" {
  type    = string
  default = "dataplatform"
}