
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "web-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  size                = var.vm_size
  admin_username      = "adminuser"

  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  os_disk {
    name              = "practica2" 
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19_10-daily-gen2"
    version   = "latest"
  }
}