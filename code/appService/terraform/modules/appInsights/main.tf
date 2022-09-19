resource "azurerm_application_insights" "app_insights" {
  name                = lower("ai-${var.app_insights_name}")
  location            = var.app_insights_location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  tags = {
    Language = var.language
  }
  workspace_id = var.log_analytics_workspace_id
}