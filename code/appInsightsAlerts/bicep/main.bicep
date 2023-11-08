
@description('Enter response time threshold in seconds.')
@minValue(1)
@maxValue(10000)
param responseTimeThreshold int = 3
@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'iacflavorsbicepalert'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'
@description('How many days to retain Log Analytics Logs')
param retentionDays int
@description('Email addresses to receive alerts')
param emailReceivers array =[]
@description('App Service Plan Sku')
param appServicePlanSKU string


targetScope = 'subscription'

var regionReference = {
  centralus: 'cus'
  eastus: 'eus'
  westus: 'wus'
  westus2: 'wus2'
}
var nameSuffix = toLower('${baseName}-${environmentName}-${regionReference[location]}')
var language = 'Bicep'


resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' ={
  name: toLower('rg-${nameSuffix}')
  location: location
  tags:{
    Customer: 'FlavorsIaC'
    Language: language
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
    logAnalyticsWorkspaceId: logAnalytics.outputs.logAnalyticsWorkspaceId
    language: language
    smartDetectionEmails: ['johnfolberth@microsoft.com']
  }
}

module actionGroup 'modules/actionGroup.module.bicep' ={
  name: 'actionGroupModule'
  scope: resourceGroup
  params: {
    emailReceivers: emailReceivers
  }
} 

module metricAlert 'modules/metricAlert.module.bicep' ={
  name: 'metricAlertModule'
  scope: resourceGroup
  params: {
    responseTimeThreshold: responseTimeThreshold
    appInsightsResourceId: appInsights.outputs.appInsightsResourceId
    actionGroupId: actionGroup.outputs.actionGroupId
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
    appServicePlanId: appServicePlan.outputs.appServicePlanId
    appServiceName: nameSuffix
    appInsightsInstrumentationKey: appInsights.outputs.appInsightsInstrumentationKey
    language: language
  }
}

module appRequestsAlert 'modules/logAnalytics.alert.module.bicep' ={
  name: 'appRequestsAlertModule'
  scope: resourceGroup
  params: {
    logAnalyticsWorkspaceId: logAnalytics.outputs.logAnalyticsWorkspaceId
    actionGroupId: actionGroup.outputs.actionGroupId
    location: location
  }

}
