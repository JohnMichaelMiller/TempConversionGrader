BeforeAll {
    . ./Util/TryEndpoint.ps1
    . ./ConversionGraderFunction/TestClasses.ps1

}

Describe 'TryEnpoint Tests' -tag 'unit' {
    $baseURL = 'https://Juxcefunctionapp{0}.azurewebsites.net/api/'
    It 'Test an endpoint' {
        $SlotName = ''
        $EndPointName = 'TemperatureConversionFunction'
        $Parameters = '?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius'
        $Response = ''
        mock invoke-webrequest {
            [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new([HttpStatusCode]::OK, 'Response Body Test', 'OK', 'Response Content Test')
            [Response]$Response = [Response]::new($HttpResponseContext)
            return $Response } 
        $url = "$($baseURL)$($EndPointName)$($Parameters)" -f $SlotName
        Write-Verbose "url($url)"
        $r = TryEndpoint -Endpoint $url -EndPointName $EndPointName -SlotName $SlotName
        Write-Verbose "r($r)"
        Should -Invoke invoke-webrequest -Times 1 -Exactly
        $r | Should -not -Be $null
        $r.substring(21) | Should -Be '200 OK Response Content Test TemperatureConversionFunction '
    }
    It 'Test TryEndpoint with BaseURL(<baseURL>), SlotName(<slotName>), EndPointName(<endPointName>), Parameters(<parameters>) expecting the Response(<response>)' -ForEach @(
        @{
            BaseURL      = $baseURL
            SlotName     = ''
            EndPointName = 'TemperatureConversionFunction'
            Parameters   = '?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius'
            Response     = '200 OK Response Content Test TemperatureConversionFunction '
        }, 
        @{
            BaseURL      = $baseURL
            SlotName     = ''
            EndPointName = 'ConversionGraderFunction'
            Parameters   = '?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius&StudentValue=123.23'
            Response     = '200 OK Response Content Test ConversionGraderFunction '
        }
        @{
            BaseURL      = $baseURL
            SlotName     = '-staging'
            EndPointName = 'ConversionGraderFunction'
            Parameters   = '?InputValue=1000&OutputUnit=Rankine&InputUnit=Celsius&StudentValue=123.23'
            Response     = '200 OK Response Content Test ConversionGraderFunction -staging'
        }
    ) {
        mock invoke-webrequest {
            [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new([HttpStatusCode]::OK, 'Response Body Test', 'OK', 'Response Content Test')
            [Response]$Response = [Response]::new($HttpResponseContext)
            return $Response } 
        $url = "$($baseURL)$($EndPointName)$($Parameters)" -f $SlotName
        Write-Verbose "url($url)"
        $r = TryEndpoint -Endpoint $url -EndPointName $EndPointName -SlotName $SlotName
        Write-Verbose "r($r)"
        Should -Invoke invoke-webrequest -Times 1 -Exactly
        $r | Should -not -Be $null
        $r.substring(21) | Should -Be $response
    }
}