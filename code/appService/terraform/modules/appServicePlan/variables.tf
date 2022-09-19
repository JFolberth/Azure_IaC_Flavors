variable "resource_group_name" {
  type        = string
  description = "Name of the resource group the storage account will be deployed to"
}

variable "service_plan_location" {
  type        = string
  description = "Location the App Service Plan will be deployed to"
}

variable "service_plan_name" {
  type        = string
  description = "Name used for the App Service Plan"
}

variable "service_plan_os_type" {
  type        = string
  description = "Operating System for the given App Service Plan"
  default     = "Windows"
  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"], var.service_plan_os_type)
    error_message = "Please provide a valid OS"
  }
}

variable "service_plan_sku_name" {
  type        = string
  description = "SKU for the App Service Plan"
  default     = "D1"
  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I2v2", "I3v2", "P1v2", "P2v2", "P3v2", "P1v3", "P2v3", "P3v3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "WS1", "WS2", "WS3"], var.service_plan_sku_name)
    error_message = "Please provide a valid App Serice Plan SKU"
  }
}
variable "language" {
  type        = string
  description = "Language used to build the resource"
}