@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'iacflavorsASP'
@description('Three leter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'


targetScope = 'subscription'

var regionReference = {
  centralus: 'cus'
  eastus: 'eus'
  westus: 'wus'
  westus2: 'wus2'
}
var suffix = toLower('${baseName}-${environmentName}-${regionReference[location]}')
var resourceGroupName = 'rg-${suffix}'
var appServicePlanName = 'asp-${suffix}'
var appServiceName = 'app-${suffix}'
var appInsightsName = 'ai-${suffix}'
var logAnalyticsName = 'la-${suffix}'
var language = 'Bicep'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' ={
  name: resourceGroupName
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
    appServicePlanName: appServicePlanName
    language: language
  }
}

module appService 'modules/appService.module.bicep' ={
  name: 'appServiceModule'
  scope: resourceGroup
  params:{
    location: location
    appServicePlanID: appServicePlan.outputs.appServicePlanID
    appServiceName: appServiceName
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    language: language
  }
}

module logAnalytics 'modules/logAnalytics.module.bicep' ={
  name: 'logAnalyticsModule'
  scope: resourceGroup
  params:{
    location: location
    logAnalyticsName: logAnalyticsName
    language: language
  }
}

module appInsights 'modules/appInsights.module.bicep' ={
  name: 'appInsightsModule'
  scope: resourceGroup
  params:{
    location: location
    appInsightsName: appInsightsName
    logAnalyticsWorkspaceID: logAnalytics.outputs.logAnalyticsWorkspaceID
    language: language
  }
}

