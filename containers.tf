data "azurerm_key_vault_secret" "registry-password" {
  name         = "registry-password"
  key_vault_id = azurerm_key_vault.rctf-keyvault.id
}

resource "azurerm_container_group" "rctf-container-jeffrey" {
  name                = "rctf-container-jeffrey"
  location            = azurerm_resource_group.rctf.location
  resource_group_name = azurerm_resource_group.rctf.name
  ip_address_type     = "Public"
  dns_name_label      = "rctf-ci-jeffrey"
  os_type             = "Linux"
  restart_policy      = "OnFailure"

  tags = {
    environment = "production"
  }

  container {
    name   = "rctf-container-jeffrey"
    image  = "robynctf.azurecr.io/misc_jeffrey:latest"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 5000
      protocol = "TCP"
    }
  }

  image_registry_credential {
    server   = "robynctf.azurecr.io"
    username = "robynctf"
    password = data.azurerm_key_vault_secret.registry-password.value
  }
}
