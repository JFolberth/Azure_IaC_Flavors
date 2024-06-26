@description('Name for the App Service')
param appServiceName string
@description('Location for resource.')
param location string
@description('Resource ID of the App Service Plan')
param appServicePlanID string
@description('Instrumentation Key for App Insights')
param appInsightsInstrumentationKey string
@description('What language was used to deploy this resource')
param language string


resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: toLower('app-${appServiceName}')
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    displayName: 'Website'
    Language: language
  }
  properties: {
    serverFarmId: appServicePlanID
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }
}

resource appServiceLogging 'Microsoft.Web/sites/config@2023-01-01' = {
  parent: appService
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsInstrumentationKey
  }
}
