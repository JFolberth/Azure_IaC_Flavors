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
  default     = "IacFlavorsTF"
  description = "Base name that will appear for all resources."
}
variable "environment_name" {
  description = "Three leter environment abreviation to denote environment that will appear in all resource names"
}
variable "resource_group_location" {
  description = "The azure location the resource gorup will be deployed to"
}
variable "region_reference" {
  default = {
    centralus = "cus"
    eastus    = "eus"
    westus    = "wus"
    westus2   = "wus2"
  }
  description = "Object/map that will look up a full qualified region and convert it to an abreviation. Done to drive consistency"
}
variable "language" {
  default = "Terraform"
}



module "resourceGroupModule" {
  source                  = "./modules/resourceGroup"
  resource_group_name     = "rg-${var.base_name}-${var.environment_name}-${lookup(var.region_reference, var.resource_group_location, "")}"
  resource_group_location = var.resource_group_location
  language                = var.language
}

module "storageAccountModule" {
  source                   = "./modules/storageAccount"
  resource_group_name      = module.resourceGroupModule.resource_group_name
  storage_account_location = module.resourceGroupModule.resource_group_location
  storage_account_name     = lower("sa${var.base_name}${var.environment_name}${lookup(var.region_reference, var.resource_group_location, "")}")
  language                 = var.language
}
