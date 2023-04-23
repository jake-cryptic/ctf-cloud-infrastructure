resource "azurerm_key_vault" "rctf-keyvault" {
  name                = "rctf-keyvault"
  location            = azurerm_resource_group.rctf.location
  resource_group_name = azurerm_resource_group.rctf.name
  tenant_id           = "bdb74b30-9568-4856-bdbf-06759778fcbc"
  sku_name            = "standard"
}
