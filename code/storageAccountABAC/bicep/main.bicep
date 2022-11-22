@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'iacbicepsaabac'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'
@description('Storage Account type')
param storageAccountType string = 'Standard_LRS'
@description('Storage Account Container Name')
param storageAccountContainerName string = 'abac'


targetScope = 'subscription'

var regionReference = {
  centralus: 'cus'
  eastus: 'eus'
  westus: 'wus'
  westus2: 'wus2'
}
var nameSuffix = '${baseName}-${environmentName}-${regionReference[location]}'
var resourceGroupName = 'rg-${nameSuffix}'

var language = 'Bicep'
/* Since we are mismatching scopes with a deployment at subscription and resource at resource group
 the main.bicep requires a Resource Group deployed at the subscription scope, all modules will be at the Resourece Group scope
 */
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' ={
  name: resourceGroupName
  location: location
  tags:{
    Customer: 'FlavorsIaC'
    Language: language
  }
}

module storageAccount 'modules/storageAccount.module.bicep' ={
  name: 'storageAccountModule'
  scope: resourceGroup
  params:{
    location: location
    storageAccountName: nameSuffix
    language: language
    storageAccountType: storageAccountType
  }
}


module storageAccountContainer 'modules/storageAccountContainer.module.bicep' ={
  name: 'storageAccountContainerModule'
  scope: resourceGroup
  params:{
    storageAccountName: storageAccount.outputs.storageAccountName
    storageAccountContainerName: storageAccountContainerName
  }
}

module storageAccountContainerABAC 'modules/storageAccountABAC.module.bicep' ={
  name: 'storageAccountABACModule'
  scope: resourceGroup
  params:{
    storageAccountName: storageAccount.outputs.storageAccountName
    storageAccountContainerName: storageAccountContainer.outputs.storageAccountContainerName
  }
}
