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
    [string]
    $appName
    , [Parameter()]
    [bool]
    $passThru = $false
)

write-verbose "invoke.provision.functionApp location($location) resourceGroupName($resourceGroupName) templateFile($templateFile) workingDirectory($workingDirectory) appName($appName) passThru($passThru)"

$data = @{location = $location; resourceGroupName = $resourceGroupName; templateFile = "$workingDirectory/PtP/$templateFile"; appName = $appName; workingFolder = $workingDirectory}
$path = "$workingDirectory/PtP/provision.functionApp.ps1"
$container = New-PesterContainer -Path "$path" -Data $data
$config = New-PesterConfiguration
$config.Output.Verbosity = 'Detailed'
$config.Run.PassThru = $passThru
$config.Run.Container = $container
Invoke-Pester -Configuration $config

write-verbose "-invoke.provision.functionApp location($location) resourceGroupName($resourceGroupName) templateFile($templateFile) workingDirectory($workingDirectory) appName($appName) passThru($passThru)"
