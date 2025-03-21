# Crear la red virtual (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.1.0/24"]
}

# Crear la subred
resource "azurerm_subnet" "subnet" {
  name                 = var.virtual_subnetwork_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"] 
}

# Crear la IP pública
resource "azurerm_public_ip" "vm_ip" {
  name                = var.public_ip_name
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# Crear el Network Security Group (NSG)
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vm-nsg"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name

  # Regla para permitir SSH (puerto 22)
  security_rule {
    name                       = "AllowSSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regla para permitir HTTP (puerto 80)
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Regla para permitir HTTPS (puerto 443)
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Asignar el NSG a la subred
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}
