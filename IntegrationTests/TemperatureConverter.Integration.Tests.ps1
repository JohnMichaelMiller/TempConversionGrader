BeforeAll{
    $script:baseURL = 'https://Juxcefunctionapp.azurewebsites.net/api/TemperatureConversionFunction'
    $script:baseURL = 'https://Juxcefunctionapp-staging.azurewebsites.net/api/TemperatureConversionFunction'
    
}
AfterAll{}

Describe "Temperature Converter Integration Tests" -tag 'integration' {
    Context "Temperature Converter Integration Tests" {
        It " Call the function with no parameters" {
            $response = Invoke-WebRequest -Uri $script:baseURL
            $response.StatusCode | Should -Be 200
            $response.StatusDescription | Should -Be 'OK'
            $response.Content | Should -Be ' Pass an Output Unit and an Input Value to return the value converted from Fahrenheit. Pass an Input Unit to convert the value from some other unit.'
        }
        It " Call the function with output unit of Celsius and input value of 1" {
            $response = Invoke-WebRequest -Uri "$($baseURL)?OutputUnit=Celsius&InputValue=1"
            $response.StatusCode | Should -Be 200
            $response.StatusDescription | Should -Be 'OK'
            $response.Content | Should -Be ' OutputUnit(Celsius)  InputValue(1) ConvertedValue=(-17.222222222222222222222222222)'
        }
        It " Call the function with input unit of Kelvin, an output unit of Celsius, and input value of 1" {
            $response = Invoke-WebRequest -Uri "$($baseURL)?OutputUnit=Celsius&InputValue=1&InputUnit=Kelvin"
            $response.StatusCode | Should -Be 200
            $response.StatusDescription | Should -Be 'OK'
            $response.Content | Should -Be ' OutputUnit(Celsius)  InputValue(1)  InputUnit(Kelvin) ConvertedValue=(-17.222222222222222222222222222)'
        }
    }
}