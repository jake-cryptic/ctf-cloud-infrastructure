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

resource "azurerm_linux_virtual_machine" "rctf-main-vm" {
  name                = "rctf-main-vm-platform"
  resource_group_name = azurerm_resource_group.rctf.name
  location            = azurerm_resource_group.rctf.location
  size                = "Standard_E2as_v4"
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

resource "null_resource" "install_docker" {
  depends_on = [
    azurerm_linux_virtual_machine.rctf-main-vm
  ]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker $USER"
    ]
    connection {
      type        = "ssh"
      host        = azurerm_linux_virtual_machine.rctf-main-vm.public_ip_address
      user        = "robyn"
      private_key = file("./.id_rsa.pub")
    }
  }
}
