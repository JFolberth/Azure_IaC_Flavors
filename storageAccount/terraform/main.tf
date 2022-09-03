terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}
variable "base_name" {
  default = "IacFlavorsTF"
}
variable "environment_Name" {
}
variable "resource_group_location" {
}



module "resourceGroupModule" {
  source = "./modules/resourceGroup"
  resource_group_name  = "rg-${var.base_name}-${var.environment_Name}"
  location = var.resource_group_location
}

module "storageAccountModule" {
  source = "./modules/storageAccount"
  resource_group_name  = module.resourceGroupModule.resource_group_name
  location = module.resourceGroupModule.resource_group_location
  storage_account_name = lower("sa${var.base_name}${var.environment_Name}")
}
