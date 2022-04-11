[CmdletBinding()]
param (
  [Parameter()]
  [string]
  $location
  , [Parameter()]
  [string]
  $resourceGroupName
  ,
  [Parameter()]
  [string]
  $templateFile
  ,
  [Parameter()]
  [string]
  $appName  ,
  [Parameter()]
  [string]
  $workingFolder
)

BeforeAll { 
  write-verbose "location($location)"
  write-verbose "resourceGroupName($resourceGroupName)"
  write-verbose "templateFile($templateFile)"
  write-verbose "appName($appName)"
  $VerbosePreference = ${env:VERBOSEPREFERENCE}
}

BeforeDiscovery {
  write-verbose "appName($appName)"
}
  
Describe 'Provision Function App Resources' -tag 'provision' {
  It " Provision Function App $appname" {
  
    write-verbose "az deployment group create --template-file $templateFile --name `"$appName.FunctionAppProvisioning`" --resource-group $resourceGroupName --parameters location=$location appName=$appName"

    $functionAppOutput = az deployment group create `
      --template-file $templateFile `
      --name "$appName.FunctionAppProvisioning" `
      --mode 'complete' `
      --resource-group $resourceGroupName `
      --parameters `
      appName=$appName `
    | ConvertFrom-Json
    $functionAppOutput | Export-Clixml -Path "$workingFolder/clixml/functionapp.$appName.$($(get-date).ticks).clixml"
    $functionAppOutput | Should -not -Be ''
    $functionAppOutput.properties.provisioningState | Should -Be 'Succeeded'
    $functionAppOutput.name | Should -Be "$appName.FunctionAppProvisioning"
  }
  It " Provision Function App $appName Verification" {
    $functionapps = az functionapp list --resource-group $resourceGroupName | convertfrom-json
    $functionapps.availabilityState | Should -Be 'Normal'
    $functionapps.enabled | Should -Be 'True'
    $functionapps.name | Should -Be $appName
    $functionapps.state | Should -Be 'Running'
    $functionapps.usageState | Should -Be 'Normal'
  }
}
