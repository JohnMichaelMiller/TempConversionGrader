BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    . ./ConversionGraderFunction/ConversionGrader.ps1
    . ./ConversionGraderFunction/TestClasses.ps1
    . ./TemperatureConversionFunction/TemperatureConverter.ps1
}

Describe "Mock Test" -tag 'unit' {
    It "Temperature Converter Mock Test" {
        Mock TemperatureConverter {return 1}
        $result = TemperatureConverter -OutputUnit 'Celsius' -InputValue 1111 -InputUnit 'Kelvin'
        $result | Should -Be 1
        Should -Invoke TemperatureConverter -Times 1
    }
}
Describe 'ConversionGrader with invalid parameters' -tag 'unit' {
    It ' Throws an error when a null output unit is provided' {
        { ConversionGrader -OutputUnit $null } | Should -Throw 
    }
    It ' Throws an error when no output unit is provided' {
        { ConversionGrader -OutputUnit '' } | Should -Throw 
    }
    It ' Throws an error when an invalid output unit is provided' {
        { ConversionGrader -OutputUnit 'TEST' } | Should -Throw 
    }
    It ' Throws an error when an invalid input value is provided' {
        { ConversionGrader -OutputUnit 'Celsius' -InputValue 'TEST' } | Should -Throw 
    }
    It ' Throws an error when a null input unit is provided' {
        { ConversionGrader -InputUnit $null } | Should -Throw 
    }
    It ' Throws an error when an invalid input unit is provided' {
        { ConversionGrader -InputUnit 'TEST' } | Should -Throw 
    }
}



Describe 'Conversion Grading Tests' -tag 'unit' {
    It '  Grade Output Unit Rankine, Input Value 84.2, Input Unit Fahrenheit, Student Value 543.94' {
        Mock TemperatureConverter -MockWith {return 543.87}
        $results = ConversionGrader -OutputUnit 'Rankine' -InputValue 84.2 -InputUnit 'Fahrenheit' -StudentValue 543.94
        $results | Should -Be 'Correct'
        Should -Invoke TemperatureConverter -Times 1 -Exactly
    }
    It '  Grade Output Unit Fahrenheit, Input Value 317.33, Input Unit Kelvin, Student Value 111.554' {
        Mock TemperatureConverter -MockWith {return 111.524}
        $results = ConversionGrader -OutputUnit 'Fahrenheit' -InputValue 317.33 -InputUnit 'Kelvin' -StudentValue 111.554
        $results | Should -Be 'Incorrect'
        Should -Invoke TemperatureConverter -Times 1 -Exactly
    }
}
