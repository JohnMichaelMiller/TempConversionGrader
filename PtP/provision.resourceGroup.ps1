[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $location
    , [Parameter()]
    [string]
    $resourceGroupName
    , [Parameter()]
    [string]
    $templateFile
    , [Parameter()]
    [string]
    $workingFolder
)

BeforeAll {
    write-verbose "location($location)"
    write-verbose "resourceGroupName($resourceGroupName)"
    write-verbose "templateFile($templateFile)"
    if (-not (test-path 'clixml')) {
        mkdir 'clixml'
    }
}

BeforeDiscovery {
    $resourceGroupExists = $(az group exists --name $resourceGroupName) -eq 'true'
    write-verbose "resourceGroupExists($resourceGroupExists)"
}

Describe "provisioning of the resource group $resourceGroupName" -tag 'provision' {
    It "  Provisioned Resource Group $resourceGroupName" {

        write-verbose "az deployment sub create --template-file $templateFile --location $location --name `"$resourceGroupName.ResourceGroupProvisioning`"  --parameters resourceGroupName=$resourceGroupName resourceGroupLocation=$location"

        $resourceGroupOutput = az deployment sub create `
            --template-file $templateFile `
            --location $location `
            --name "$resourceGroupName.ResourceGroupProvisioning" `
            --parameters `
            resourceGroupName=$resourceGroupName `
            resourceGroupLocation=$location `
        | ConvertFrom-Json
        $resourceGroupOutput | Export-Clixml -Path "$workingFolder/clixml/resourcegroup.$resourceGroupName.$($(get-date).ticks).clixml"
        $resourceGroupOutput.properties.provisioningState | Should -Be 'Succeeded'
        $resourceGroupOutput.name | Should -Be "$resourceGroupName.ResourceGroupProvisioning"
    } 
    It "  Resource Group $resourceGroupName Verification" {
        write-verbose "Verifying resource group $resourceGroupName"
        az group exists --name $resourceGroupName | Should -Be $true
    }
}
