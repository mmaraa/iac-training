variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "rg-example1-terraform"
}

variable "deployment_location" {
  type        = string
  description = "Deployment location"
  default     = "swedencentral"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resource group"
  default = {
    application = "MyApp1"
  }
}

resource "azurerm_resource_group" "myNewRg" {
  location = var.deployment_location
  name     = var.resource_group_name
  tags     = var.tags
}
