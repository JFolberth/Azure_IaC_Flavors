@description('Name for the Application Insights')
param appInsightsName string
@description('Location for resource.')
param location string
@description('Log Analytics Workspace ID to send App Insights Log To')
param logAnalyticsWorkspaceID string
@description('What language was used to deploy this resource')
param language string


resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: toLower('ai-${appInsightsName}')
  location: location
  kind: 'string'
  tags: {
    displayName: 'AppInsight'
    Language: language
  }
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceID
  }
}

output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
