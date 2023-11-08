terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.2"
    }
  }
}

provider "azurerm" {
  features {}
}
variable "base_name" {
  default     = "iacflavorstfasp"
  description = "Base name that will appear for all resources."
}
variable "environment_name" {
  description = "Three leter environment abreviation to denote environment that will appear in all resource names"
}
variable "resource_group_location" {
  description = "The Azure location the Resource Group will be deployed to"
}
variable "service_plan_sku_name" {
  description = "SKU for the App Service Plan"
}
variable "log_analytics_retention_days" {
  description = "Number of days to retain logs"
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

module "service_plan_module" {
  source                = "./modules/appServicePlan"
  resource_group_name   = module.resource_group_module.resource_group_name
  service_plan_location = module.resource_group_module.resource_group_location
  service_plan_name     = local.name_suffix
  language              = var.language
  service_plan_sku_name = var.service_plan_sku_name
}

module "log_analytics_module" {
  source                 = "./modules/logAnalytics"
  resource_group_name    = module.resource_group_module.resource_group_name
  log_analytics_location = module.resource_group_module.resource_group_location
  log_analytics_name     = local.name_suffix
  language               = var.language
  log_analytics_retention_days = var.log_analytics_retention_days
}

module "app_insights_module" {
  source                     = "./modules/appInsights"
  resource_group_name        = module.resource_group_module.resource_group_name
  app_insights_location      = module.resource_group_module.resource_group_location
  app_insights_name          = local.name_suffix
  language                   = var.language
  log_analytics_workspace_id = module.log_analytics_module.log_analytics_workspace_id
}

module "app_service_module" {
  source                           = "./modules/appService"
  resource_group_name              = module.resource_group_module.resource_group_name
  app_service_location             = module.resource_group_module.resource_group_location
  app_service_name                 = local.name_suffix
  language                         = var.language
  app_insights_instrumentation_key = module.app_insights_module.instrumentation_key
  service_plan_id                  = module.service_plan_module.service_plan_id
  service_plan_sku_name = var.service_plan_sku_name

}
