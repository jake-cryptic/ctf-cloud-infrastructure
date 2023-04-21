# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Define the resource group and location
resource "azurerm_resource_group" "rctf" {
  name     = "robyn-ctf"
  location = "UK South"
}
