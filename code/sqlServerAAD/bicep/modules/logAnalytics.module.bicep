@description('Name for the Log Analytics Workspace')
param logAnalyticsName string
@description('Location for resource.')
param location string
@description('How Many Day to retain Log Analytics Logs')
param retentionDays int = 30
@description('What Language was used to deploy this resource')
param language string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: toLower('la-${logAnalyticsName}')
  location: location
  tags: {
    displayName: 'Log Analytics'
    Language: language
  }
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionDays
    features: {
      searchVersion: 1
      legacy: 0
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

output logAnalyticsWorkspaceID string = logAnalyticsWorkspace.id
