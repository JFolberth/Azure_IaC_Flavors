resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_name
  location            = var.log_analytics_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_retention_days
  tags = {
    Language = var.language
  }
}

