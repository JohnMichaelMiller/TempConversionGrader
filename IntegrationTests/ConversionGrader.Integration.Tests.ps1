[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $SlotName = '-staging'
)
BeforeAll {
    . ./Util/TryEndpoint.ps1
    $script:baseURL = "https://Juxcefunctionapp{0}.azurewebsites.net/api/ConversionGraderFunction"
}
AfterAll {}

#TD: Refactor TemperatureConversion integration tests to follow the pattern set here.
Describe 'Conversion Grading Integration Tests' -tag 'integration' {
    Write-Verbose "script:baseURL($script:baseURL)"
    It ' Call the endpoint with no parameters' {
        $url = $script:baseURL -f $SlotName
        Write-Verbose "url($url)"
        $response = TryEndpoint -Endpoint $url -EndPointName 'TestEndPoint' -SlotName $SlotName
        $response | Should -not -Be $null
        $response.substring(21) | Should -Be '200 OK  Pass an Output Unit and an Input Value to return the value converted from Fahrenheit. Pass an Input Unit to convert the valu TestEndPoint -staging'
    }
    It ' Call the endpoint with Input Value of 84.2, Input Unit of Fahrenheit, Output Unit of Rankine, and Student Value of 543.94' {
        $url = $script:baseURL -f $SlotName
        Write-Verbose "url($url)"
        $parameters = "?InputValue=84.2&InputUnit=Fahrenheit&OutputUnit=Rankine&StudentValue=543.94"
        $url = "$url$parameters"
        Write-Verbose "url($url)"
        $response = TryEndpoint -Endpoint $url -EndPointName 'TestEndPoint' -SlotName $SlotName
        $response | Should -not -Be $null
        $response.substring(21) | Should -Be '200 OK  OutputUnit(Rankine) InputValue(84.2) InputUnit(Fahrenheit) StudentValue(543.94) Grade(Correct) TestEndPoint -staging'
    }
    It ' Call the endpoint with Input Value of 317.33, Input Unit of Kelvin, Output Unit of Fahrenheit, and Student Value of 111.554' {
        $url = $script:baseURL -f $SlotName
        Write-Verbose "url($url)"
        $parameters = "?InputValue=317.33&InputUnit=Kelvin&OutputUnit=Fahrenheit&StudentValue=111.554"
        $url = "$url$parameters"
        Write-Verbose "url($url)"
        $response = TryEndpoint -Endpoint $url -EndPointName 'TestEndPoint' -SlotName $SlotName
        $response | Should -not -Be $null
        $response.substring(21) | Should -Be '200 OK  OutputUnit(Fahrenheit) InputValue(317.33) InputUnit(Kelvin) StudentValue(111.554) Grade(Incorrect) TestEndPoint -staging'
    }
    It ' Call the endpoint with Input Value of 6.5, Input Unit of Fahrenheit, Output Unit of Rankine, and Student Value of Dog' {
        $url = $script:baseURL -f $SlotName
        Write-Verbose "url($url)"
        $parameters = "?InputValue=6.5&InputUnit=Fahrenheit&OutputUnit=Rankine&StudentValue=Dog"
        $url = "$url$parameters"
        Write-Verbose "url($url)"
        $response = TryEndpoint -Endpoint $url -EndPointName 'TestEndPoint' -SlotName $SlotName
        $response | Should -not -Be $null
        $response.substring(21) | Should -Be '200 OK  OutputUnit(Rankine) InputValue(6.5) InputUnit(Fahrenheit) StudentValue(Dog) Grade(Incorrect) TestEndPoint -staging'
    }
    It ' Call the endpoint with Input Value of 136.1, Input Unit of dogcow, Output Unit of Celsius, and Student Value of 45.32' {
        $url = $script:baseURL -f $SlotName
        Write-Verbose "url($url)"
        $parameters = "?InputValue=136.1&InputUnit=dogcow&OutputUnit=Celsius&StudentValue=45.32"
        $url = "$url$parameters"
        Write-Verbose "url($url)"
        $response = TryEndpoint -Endpoint $url -EndPointName 'TestEndPoint' -SlotName $SlotName
        # This help when the output changes by capturing the response when run locally: $response | Set-Clipboard
        $response | Should -not -Be $null
        $response.substring(21) | Should -Be '200 OK  OutputUnit(Celsius) InputValue(136.1) InputUnit(dogcow) StudentValue(45.32) Grade(Invalid) TestEndPoint -staging'
    }
}