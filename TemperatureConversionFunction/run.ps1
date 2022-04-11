using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

. ./TemperatureConversionFunction/TemperatureConverter.ps1

# Write to the Azure Functions log stream.
write-verbose 'PowerShell HTTP trigger function processed a request.'

[string]$OutputUnit = $Request.query.OutputUnit
[decimal]$InputValue = $Request.query.InputValue
[string]$InputUnit = $Request.query.InputUnit

$VerbosePreference = ${env:VERBOSEPREFERENCE}
write-host "VerbosePreference($VerbosePreference)"

write-verbose "OutputUnit($OutputUnit)"
write-verbose "InputValue($InputValue)"
write-verbose "InputUnit($InputUnit)"

$body = ''

if ('' -eq $InputValue -or '' -eq $OutputUnit) {
    $body = $body + ' Pass an Output Unit and an Input Value to return the value converted from Fahrenheit. Pass an Input Unit to convert the value from some other unit.' 
}
else {
    if ($OutputUnit) {
        $body = $body + " OutputUnit($OutputUnit) "
    }
        
    if ($InputValue) {
        $body = $body + " InputValue($InputValue) "
    }
        
    if ($InputUnit) {
        $body = $body + " InputUnit($InputUnit) "
    }

    [decimal]$ConvertedValue = TemperatureConverter -OutputUnit $OutputUnit -InputValue $InputValue

    $body = $body + "ConvertedValue=($ConvertedValue)"
        
}

write-verbose "body($body)"

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body       = $body
    })


#TD: -12 Include the build date and sha in the body of the response; Exclude the build date and time from Run, Integration and other tests.
