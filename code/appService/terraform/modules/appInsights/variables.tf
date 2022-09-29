variable "resource_group_name" {
  type        = string
  description = "Name of the resource group the App Insights will be deployed to"
}

variable "app_insights_location" {
  type        = string
  description = "Location the App Insights will be deployed to"
}

variable "app_insights_name" {
  type        = string
  description = "Name for the instance of App Insights"
}
variable "language" {
  type        = string
  description = "Language used to build the resource"
}
variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace Id to send App Insights data to"
}