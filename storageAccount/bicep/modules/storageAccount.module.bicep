@description('Name for the storage account')
param storageAccountName string
@description('Location for resource.')
param location string
@description('What Language was used to deploy this resource')
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

resource sa 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  tags:{
    Language: language
  }
  kind: 'StorageV2'
  properties: {}
}
