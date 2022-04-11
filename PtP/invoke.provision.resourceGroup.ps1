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
    $workingDirectory
    , [Parameter()]
    [bool]
    $dropResourceGroup = $false
    , [Parameter()]
    [bool]
    $passThru = $false
)

write-verbose "invoke.provision.resourceGroup location($location) resourceGroupName($resourceGroupName) templateFile($templateFile) workingDirectory($workingDirectory) dropResourceGroup($dropResourceGroup) passThru($passThru)"

if ($dropResourceGroup -and $(az group exists --name $resourceGroupName) -eq 'true') { 
    write-verbose "Dropping resource group $resourceGroupName"
    az group delete --resource-group $resourceGroupName --yes 
}

$data = @{location = $location; resourceGroupName = $resourceGroupName; templateFile = "$workingDirectory/PtP/$templateFile"; workingFolder = $workingDirectory}
$path = "$workingDirectory/PtP/provision.resourceGroup.ps1"
$container = New-PesterContainer -Path "$path" -Data $data
$config = New-PesterConfiguration
$config.Output.Verbosity = 'Detailed'
$config.Run.PassThru = $passThru
$config.Run.Container = $container
Invoke-Pester -Configuration $config

write-verbose "-invoke.provision.resourceGroup location($location) resourceGroupName($resourceGroupName) templateFile($templateFile) workingDirectory($workingDirectory) dropResourceGroup($dropResourceGroup) passThru($passThru)"
