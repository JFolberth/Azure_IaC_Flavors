@description('Name for the storage account')
param storageAccountName string
@description('Name for the storage account container')
param storageAccountContainerName string


resource storageAccountABAC 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid('e7fad14a-cd5a-499d-965a-16ff4b768d6b','ba92f5b4-2d11-453d-a403-e96b0029c9feb',storageAccountName,storageAccountContainerName)
  properties: {
    
    principalId: 'e7fad14a-cd5a-499d-965a-16ff4b768d6b'
    principalType: 'User'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    conditionVersion: '1.0'
    condition: '''
    (
      (
       !
       (ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'})
       AND
       !
       (ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write'})
      )
      OR 
      (
       @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:name] StringEquals 'abac'
      )
     )
  '''
  }
}
