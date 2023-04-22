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
  features {}
}

# Define the resource group and location
resource "azurerm_resource_group" "rctf" {
  name     = "rctf"
  location = "UK South"
}

