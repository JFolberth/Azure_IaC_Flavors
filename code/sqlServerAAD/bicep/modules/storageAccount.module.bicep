@description('Name for the storage account')
param storageAccountName string
@description('Location for resource.')
param location string
@description('What language was used to deploy this resource')
param language string

@description('Storage Account type')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageAccountType string = 'Standard_LRS'


resource sa 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: toLower(replace('sa${storageAccountName}','-',''))
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: storageAccountType
  }
  tags:{
    Language: language
  }
  kind: 'StorageV2'
  properties: {}
}


resource storageAccountBlobVulnerability 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: sa
}

resource storageAccountContainerVulnerability 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'vulnerabilityscans'
  parent: storageAccountBlobVulnerability
}

   
output storageAccountName string = sa.name
output storageAccountVulnerabilityEndpoint string = '${sa.properties.primaryEndpoints.blob}${storageAccountContainerVulnerability.name}'

