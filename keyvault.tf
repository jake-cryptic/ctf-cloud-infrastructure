resource "azurerm_key_vault" "rctf-keyvault" {
  name                       = "rctf-keyvault"
  location                   = azurerm_resource_group.rctf.location
  resource_group_name        = azurerm_resource_group.rctf.name
  tenant_id                  = "bdb74b30-9568-4856-bdbf-06759778fcbc"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

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
    "Set",
    "List",
    "Delete",
    "Purge"
  ]
}

resource "azurerm_key_vault_secret" "rctf-keyvault-secrets" {
  depends_on   = [azurerm_key_vault.rctf-keyvault]
  for_each     = local.key_vault_secret
  name         = each.value.name
  key_vault_id = azurerm_key_vault.rctf-keyvault.id
  value        = each.value.value

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
