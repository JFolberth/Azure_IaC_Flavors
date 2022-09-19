resource "azurerm_service_plan" "app_service_plan" {
  name                = lower("asp-${var.service_plan_name}")
  location            = var.service_plan_location
  resource_group_name = var.resource_group_name
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name
  tags = {
    Language = var.language
  }
}