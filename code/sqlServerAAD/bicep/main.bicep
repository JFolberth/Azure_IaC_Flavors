@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'bicepaad'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'
@description('Storage Account type')
param storageAccountType string = 'Standard_LRS'
@description('Name of the Admin group to assign AAD permissions over the SQL Server')
param sqlAdminGroupName string
@description('SID of the group to assign AAD permissions over the SQL Server')
param sqlAdminGroupObjectId string
@description('How many days to retain Log Analytics Logs')
param retentionDays int
@description('Name of the SQL Database to create')
param sqlDBName string = 'sampleDB'


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


module sqlServer 'modules/sqlServer.module.bicep' ={
  name: 'sqlServerModule'
  scope: resourceGroup
  params:{
    location: location
    serverName: nameSuffix
    storageAccountVulnerabilityEndpoint: storageAccount.outputs.storageAccountVulnerabilityEndpoint
    logAnalyticsWorkspaceID: logAnalytics.outputs.logAnalyticsWorkspaceID
    sqlAdminGroupName:sqlAdminGroupName
    sqlAdminGroupObjectId:sqlAdminGroupObjectId
    storageAccountName: storageAccount.outputs.storageAccountName
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

module sampleDB 'modules/sqlDatabase.module.bicep' ={
  name: 'sqlDatabaseModule'
  scope: resourceGroup
  params:{
    location: location
    sqlDBName: sqlDBName
    serverName: sqlServer.outputs.sqlServerName
    language: language
  }
}
