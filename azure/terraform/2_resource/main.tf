variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "rg-example2-terraform"
  validation {
    error_message = "Invalid resource group name"
    condition     = length(var.resource_group_name) > 0
  }

}

variable "storage_account_prefix" {
  type        = string
  description = "Storage account prefix"
  default     = "sademo"
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
    application = "MyApp2"
  }
}

variable "storage_account_tier" {
  type        = string
  description = "Storage account tier"
  default     = "Standard"
  validation {
    error_message = "Invalid storage account tier"
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
  }
}

variable "storage_account_replication_type" {
  type        = string
  description = "Storage account replication type"
  default     = "LRS"
}

resource "random_id" "id" {
  byte_length = 4
}

resource "azurerm_resource_group" "myNewRg" {
  location = var.deployment_location
  name     = var.resource_group_name
  tags     = var.tags
}

resource "azurerm_storage_account" "myNewSa" {
  name                     = "${var.storage_account_prefix}${random_id.id.hex}"
  resource_group_name      = azurerm_resource_group.myNewRg.name
  location                 = azurerm_resource_group.myNewRg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_storage_container" "imagesContainer" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.myNewSa.name
  container_access_type = "private"
}
