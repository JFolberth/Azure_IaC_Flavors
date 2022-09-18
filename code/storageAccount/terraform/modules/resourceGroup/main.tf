resource "azurerm_resource_group" "resourceGroup" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    Language = var.language
  }
}
