data "azurerm_key_vault_secret" "registry-password" {
  name         = "registry-password"
  key_vault_id = azurerm_key_vault.rctf-main-keyvault.id
}

data "azurerm_key_vault_secret" "openai-api-key" {
  name         = "openai-api-key"
  key_vault_id = azurerm_key_vault.rctf-main-keyvault.id
}


