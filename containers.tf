data "azurerm_key_vault_secret" "registry-password" {
  name         = "registry-password"
  key_vault_id = azurerm_key_vault.rctf-keyvault.id
}


