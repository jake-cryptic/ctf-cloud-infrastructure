resource "azurerm_container_group" "rctf-container-directorysnooping" {
  name                = "rctf-container-directorysnooping"
  location            = azurerm_resource_group.rctf.location
  resource_group_name = azurerm_resource_group.rctf.name
  ip_address_type     = "Public"
  dns_name_label      = "rctf-ci-directoryinstance"
  os_type             = "Linux"
  restart_policy      = "Never"

  tags = {
    environment = "Production"
  }

  container {
    name   = "rctf-container-directorysnooping"
    image  = "robynctf.azurecr.io/misc_directorysnooping"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 53
      protocol = "UDP"
    }
    ports {
      port     = 88
      protocol = "TCP"
    }
    ports {
      port     = 135
      protocol = "TCP"
    }
    ports {
      port     = 137
      protocol = "UDP"
    }
    ports {
      port     = 138
      protocol = "UDP"
    }
    ports {
      port     = 139
      protocol = "TCP"
    }
    ports {
      port     = 389
      protocol = "TCP"
    }
    ports {
      port     = 446
      protocol = "TCP"
    }
    ports {
      port     = 464
      protocol = "TCP"
    }
    ports {
      port     = 636
      protocol = "TCP"
    }
    ports {
      port     = 3268
      protocol = "TCP"
    }
    ports {
      port     = 3269
      protocol = "TCP"
    }

    environment_variables = {
      DOMAIN_NAME    = "internal.clam-corp.com"
      ADMIN_PASSWORD = "Pa55w0rd"
    }
  }

  image_registry_credential {
    server   = "robynctf.azurecr.io"
    username = "robynctf"
    password = data.azurerm_key_vault_secret.registry-password.value
  }
}
