terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {
    #key_vault {
    #  purge_soft_delete_on_destroy    = true
    #  recover_soft_deleted_key_vaults = true
    #}
  }
}

data "azurerm_client_config" "current" {}

# Define the resource group and location
resource "azurerm_resource_group" "rctf" {
  name     = "rctf"
  location = "UK South"
}

