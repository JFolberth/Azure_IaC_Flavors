terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.3"
    }
  }
}

provider "azurerm" {
  features {}
}
variable "base_name" {
  default     = "flavorsiactf"
  description = "Base name that will appear for all resources."
}
variable "environment_name" {
  description = "Three letter environment abreviation to denote environment that will appear in all resource names"
}
variable "resource_group_location" {
  description = "The azure location the resource group will be deployed to"
}
variable "form_recognizer_sku" {
  description = "Form Recognizer SKU will be Standard or Premium"
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

locals {
  name_suffix = "${var.base_name}-${var.environment_name}-${lookup(var.region_reference, var.resource_group_location, "")}"
}


module "resource_group_module" {
  source                  = "./modules/resourceGroup"
  resource_group_name     = local.name_suffix
  resource_group_location = var.resource_group_location
  language                = var.language
}

module "form_recognizer_module" {
  source = "./modules/formRecognizer"
  resource_group_name = module.resource_group_module.resource_group_name
  form_recognizer_location = module.resource_group_module.resource_group_location
  form_recognizer_name = local.name_suffix
  form_recognizer_sku = var.form_recognizer_sku
  language = var.language
  
}