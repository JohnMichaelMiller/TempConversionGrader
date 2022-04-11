[CmdletBinding()]
param (
    [Parameter()]
    $tags = @('unit','provision')
)

Clear-Host

$VerbosePreference = 'silentlycontinue' # 'continue' # 

if ($null -eq $path) {
    $path = '*.tests.ps1' ; $path | test-path
}

$pesterconfiguration = New-PesterConfiguration
$pesterconfiguration.Run.Exit = $false
$pesterconfiguration.Run.PassThru = $true
$pesterconfiguration.Output.Verbosity = 'Detailed'
$pesterconfiguration.Filter.Tag = $tags

Measure-Command {
    invoke-pester -Configuration $pesterconfiguration
}
