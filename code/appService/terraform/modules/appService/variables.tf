variable "resource_group_name" {
  type        = string
  description = "Name of the resource group the App Insights will be deployed to"
}

variable "app_service_location" {
  type        = string
  description = "Location the App Insights will be deployed to"
}

variable "app_service_name" {
  type        = string
  description = "Name for the instnace of App Service"
}
variable "language" {
  type        = string
  description = "Language used to build the resource"
}
variable "app_insights_instrumentation_key" {
  type        = string
  description = "Implementation key for App Insights"
}
variable "service_plan_id" {
  type        = string
  description = "App Service Plan ID the App Service will live under"
}