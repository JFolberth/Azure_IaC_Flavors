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

variable "environment_name" {
  description = "Three leter environment abreviation to denote environment that will appear in all resource names"
}

variable "language" {
  default = "Terraform"
}

variable "required_tags" {
  description = "List of requried tags for the given scope"
  type = map(object({
    tagName         = string
    tagPolicyEffect = string
  }))
  default = {
    department = {
      tagName         = "department"
      tagPolicyEffect = "Disabled"
    },
    delete-by = {
      tagName         = "delete-by"
      tagPolicyEffect = "Deny"
    }
  }
}

locals {
  name_suffix = "tf"
}

data "azurerm_subscription" "current" {
}

module "resource_group_required_tag_definition_module" {
  source           = "./modules/azurePolicyDef_rgTags"
  environment_name = var.environment_name
  name_suffix      = local.name_suffix
}


resource "azurerm_subscription_policy_assignment" "assign_rg_required_tags_module" {
  for_each             = var.required_tags
  name                 = "Assign Required Tags ${each.value.tagName} - ${local.name_suffix}"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = module.resource_group_required_tag_definition_module.azure_policy_id_reource_group_required_tags
  description          = "Policy Assignment created for Required Tag ${each.value.tagName} set by ${local.name_suffix}"
  display_name         = "Required Tag ${each.value.tagName}"


  parameters = <<PARAMETERS
    {
      "tagName": {"value": "${each.value.tagName}" },
      "tagPolicyEffect": {"value": "${each.value.tagPolicyEffect}" }
    }
PARAMETERS
}