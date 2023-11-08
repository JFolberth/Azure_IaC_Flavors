
locals {
  start_date = formatdate("YYYY-MM-01'T'hh:mm:ssZ", timestamp()) //Can't have variable value be default to a function
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}
resource "azurerm_consumption_budget_resource_group" "rg_budget" {
  name       = "${coalesce(var.resource_id, data.azurerm_resource_group.resource_group.name)}-ConsumptionBudget"
  amount     = var.budget_amount
  time_grain = var.time_grain
  time_period {
    start_date = local.start_date
  }
  resource_group_id = data.azurerm_resource_group.resource_group.id
  notification {
    threshold      = var.first_threshold
    operator       = var.operator
    contact_emails = var.contact_emails
    contact_roles  = var.contact_roles
  }
  notification {
    threshold      = var.second_threshold
    operator       = var.operator
    contact_emails = var.contact_emails
    contact_roles  = var.contact_roles
  }
  lifecycle {
    ignore_changes = [
      time_period
    ]
  }
}