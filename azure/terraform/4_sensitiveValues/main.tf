variable "sensitive_password" {
  type        = string
  description = "A sensitive password to store in key vault"
  sensitive   = true
}

module "base-infra" {
  source              = "../3_modules"
  resource_group_name = "rg-example4-terraform"
  tags = {
    application = "MyApp4"
  }
}

resource "azurerm_key_vault_secret" "my_secret" {
  name         = "secretPassword"
  value        = var.sensitive_password
  key_vault_id = module.base-infra.kvid
}
