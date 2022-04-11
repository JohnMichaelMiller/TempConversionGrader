// Not used. Yet.
resource standardWebTest 'Microsoft.Insights/webtests@2018-05-01-preview' = {
  name: 'JuxceWebTest'
  location: location
  dependsOn: [
    appInsights
  ]
  tags: {
    'hidden-link:/subscriptions/${subscription().id}/resourceGroups/${resourceGroup().name}/providers/microsoft.insights/components/${appInsightsName}': 'Resource'
  }
  properties: {
    SyntheticMonitorId: 'JuxceWebTestId'
    Name: 'JuxceWebTest'
    Description: 'Availability Monitor for Juxce'
    Enabled: true
    Frequency: 300
    Timeout: 120 
    Kind: 'standard'
    RetryEnabled: true
    Locations: [
      {
        Id: 'emea-nl-ams-azr'
      }
      {
        Id: 'emea-ru-msa-edge'
      }
      {
        Id: 'apac-hk-hkn-azr'
      }
      {
        Id: 'latam-br-gru-edge'
      }
      {
        Id: 'emea-au-syd-edge'
      }
    ]
    Configuration: null
    Request: {
      RequestUrl: 'https://Juxcefunctionapp.azurewebsites.net/api/TemperatureConversionFunction?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius'
      Headers: null
      HttpVerb: 'GET'
      RequestBody: null
      ParseDependentRequests: false
      FollowRedirects: null
    }
    ValidationRules: {
      ExpectedHttpStatusCode: 200
      IgnoreHttpsStatusCode: false
      ContentValidation: null
      SSLCheck: true
      SSLCertRemainingLifetimeCheck: 7
    }
  }
}
