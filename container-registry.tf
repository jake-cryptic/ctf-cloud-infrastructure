resource "azurerm_container_registry" "robynctf" {
  name                = "robynctf"
  resource_group_name = "rctf"
  location            = "UK South"
  sku                 = "Standard"

  admin_enabled = true
}
