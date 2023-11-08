
@description('Create a metric alert for response time')
param responseTimeThreshold int
@description('The action group id to use for the alert')
param actionGroupId string
@description('The resource id of the application insights instance')
param appInsightsResourceId string

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'responseAlertModule'
  location: 'global'
  properties: {
    description: 'Response time alert'
    severity: 0
    enabled: true
    scopes: [
      appInsightsResourceId
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: '1st criterion'
          metricName: 'requests/duration'
          operator: 'GreaterThan'
          threshold: responseTimeThreshold
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    actions: [
      
      {
        actionGroupId: actionGroupId
      }
    ]
  }
}
