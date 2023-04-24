resource "azurerm_network_interface" "rctf-main-nic" {
  name                = "rctf-main-nic"
  location            = azurerm_resource_group.rctf.location
  resource_group_name = azurerm_resource_group.rctf.name

  ip_configuration {
    name                          = "rctf-main-ip-config"
    subnet_id                     = azurerm_subnet.rctf-main-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.rctf_main_public_ip.id
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface_security_group_association" "rctf-main-nic-nsg-association" {
  network_interface_id      = azurerm_network_interface.rctf-main-nic.id
  network_security_group_id = azurerm_network_security_group.rctf-main-nsg.id
}


resource "azurerm_linux_virtual_machine" "rctf-main-vm" {
  name                = "rctf-main-vm-platform"
  resource_group_name = azurerm_resource_group.rctf.name
  location            = azurerm_resource_group.rctf.location
  size                = "Standard_E2as_v4" # change E2as_v4 -> E4as_v4 -> E8_v5 depending on load
  admin_username      = "robyn"
  network_interface_ids = [
    azurerm_network_interface.rctf-main-nic.id,
  ]

  admin_ssh_key {
    username   = "robyn"
    public_key = file("./.id_rsa.pub")
  }

  os_disk {
    name                 = "rctf-main-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy-daily"
    sku       = "22_04-daily-lts-gen2"
    version   = "22.04.202304200"
  }
}
