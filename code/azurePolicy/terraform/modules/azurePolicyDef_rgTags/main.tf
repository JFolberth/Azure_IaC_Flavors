 
 resource "azurerm_policy_definition" "azure_policy_definition" {
   name         = "required resource group tags - ${var.environment_name}"
   policy_type  = "Custom"
   mode         = "Indexed"
   display_name = "${var.environment_name} - Policy Definition for required tags on Azure Resource Group Names"
   metadata = <<METADATA
     {
       "version": "1.0.0",
       "category": "Tags"
     }
     METADATA

  policy_rule = <<POLICY_RULE
  {
 "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Resources/subscriptions/resourceGroups"
          },
          {
            "field": "[concat('tags[', parameters('tagName'), ']')]",
            "exists": "false"
          }
        ]
      },
      "then": {
        "effect": "[parameters('tagPolicyEffect')]"
      }
    }
  
POLICY_RULE


  parameters = <<PARAMETERS
    {
        "tagName": {
        "type": "String",
        "metadata": {
          "displayName": "Tag Required",
          "description": "Name of the tag, such as 'owner'"
        }
      },
              "tagPolicyEffect": {
 "type": "String",
                 "metadata": {
                 "displayName": "Effect",
                 "description": "Enable or disable the execution of the policy"
                 },
                 "allowedValues": [
                 "AuditIfNotExists",
                 "Disabled",
                 "Deny"
                 ],
                 "defaultValue": "AuditIfNotExists"
      }
  }
PARAMETERS
 }