@description('Name for the storage account')
param storageAccountName string
@description('Container Name to create')
param storageAccountContainerName string

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  name: '${storageAccountName}/default/${storageAccountContainerName}'
}

output storageAccountContainerName string = container.name
