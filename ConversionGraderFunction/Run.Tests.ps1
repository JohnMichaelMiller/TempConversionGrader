
BeforeAll {
    . ./ConversionGraderFunction/TestClasses.ps1
}

Describe 'Test Class Tests' -tag 'unit' {
    It '  Query Instantiation Test' {
        
        [Query]$Query = [Query]::new('Celsius', 1, 'Fahrenheit', 2)
        $Query.OutputUnit | Should -Be 'Celsius'
        $Query.InputUnit | Should -Be 'Fahrenheit'
        $Query.InputValue | Should -Be 1
        $Query.StudentValue | Should -Be 2
    }

    It '  Request Instantiation Test' {
        [Request]$Request = [Request]::new('Kelvin', 1, 'Fahrenheit', 2)
        $Request.Query.OutputUnit | Should -Be 'Kelvin'
        $Request.Query.InputUnit | Should -Be 'Fahrenheit'
        $Request.Query.InputValue | Should -Be 1
        $Request.Query.StudentValue | Should -Be 2
    }
}

Describe 'Run Tests' -tag 'unit' {
    It '  Run Output Unit Rankine, Input Value 84.2, Input Unit Fahrenheit, Student Value 543.94 and expect grade Correct' {
        [Request]$Request = [Request]::new('Rankine', '84.2', 'Fahrenheit', '543.94')
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./ConversionGraderFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Rankine)  InputValue(84.2)  InputUnit(Fahrenheit)  StudentValue(543.94) Grade(Correct)'
    }
    It '  Run Output Unit Fahrenheit, Input Value 317.33, Input Unit Kelvin, Student Value 111.554 and expect grade Incorrect' {
        [Request]$Request = [Request]::new('Fahrenheit', '317.33', 'Kelvin', '111.554')
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./ConversionGraderFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Fahrenheit)  InputValue(317.33)  InputUnit(Kelvin)  StudentValue(111.554) Grade(Incorrect)'

    }
    It '  Run Output Unit Rankine, Input Value 6.5, Input Unit Fahrenheit, Student Value dog and expect grade Incorrect' {
        [Request]$Request = [Request]::new('Rankine', '6.5', 'Fahrenheit', 'dog')
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./ConversionGraderFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Rankine)  InputValue(6.5)  InputUnit(Fahrenheit)  StudentValue(dog) Grade(Incorrect)'
    }
    It '  Run Output Unit Rankine, Input Value 136.1, Input Unit dogcow, Student Value 45.32 and expect grade Invalid' {
        [Request]$Request = [Request]::new('Celsius', '136.1', 'dogcow', '45.32')
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./ConversionGraderFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(Celsius)  InputValue(136.1)  InputUnit(dogcow)  StudentValue(45.32) Grade(Invalid)'
    }
    It '  Run Output Unit dogcow, Input Value 136.1, Input Unit Celsius, Student Value 45.32 expect grade Invalid' {
        [Request]$Request = [Request]::new('dogcow', '136.1', 'Celsius', '45.32')
        $global:response = $null
        mock Push-OutputBinding -MockWith {
            $global:response = New-Object -TypeName Response 
            $global:response.StatusCode = [HttpStatusCode]::OK
            $global:response.Body = $Body
        }
        ./ConversionGraderFunction/run.ps1 -Request $Request -TriggerMetadata $null
        $global:response.StatusCode | Should -Be 200
        $global:response.Body | Should -Be ' OutputUnit(dogcow)  InputValue(136.1)  InputUnit(Celsius)  StudentValue(45.32) Grade(Invalid)'
    }
}
