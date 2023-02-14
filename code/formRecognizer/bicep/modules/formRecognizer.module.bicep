@description('Name for the For Recognizer resource.')
param formRecognizerName string
@description('SKU for Form Recognizer')
@allowed(['F0'
          'S0'])
param formRecognizerSKU string
@description('Location for resource.')
param location string
@description('What language was used to deploy this resource')
param language string

resource formRecognizer 'Microsoft.CognitiveServices/accounts@2022-12-01'={
  name: toLower('fr-${formRecognizerName}')
  location: location
  kind: 'FormRecognizer'
  sku: {
    name: formRecognizerSKU
  }
  properties: {
    customSubDomainName: formRecognizerName
  }
  tags: {
    language: language
  }


}
