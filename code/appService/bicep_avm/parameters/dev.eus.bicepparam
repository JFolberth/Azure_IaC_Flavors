using '../main.bicep'
param location = 'eastus'
param retentionDays = 30
param appServicePlanSKU = {
    name: 'D1'
    tier: 'Shared'
    size: 'D1'
    family: 'D'
    capacity: 0
  }

