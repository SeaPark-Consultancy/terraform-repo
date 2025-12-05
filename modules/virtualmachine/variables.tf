
variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the virtual machine's network interface will be deployed."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "environment" {
  description = "The environment in which the virtual machine is deployed (e.g., dev, prod)."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_D4a_v4"
}

variable "vm_adminuser" {
  description = "The admin username for the virtual machine."
  type        = string
}
variable "vm_adminpassword" {
  description = "The admin password for the virtual machine."
  type        = string
  sensitive   = true

}
variable "public_ip_address_id" {
  description = "The ID of the public IP address to associate with the VM's network interface."
  type        = string
  default     = null
}

