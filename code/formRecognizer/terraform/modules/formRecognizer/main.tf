resource "azurerm_cognitive_account" "form_recognizer" {
  name                     = lower("fr-${var.form_recognizer_name}")
  resource_group_name      = var.resource_group_name
  location                 = var.form_recognizer_location
  kind             = "FormRecognizer"
  custom_subdomain_name = var.form_recognizer_name
  sku_name  = var.form_recognizer_sku
  tags = {
    Language = var.language
  }
  identity {
    type = "SystemAssigned"
  }
}
