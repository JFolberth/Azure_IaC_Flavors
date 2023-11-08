@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'iacflavorsbicepASP'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'
@description('App Service Plan Sku')
param appServicePlanSKU string
@description('How many days to retain Log Analytics Logs')
param retentionDays int


targetScope = 'subscription'

var regionReference = {
  centralus: 'cus'
  eastus: 'eus'
  westus: 'wus'
  westus2: 'wus2'
}
var nameSuffix = toLower('${baseName}-${environmentName}-${regionReference[location]}')
var language = 'Bicep'

/* Since we are mismatching scopes with a deployment at subscription and resource at Resource Group
 the main.bicep requires a resource Group deployed at the subscription scope, all modules will be at the Resource Group scope
 */

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' ={
  name: toLower('rg-${nameSuffix}')
  location: location
  tags:{
    Customer: 'FlavorsIaC'
    Language: language
  }
}

module appServicePlan 'modules/appServicePlan.module.bicep' ={
  name: 'appServicePlanModule'
  scope: resourceGroup
  params:{
    location: location
    appServicePlanName: nameSuffix
    language: language
    appServicePlanSKU: appServicePlanSKU
  }
}

module appService 'modules/appService.module.bicep' ={
  name: 'appServiceModule'
  scope: resourceGroup
  params:{
    location: location
    appServicePlanID: appServicePlan.outputs.appServicePlanID
    appServiceName: nameSuffix
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    language: language
  }
}

module logAnalytics 'modules/logAnalytics.module.bicep' ={
  name: 'logAnalyticsModule'
  scope: resourceGroup
  params:{
    location: location
    logAnalyticsName: nameSuffix
    language: language
    retentionDays: retentionDays
  }
}

module appInsights 'modules/appInsights.module.bicep' ={
  name: 'appInsightsModule'
  scope: resourceGroup
  params:{
    location: location
    appInsightsName: nameSuffix
    logAnalyticsWorkspaceID: logAnalytics.outputs.logAnalyticsWorkspaceID
    language: language
  }
}

