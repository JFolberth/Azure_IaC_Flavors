@description('The resource ID the budget will be applied to')
param resourceId string
@description('The base amount used for budget, default is 100')
param budgetAmount int = 100
@description('The first threshold when passed that will trigger an alert. This is a ')
param firstThreshold int = 80
@description('The second threshold when passed that will trigger an alert')
param secondThreshold int = 110
@description('List of email address to alert when the budget has been surpassed')
param contactEmails array = []
@description('A budget must be set to the first day of the month of the current deployment.')
param startDate string = '${utcNow('yyyy-MM')}-01'
@description('The time covered by a budget. Tracking of the amount will be reset based on the time grain. BillingMonth, BillingQuarter, and BillingAnnual are only supported by WD customers')
@allowed([
  'Annually'
  'BillingAnnual'
  'BillingMonth'
  'BillingQuarter'
  'Monthly'
  'Quarterly'
]
)
param timeGrain string = 'Monthly'
@description('May be used to filter budgets by user-specified dimensions and/or tags.')
param filterName string = 'ResourceId'
@description('List of RBAC roles that should be notifed')
param contactRoles array = [
  'Owner'
]
@description('he category of the budget, whether the budget tracks cost or usage.')
@allowed([
  'Cost'
])
param category string = 'Cost'
@description('The comparison operator.')
param operator string = 'GreaterThan'

resource budget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: '${substring(resourceId,lastIndexOf(resourceId,'/'),(length(resourceId)-lastIndexOf(resourceId,'/')))}-ConsumptionBudget'
  properties: {
    timePeriod: {
      startDate: startDate
    }
    timeGrain: timeGrain
    category: category 
    amount: budgetAmount
    notifications:{
      NotificationForExceededBudget1: {
        enabled: true
        contactEmails: contactEmails
        contactRoles: contactRoles
        threshold: firstThreshold
        operator: operator
      }
      NotificationForExceededBudget2: {
        enabled: true
        contactEmails: contactEmails
        contactRoles: contactRoles
        threshold: secondThreshold
        operator: operator
      }
    }
    filter: {
          dimensions: {
            name: filterName
            operator: 'In'
            values: [
              resourceId
            ]
          }
    }
  }
  
}
