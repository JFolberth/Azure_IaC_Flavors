variable "resource_group_name" {
  type        = string
  description = "Name of the resource group the budget will be applied within"
}
variable "resource_id" {
  type        = string
  description = "The resource ID the budget will be applied to"
  default     = null
}
variable "budget_amount" {
  type        = number
  description = "The base amount used for budget, default is 100"
  default     = 100
}
variable "time_grain" {
  type        = string
  description = "The time covered by a budget. Tracking of the amount will be reset based on the time grain. BillingMonth, BillingQuarter, and BillingAnnual are only supported by WD customers"
  default     = "Monthly"
  validation {
    condition     = contains(["Annually", "BillingAnnual", "BillingMonth", "BillingQuarter", "Monthly", "Quarterly"], var.time_grain)
    error_message = "Please provide a valid time grain for the budget to be applied at"
  }
}
variable "first_threshold" {
  type        = number
  description = "The first threshold when passed that will trigger an alert."
  default     = 80
}
variable "second_threshold" {
  type        = number
  description = "The second threshold when passed that will trigger an alert."
  default     = 110
}
variable "contact_emails" {
  type        = list(any)
  description = "List of email address to alert when the budget has been surpassed"
  default     = []
}
variable "contact_roles" {
  type        = list(any)
  description = "List of RBAC roles that should be notifed"
  default = [
    "Owner"
  ]
}
variable "operator" {
  type        = string
  description = "The comparison operator."
  default     = "GreaterThan"
}



