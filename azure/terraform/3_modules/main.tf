variable "resource_group_name" {
  type        = string
  description = "Resource group name"
  default     = "rg-example3-terraform"

}

variable "deplyment_location" {
  type        = string
  description = "Deployment location"
  default     = "westeurope"

}

variable "tags" {
  type        = map(string)
  description = "Tags for the resource group"
  default = {
    application = "MyApp3"
  }
}

variable "kv_name" {
  type        = string
  description = "Key vault name"
  default     = "kv-myapp"

}

data "azurerm_client_config" "current" {
}

module "resourceGroup" {
  source              = "../1_rgDeployment"
  resource_group_name = var.resource_group_name
  deployment_location = var.deplyment_location
  tags                = var.tags

}

resource "random_id" "id" {
  byte_length = 8
}

resource "azurerm_key_vault" "myapp3-keyvault" {
  name                     = "kv-myapp${random_id.id.hex}"
  location                 = module.resourceGroup.rglocation
  resource_group_name      = module.resourceGroup.rgName
  sku_name                 = "standard"
  tenant_id                = data.azurerm_client_config.current.tenant_id
  tags                     = var.tags
  purge_protection_enabled = true
}
