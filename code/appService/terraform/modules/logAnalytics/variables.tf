variable "resource_group_name" {
  type        = string
  description = "Name of the resource group the Log Analytics Workspace will be deployed to"
}

variable "log_analytics_location" {
  type        = string
  description = "Location the Log Analytics Workspace will be deployed to"
}

variable "log_analytics_name" {
  type        = string
  description = "Name for the instance of Log Analytics Workspace"
}
variable "language" {
  type        = string
  description = "Language used to build the resource"
}

variable "log_analytics_retention_days" {
  type        = number
  description = "Number of days to retain logs"
  default     = 30
}