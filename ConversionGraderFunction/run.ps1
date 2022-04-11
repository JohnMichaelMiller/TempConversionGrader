using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$VerbosePreference = ${env:VERBOSEPREFERENCE}
# write-host "VerbosePreference($VerbosePreference)"

#TD: -0 This should be a web dependency
. ./TemperatureConversionFunction/TemperatureConverter.ps1

. ./ConversionGraderFunction/ConversionGrader.ps1

# Write to the Azure Functions log stream.
write-verbose 'PowerShell HTTP trigger function processed a request.'

[string]$OutputUnit = $Request.query.OutputUnit
[string]$InputValue = $Request.query.InputValue
[string]$InputUnit = $Request.query.InputUnit
[string]$StudentValue = $Request.query.StudentValue

write-verbose "OutputUnit($OutputUnit)"
write-verbose "InputValue($InputValue)"
write-verbose "InputUnit($InputUnit)"
write-verbose "StudentValue($StudentValue)"

$studentValueInputIsValid = -not [string]::IsNullOrEmpty($StudentValue)
$inputValueInputIsValid = -not [string]::IsNullOrEmpty($InputValue)

write-verbose "studentValueInputIsValid($studentValueInputIsValid)"
write-verbose "inputValueInputIsValid($inputValueInputIsValid)"

$grade = ''

if ( $studentValueInputIsValid ) {
    try {
        $StudentValue = [System.Convert]::ToDecimal($StudentValue, [cultureinfo]::GetCultureInfo($(get-culture)))
    }
    catch {
        $grade = 'Incorrect'
        $studentValueInputIsValid = $false
    }
}

write-verbose "StudentValue($StudentValue)"
write-verbose "grade($grade)"
write-verbose "studentValueInputIsValid($studentValueInputIsValid)"

if ( $inputValueInputIsValid ) {
    try {
        $InputValue = [System.Convert]::ToDecimal($InputValue, [cultureinfo]::GetCultureInfo($(get-culture)))
    }
    catch {
        $grade = 'Invalid'
        $inputValueInputIsValid = $false
    }
}

write-verbose "InputValue($InputValue)"
write-verbose "grade($grade)"
write-verbose "inputValueInputIsValid($inputValueInputIsValid)"

$unitInputIsNotValid = `
    [string]::IsNullOrEmpty($InputUnit) -or `
    [string]::IsNullOrEmpty($OutputUnit)

write-verbose "unitInputIsNotValid($unitInputIsNotValid)"

$body = ''

if ( $unitInputIsNotValid ) {
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

    if ($StudentValue) {
        $body = $body + " StudentValue($StudentValue) "
    }

    if ('Invalid' -ne $grade -and 'Incorrect' -ne $grade) {
        try {
            $grade = ConversionGrader -OutputUnit $OutputUnit -InputValue $InputValue -InputUnit $InputUnit -StudentValue $StudentValue
        }
        catch [System.Management.Automation.ParameterBindingException] {
            $grade = 'Invalid'
        }
    }

    write-verbose "grade($grade)"

    $body = $body + "Grade($grade)"
        
}

write-verbose "body($body)"

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body       = $body
    })

