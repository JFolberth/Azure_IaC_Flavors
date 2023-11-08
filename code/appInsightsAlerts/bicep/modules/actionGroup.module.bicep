@description('Object containing the email receivers for the action group.')
param emailReceivers array = []
@description('Object containing the logic app receivers for the action group.')
param logicAppReceivers array = []

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: 'emailActionGroup'
  location: 'global'
  properties: {
    groupShortName: 'string'
    enabled: true
    emailReceivers: emailReceivers
    logicAppReceivers: logicAppReceivers
  }
}

output actionGroupId string = actionGroup.id
