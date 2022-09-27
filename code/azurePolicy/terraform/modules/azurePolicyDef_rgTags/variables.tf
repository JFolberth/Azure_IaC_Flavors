variable "environment_name" {
  type        = string
  description = "Three leter environment abreviation to denote environment that will appear in all resource names"
}

variable "name_suffix" {
  type        = string
  description = "Suffix to append to the Definition name, done to keep track of IaC Provider this is written in"
}


