@description('Name for the storage account')
param dataLakeName string
@description('Container Name to create')
param dataLakeContainerName string

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  name: '${dataLakeName}/default/${dataLakeContainerName}'
}

output dataLakeContainerName string = container.name
