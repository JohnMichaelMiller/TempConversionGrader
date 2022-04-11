. ./Util/ts.ps1

function TryEndpoint {
    [CmdletBinding()]
    param (
        [Parameter()]
        # The endpoint to try
        [string]
        $Endpoint,
        [Parameter()]
        # Name of the enpoint to dispay
        [string]
        $EndPointName,
        [Parameter()]
        # Slot name 
        [string]
        $SlotName
    )

    try {
        $response = invoke-webrequest -uri $Endpoint
        $isException = $false
    }
    catch {
        $isException = $true
        $response = $_.Exception.Response
    }

    if ($isException) {
        return "$(ts) $($response.StatusCode.value__) $($response.ReasonPhrase) $($EndPointName) $($SlotName)"
    }
    else {
        $content = $response.Content.replace("`r`n", '!')
        do {
            $content = $content.replace('  ', ' ').replace('  ', ' ')
            
        } while ($content.Contains('  '))
        $content = $content.substring(0, [system.math]::min($content.length, 125))
        Write-Verbose "content($content)"
        return "$(ts) $($response.StatusCode) $($response.StatusDescription) $($content) $($EndPointName) $($SlotName)"
        
    }
}