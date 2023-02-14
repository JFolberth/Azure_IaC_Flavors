
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group the form recognizer will be deployed to"
}

variable "form_recognizer_location" {
  type        = string
  description = "Location the form recognizer will be deployed to"
}

variable "form_recognizer_name" {
  type        = string
  description = "Name used for the form recognizer"
}

variable "form_recognizer_sku" {
  type    = string
  validation {
    condition     = contains(["S0", "F0"], var.form_recognizer_sku)
    error_message = "Please provide a valid SKU for the Form Recognizer"
  }
}

variable "language" {
  type        = string
  description = "Language used to build the resource"
}