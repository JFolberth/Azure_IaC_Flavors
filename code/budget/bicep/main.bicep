@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'iacflavorstfbudg'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'

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
module resourceGroupBudget 'modules/budget.module.bicep'= {
  scope: resourceGroup
  name: '${resourceGroup.name}-budget'
params:{
  resourceId: resourceGroup.id
  filterName: 'ResourceGroup'

}
}
