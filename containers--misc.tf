resource "azurerm_container_group" "rctf-containers-challenge-misc" {
  name                = "rctf-containers-challenge-misc"
  location            = azurerm_resource_group.rctf.location
  resource_group_name = azurerm_resource_group.rctf.name
  ip_address_type     = "Public"
  dns_name_label      = "rctf-cg-misc"
  os_type             = "Linux"
  restart_policy      = "Never"

  tags = {
    environment = "Production"
  }

  image_registry_credential {
    server   = "robynctf.azurecr.io"
    username = "robynctf"
    password = data.azurerm_key_vault_secret.registry-password.value
  }

  # Misc-Jeffrey Challenge container
  container {
    name   = "rctf-container-jeffrey"
    image  = "robynctf.azurecr.io/misc_jeffrey:latest"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 5000
      protocol = "TCP"
    }

    environment_variables = {
      OPENAI_API_KEY = data.azurerm_key_vault_secret.openai-api-key.value
    }
  }

  # Misc-Directory Snooping
  container {
    name   = "rctf-container-directorysnooping"
    image  = "robynctf.azurecr.io/misc_directorysnooping"
    cpu    = "1"
    memory = "1"

    # DNS
    #ports {
    #  port     = 53
    #  protocol = "UDP"
    #}
    # Kerberos
    ports {
      port     = 88
      protocol = "TCP"
    }
    # RPC
    #ports {
    #  port     = 135
    #  protocol = "TCP"
    #}
    # Netbios
    #ports {
    #  port     = 137
    #  protocol = "UDP"
    #}
    # Netbios
    #ports {
    #  port     = 138
    #  protocol = "UDP"
    #}
    # Netbios
    #ports {
    #  port     = 139
    #  protocol = "TCP"
    #}
    # LDAP
    ports {
      port     = 389
      protocol = "TCP"
    }
    # ddm-rdb
    ports {
      port     = 446
      protocol = "TCP"
    }
    # Kerberos v5
    ports {
      port     = 464
      protocol = "TCP"
    }
    # LDAPS
    ports {
      port     = 636
      protocol = "TCP"
    }
    # LDAP GC (Global catalog)
    ports {
      port     = 3268
      protocol = "TCP"
    }
    # LDAPS GC (Global catalog)
    ports {
      port     = 3269
      protocol = "TCP"
    }

    environment_variables = {
      DOMAIN_NAME    = "internal.clam-corp.com"
      ADMIN_PASSWORD = "Pa55w0rd"
    }
  }
}
