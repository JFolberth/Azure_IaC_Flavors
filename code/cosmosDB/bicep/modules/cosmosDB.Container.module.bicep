
@description('The name for the container')
param containerName string = 'myContainer'
@minValue(400)
@maxValue(1000000)
@description('The throughput for the container')
param throughput int = 400
@description('The name for the database to create the container in')
param parentDatabaseName string

resource parentDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-03-01-preview' existing  = {
  name: parentDatabaseName
}
resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-03-01-preview' = {
  name: containerName
  parent: parentDatabase
  properties: {
    resource: {
      id: containerName
      partitionKey: {
        paths: [
          '/myPartitionKey'
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/myPathToNotIndex/*'
          }
          {
            path: '/_etag/?'
          }
        ]
        compositeIndexes: [
          [
            {
              path: '/name'
              order: 'ascending'
            }
            {
              path: '/age'
              order: 'descending'
            }
          ]
        ]
        spatialIndexes: [
          {
            path: '/location/*'
            types: [
              'Point'
              'Polygon'
              'MultiPolygon'
              'LineString'
            ]
          }
        ]
      }
      defaultTtl: 86400
      uniqueKeyPolicy: {
        uniqueKeys: [
          {
            paths: [
              '/phoneNumber'
            ]
          }
        ]
      }
    }
    options: {
      throughput: throughput
    }
  }
}
