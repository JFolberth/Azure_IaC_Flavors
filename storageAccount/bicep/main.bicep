@description('Location for all resources.')
param location string 
param baseName string

param environmentName string = 'dev'


targetScope = 'subscription'
var regionReference = {
  centralus: 'cus'
  eastus: 'eus'
  westus: 'wus'
  westus2: 'wus2'
}
var suffix = '${environmentName}-${regionReference[location]}'
var shortSufix= '${environmentName}${regionReference[location]}'
var resourceGroupName = 'rg-${baseName}-${suffix}'
var storageAccountName = toLower('sa${baseName}${shortSufix}')
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' ={
  name: resourceGroupName
  location: location
  tags:{
    Customer: 'FlavorsIaC'
  }
}

module storageAccount 'modules/storageAccount.module.bicep' ={
  name: 'storageAccountModule'
  scope: resourceGroup
  params:{
    location: location
    storageAccountName: storageAccountName
  }
}
