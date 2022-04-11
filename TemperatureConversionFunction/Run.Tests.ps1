
BeforeAll {
    . ./TemperatureConversionFunction/TestClasses.ps1
    . ./TemperatureConversionFunction/TemperatureConverter.ps1
}

Describe "Test Class Tests" -tag 'unit' {
    It "  Query Instantiation Test" {
        
        [Query]$Query = [Query]::new('Celsius',1,'Fahrenheit')
        $Query.OutputUnit | Should -Be 'Celsius'
        $Query.InputValue | Should -Be 1
        $Query.InputUnit | Should -Be 'Fahrenheit'
    }

    It "  Request Instantiation Test" {
        [Request]$Request = [Request]::new('Kelvin',1,'Fahrenheit')
        $Request.Query.OutputUnit | Should -Be 'Kelvin'
        $Request.Query.InputValue | Should -Be 1
        $Request.Query.InputUnit | Should -Be 'Fahrenheit'
    }
}

Describe "Run Tests" -tag 'unit' {
    It "  Run Output Unit Kelvin, Input Value 1, Input Unit Celsius" {
        [Request]$Request = [Request]::new('Kelvin',1,'Celsius')
        mock TemperatureConverter -MockWith {return 100}
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./TemperatureConversionFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Kelvin)  InputValue(1)  InputUnit(Celsius) ConvertedValue=(100)'
    }
    It "  Run Output Unit Celsius, Input Value 1, Input Unit Kelvin" {
        [Request]$Request = [Request]::new('Celsius',1,'Kelvin')
        mock TemperatureConverter -MockWith {return -272.15}
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./TemperatureConversionFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Celsius)  InputValue(1)  InputUnit(Kelvin) ConvertedValue=(-272.15)'
    }
    It "  Run Output Unit Rankine, Input Value 2, no Input Unit" {
        [Request]$Request = [Request]::new('Rankine',2)
        mock TemperatureConverter -MockWith {return 101}
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./TemperatureConversionFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Rankine)  InputValue(2) ConvertedValue=(101)'
    }    
    It "  Run Output Unit Celsius, no Input Value, no Input Unit" {
        [Request]$Request = [Request]::new('Celsius')
        mock TemperatureConverter -MockWith {return 103}
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./TemperatureConversionFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Celsius) ConvertedValue=(103)'
    }
    It "  Run No Inputs" {
        [Request]$Request = [Request]::new()
        mock TemperatureConverter -MockWith {return 104}
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./TemperatureConversionFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' Pass an Output Unit and an Input Value to return the value converted from Fahrenheit. Pass an Input Unit to convert the value from some other unit.'
    }
}
