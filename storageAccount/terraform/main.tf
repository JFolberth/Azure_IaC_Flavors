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
variable "environment_name" {
}
variable "resource_group_location" {
}
variable "region_reference" {
  default = {
    centralus = "cus"
    eastus    = "eus"
    westus    = "wus"
    westus2   = "wus2"
  }
}



module "resourceGroupModule" {
  source              = "./modules/resourceGroup"
  resource_group_name = "rg-${var.base_name}-${var.environment_name}-${lookup(var.region_reference, var.resource_group_location, "")}"
  location            = var.resource_group_location
}

module "storageAccountModule" {
  source               = "./modules/storageAccount"
  resource_group_name  = module.resourceGroupModule.resource_group_name
  location             = module.resourceGroupModule.resource_group_location
  storage_account_name = lower("sa${var.base_name}${var.environment_name}${lookup(var.region_reference, var.resource_group_location, "")}")
}
