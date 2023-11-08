param alertName string = 'App Requests'
param logAnalyticsWorkspaceId string 
param actionGroupId string 
@description('Location for resource.')
param location string

resource scheduledqueryrules'microsoft.insights/scheduledqueryrules@2022-08-01-preview' = {
  name: alertName
  location: location
  properties: {
    displayName: alertName
    severity: 3
    enabled: true
    evaluationFrequency: 'PT5M'
    scopes: [
      logAnalyticsWorkspaceId
    ]
    targetResourceTypes: [
      'microsoft.operationalinsights/workspaces'
    ]
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          query: 'AppRequests'
          timeAggregation: 'Count'
          dimensions: []
          resourceIdColumn: '_ResourceId'
          operator: 'GreaterThan'
          threshold: 5
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }
    autoMitigate: false
    actions: {
      actionGroups: [
        actionGroupId
      ]
      customProperties: {}
    }
  }
}
