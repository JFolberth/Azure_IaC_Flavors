# Azure Resource Manager (ARM) Templates <img align="right" width="75" height="75" src="images/ARM/arm_logo.png" alt="Azure Resource Manager Logo">

# About
Every resource within Azure, no matter how it is deployed, will have a resource definition written as an ARM template in JSON. There are also certain resources that no matter what language they utilized will require the definition be written in a JSON/ARM template. Such resources as Azure Policy, Azure Data Factory, and Azure Logic Apps just to name a few.

# Some Pointers
- It is JSON file, not a programming language
- Explicitly call out any dependency between templates or resources
- Any Export Resource button in Azure will product an ARM template
- Day 0 support for any Azure resources, even those in private preview
- Azure specific
- Easily declare individual Azure Resource provider API versions
- No state file

# How It Works
The JSON file will be submitted directly to the Azure Resource Manager for provisioning the necessary Azure resources.

![Diagram illustrating Azure Consistent Management Layer](images/ARM/consistent-management-layer.png)

Source From: [Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/overview)

# PreReqs
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

# Validating Changes
The best way to validate changes would be to leverage the Azure CLI `what-if` command similar to:
` az deployment sub what-if --location EastUS --name azureADOCLIDeployment --template-file main.json --parameters parameters/dev.eus.parameters.json`

For more information check out the [ARM Template deployment what-if operation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-what-if?tabs=azure-powershell)

# Deploying
Deployment for these examples are done at the Subscription level. This is done to ensure full deployment by creating the required Resource Group.

`az deployment sub create --name storageDeployment --location eastus --template-file main.json --parameters parameters/dev.eus.parameters.json`

# Links
- [Microsoft Azure Quickstarts](https://azure.microsoft.com/en-us/resources/templates/)
- [Microsoft Learning Path](https://docs.microsoft.com/en-us/learn/paths/deploy-manage-resource-manager-templates/)
- [ARM Resource Schemas](https://docs.microsoft.com/en-us/azure/templates/#arm-templates)
- [Bicep to ARM Playground](https://bicepdemo.z22.web.core.windows.net/)
- [ARM Template Schema](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/syntax)
- [How to Export an ARM Template](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/export-template-portal)
