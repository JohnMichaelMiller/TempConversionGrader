[CmdletBinding()]
param (
    [Parameter()]
    [int]
    $Interval = 10000,
    [Parameter()]
    # Name of the slot
    [string]
    $SlotName = '-staging'
)

. ./Util/TryEndpoint.ps1

$baseURL = 'https://Juxcefunctionapp{0}.azurewebsites.net/api/'
$endpoints = @(
    @{
        BaseURL      = $baseURL;
        EndPointName = 'TemperatureConversionFunction';
        Parameters   = '?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius'
    }, 
    @{
        BaseURL      = $baseURL;
        EndPointName = 'ConversionGraderFunction';
        Parameters   = '?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius'
    }

)
do {

    $endpoints | forEach-object {
        $url = "$($_.BaseURL)$($_.EndPointName)$($_.Parameters)" -f $SlotName
        Write-Verbose "url($url)"
        Write-Output $(TryEndpoint -Endpoint $url -EndPointName $_.EndPointName -SlotName $SlotName)
    
    }

    Start-Sleep -Milliseconds $Interval    

} until ($false)
