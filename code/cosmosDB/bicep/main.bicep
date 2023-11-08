@description('Location for all resources.')
param location string
@description('Base name that will appear for all resources.') 
param baseName string = 'bicepcosmos'
@description('Three letter environment abreviation to denote environment that will appear in all resource names') 
param environmentName string = 'dev'

@description('The secondary region for the Azure Cosmos DB account.')
param secondaryRegion string

@allowed([
  'Eventual'
  'ConsistentPrefix'
  'Session'
  'BoundedStaleness'
  'Strong'
])
@description('The default consistency level of the Cosmos DB account.')
param defaultConsistencyLevel string = 'Session'

@minValue(10)
@maxValue(2147483647)
@description('Max stale requests. Required for BoundedStaleness. Valid ranges, Single Region: 10 to 2147483647. Multi Region: 100000 to 2147483647.')
param maxStalenessPrefix int = 100000

@minValue(5)
@maxValue(86400)
@description('Max lag time (minutes). Required for BoundedStaleness. Valid ranges, Single Region: 5 to 84600. Multi Region: 300 to 86400.')
param maxIntervalInSeconds int = 300

@allowed([
  true
  false
])
@description('Enable system managed failover for regions')
param systemManagedFailover bool = true

@description('The name for the database')
param databaseName string = 'myDatabase'

@description('The name for the container')
param containerName string = 'myContainer'

@minValue(400)
@maxValue(1000000)
@description('The throughput for the container')
param throughput int = 400


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

module comsosAccountResource 'modules/cosmosDB.Account.module.bicep' = {
  name: 'cosmosAccount'
  scope: resourceGroup
  params: {
    location: location
    accountName: nameSuffix
    secondaryRegion: secondaryRegion
    defaultConsistencyLevel: defaultConsistencyLevel
    maxStalenessPrefix: maxStalenessPrefix
    maxIntervalInSeconds: maxIntervalInSeconds
    systemManagedFailover: systemManagedFailover
  }
}

module cosmosDatabaseResource 'modules/cosmosDB.Database.module.bicep' = {
  name: 'cosmosDatabase'
  scope: resourceGroup
  params: {
    parentAccountName: comsosAccountResource.outputs.cosomosAccountName
    databaseName: databaseName
  }
}

module cosmosContainerResource 'modules/cosmosDB.Container.module.bicep' = {
  name: 'cosmosContainer'
  scope: resourceGroup
  params: {
    parentDatabaseName: '${comsosAccountResource.outputs.cosomosAccountName}/${cosmosDatabaseResource.outputs.cosmosDatabaseName}'
    containerName: containerName
    throughput: throughput
  }
}

