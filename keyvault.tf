resource "azurerm_key_vault" "rctf-keyvault" {
  name                       = "rctf-keyvault"
  location                   = azurerm_resource_group.rctf.location
  resource_group_name        = azurerm_resource_group.rctf.name
  tenant_id                  = "bdb74b30-9568-4856-bdbf-06759778fcbc"
  soft_delete_retention_days = 90
  purge_protection_enabled   = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "rctf-keyvault-ap" {
  key_vault_id = azurerm_key_vault.rctf-keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}
