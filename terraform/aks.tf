resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_aks_name

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = var.aks_node_size
  }

  identity {
    type = "SystemAssigned"
  }
}

