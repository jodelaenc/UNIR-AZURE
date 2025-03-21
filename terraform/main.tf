terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id  = "43e4c1af-0896-4fbf-8105-b5395782915d"
}
