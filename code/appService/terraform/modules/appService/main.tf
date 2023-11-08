// Note this module will only work for Windows App Service Plans. AzureRM has a seperate provider for linux web apps
resource "azurerm_windows_web_app" "app_service" {
  name                = lower("app-${var.app_service_name}")
  location            = var.app_service_location
  resource_group_name = var.resource_group_name
  tags = {
    Language = var.language
  }
  identity {
    type = "SystemAssigned"
  }
  service_plan_id = var.service_plan_id
  https_only      = true
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.app_insights_instrumentation_key
  }

  site_config {
    //Terraform by default has this set to True. Incompatiable with some SKUs
    always_on =  var.service_plan_sku_name == "D1" ? false : true
  }
}

