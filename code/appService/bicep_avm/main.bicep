@description('Base name that will appear for all resources.') 
param baseName string = 'iacflavorsbicepAVM'
@description('Location for all resources.')
param location string

@description('App Insights Type')
param appInsightsType string = 'web'
@description('Desired App Service Kind')
param appServicePlanKind string = 'Windows'
@description('App Service Plan Sku')
param appServicePlanSKU object
@description('Desired App Kind')
param appServiceKind string = 'app'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'
@description('Use Resource Permissions for Log Analytics')
param LogAnalyticsUseResourcePermissions bool = true
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

 resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' ={
  location: location
  name: toLower('rg-${nameSuffix}')
  tags:{
    Customer: 'FlavorsIaC'
    Language: language
  }
}

module appServicePlan 'br/public:avm/res/web/serverfarm:0.1.1' ={
  name: 'appServicePlanModule'
  scope: resourceGroup
  params:{
    name: 'asp-${nameSuffix}'
    kind: appServicePlanKind
    sku: appServicePlanSKU
    tags:{
      Customer: 'FlavorsIaC'
      Language: language
    }
  }
}

module logAnalytics 'br/public:avm/res/operational-insights/workspace:0.3.4' ={
  name: 'logAnalyticsModule'
  scope: resourceGroup
  params:{
    name: 'la-${nameSuffix}'
    tags: {
      displayName: 'Log Analytics'
      Language: language
    }
    useResourcePermissions: LogAnalyticsUseResourcePermissions
    dataRetention: retentionDays
  }
}
module appInsights 'br/public:avm/res/insights/component:0.3.0' ={
  name: 'appInsightsModule'
  scope: resourceGroup
  params:{
    applicationType: appInsightsType
    name: 'ai-${nameSuffix}'
    tags: {
      displayName: 'AppInsight'
      Language: language
    }
    workspaceResourceId: logAnalytics.outputs.resourceId
  }
}

module appService 'br/public:avm/res/web/site:0.3.2' ={
  name: 'appServiceModule'
  scope: resourceGroup
  params:{
    
    name: 'app-${nameSuffix}'
    appInsightResourceId: appInsights.outputs.resourceId
    kind: appServiceKind
    managedIdentities: {
      systemAssigned: true
    }
    serverFarmResourceId: appServicePlan.outputs.resourceId
    siteConfig: {
      minTlsVersion: '1.2'
    }
    tags:{
      displayName: 'Website'
      Language: language
    }
  }
}






