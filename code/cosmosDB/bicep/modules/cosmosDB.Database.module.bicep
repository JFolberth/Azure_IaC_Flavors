@description('The name for the database')
param databaseName string = 'myDatabase'
@description('The name for the account to create the database in')
param parentAccountName string

resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2023-03-01-preview' existing = {
  name: parentAccountName
}
resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-03-01-preview' = {
  name: databaseName
  parent: cosmosAccount
  properties: {
    resource: {
      id: databaseName
    }
  }
}

output cosmosDatabaseName string = database.name
