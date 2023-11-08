@description('Name for the Application Insights')
param appInsightsName string
@description('Location for resource.')
param location string
@description('Log Analytics Workspace ID to send App Insights Log To')
param logAnalyticsWorkspaceId string
@description('What language was used to deploy this resource')
param language string
@description('Emails to send smart detection alerts to')
param smartDetectionEmails array = []
@description('Send smart detection emails to subscription owners')
param sendSmartDetectionEmailsSubscriptionOwners bool = false


resource appInsights 'Microsoft.Insights/components@2020-02-02' ={
  name: toLower('ai-${appInsightsName}')
  location: location
  kind: 'string'
  tags: {
    displayName: 'AppInsight'
    Language: language
  }
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
}

resource slowpageloadtime 'Microsoft.Insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  name: 'slowpageloadtime'
  parent: appInsights
  location: location
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: sendSmartDetectionEmailsSubscriptionOwners
    CustomEmails: smartDetectionEmails
  }

}
resource degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  name: 'degradationindependencyduration'
  parent: appInsights
  location: location
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: sendSmartDetectionEmailsSubscriptionOwners
    CustomEmails: smartDetectionEmails
  }

}

resource degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  name: 'degradationinserverresponsetime'
  location: location
  parent: appInsights
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: sendSmartDetectionEmailsSubscriptionOwners
    CustomEmails: smartDetectionEmails
  }

}

resource digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  name: 'digestMailConfiguration'
  parent: appInsights
  location: location
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: sendSmartDetectionEmailsSubscriptionOwners
    CustomEmails: smartDetectionEmails
  }

}

resource ongdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  name: 'longdependencyduration'
  parent: appInsights
  location: location
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: sendSmartDetectionEmailsSubscriptionOwners
    CustomEmails: smartDetectionEmails
}
}

resource slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  name: 'slowserverresponsetime'
  parent: appInsights
  location: location
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: sendSmartDetectionEmailsSubscriptionOwners
    CustomEmails: smartDetectionEmails
  }
}




output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output appInsightsResourceId string = appInsights.id
