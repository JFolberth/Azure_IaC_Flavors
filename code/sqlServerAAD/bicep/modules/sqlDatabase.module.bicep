@description('The name of the SQL logical server.')
param serverName string

@description('The name of the SQL Database.')
param sqlDBName string = 'SampleDB'

@description('Location for all resources.')
param location string = resourceGroup().location
@description('What language was used to deploy this resource')
param language string

resource sqlServer 'Microsoft.Sql/servers@2022-08-01-preview' existing = {
  name: serverName
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  tags: {
    Language: language
  }
  
}
