environment_name = "dev"
required_tags = {
  department = {
    tagName         = "department"
    tagPolicyEffect = "Disabled"
  },
  delete-by = {
    tagName         = "delete-by"
    tagPolicyEffect = "Deny"
  },
  owner = {
    tagName         = "owner"
    tagPolicyEffect = "Deny"
  }
}


