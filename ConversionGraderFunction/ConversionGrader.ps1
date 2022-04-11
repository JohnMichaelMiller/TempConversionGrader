<# .SYNOPSIS #>
# Grades provided temparature coversion values. 

function ConversionGrader {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet('Fahrenheit', 'Celsius', 'Kelvin', 'Rankine')]
        [ValidateNotNullOrEmpty()]
        [string]
        $OutputUnit # Valid output units are Fahrenheit, Celsius, Kelvin, and Rankine."
        , [Parameter()]
        [ValidateNotNullOrEmpty()]
        [decimal]
        $InputValue # The input value is any real number.
        , [Parameter()]
        [ValidateSet('Fahrenheit', 'Celsius', 'Kelvin', 'Rankine')]
        [ValidateNotNullOrEmpty()]
        [string]
        $InputUnit = 'Fahrenheit' # Valid input units are Fahrenheit, Celsius, Kelvin, and Rankine. The default is Fahrenheit.
        , [Parameter()]
        [ValidateNotNullOrEmpty()]
        [decimal]
        $StudentValue = 'Fahrenheit' # The input value is any real number.
    )
    
    Write-Verbose "OutputUnit($OutputUnit)"
    Write-Verbose "InputUnit($InputUnit)"
    Write-Verbose "InputValue($InputValue)"
    Write-Verbose "StudentValue($StudentValue)"
    
    $InputUnit = $InputUnit.ToLower()
    $OutputUnit = $OutputUnit.ToLower()

    $correctValue = TemperatureConverter -OutputUnit $OutputUnit -InputValue $InputValue -InputUnit $InputUnit
    $correctValue = [math]::Round($correctValue, 1)
    Write-Verbose "correctValue($correctValue)"

    $StudentValue = [math]::Round($StudentValue, 1)
    Write-Verbose "StudentValue($StudentValue)"

    write-verbose "($studentValue -eq $correctValue)($($studentValue -eq $correctValue))"

    if ($studentValue -eq $correctValue) {
        $grade = 'Correct'
    } else {
        $grade = 'Incorrect'     
    }

    return $grade
}
