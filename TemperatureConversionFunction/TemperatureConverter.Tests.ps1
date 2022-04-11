BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    . TemperatureConversionFunction/TemperatureConverter.ps1
}

Describe 'TemperatureConverter with invalid parameters' -tag 'unit' {
    It ' Throws an error when a null output unit is provided' {
        { TemperatureConverter -OutputUnit $null } | Should -Throw 
    }
    It ' Throws an error when no output unit is provided' {
        { TemperatureConverter -OutputUnit '' } | Should -Throw 
    }
    It ' Throws an error when an invalid output unit is provided' {
        { TemperatureConverter -OutputUnit 'TEST' } | Should -Throw 
    }
    It ' Throws an error when an invalid input value is provided' {
        { TemperatureConverter -OutputUnit 'Celsius' -InputValue 'TEST' } | Should -Throw 
    }
    It ' Throws an error when a null input unit is provided' {
        { TemperatureConverter -InputUnit $null } | Should -Throw 
    }
    It ' Throws an error when an invalid input unit is provided' {
        { TemperatureConverter -InputUnit 'TEST' } | Should -Throw 
    }
}


Describe 'TemperatureConverter Fahrenheit coversion tests' -tag 'unit' {
    Context ' Fahrenheit to Fahrenheit' {
        It ' Convert 1 degree Fahrenheit to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 1 -InputUnit 'Fahrenheit' | Should -Be 1
        }
    }
    Context ' Celsius to Fahrenheit' {
        It ' Convert 1 degree Celsius to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 1 -InputUnit 'Celsius' | Should -Be 33.8
        }
        It ' Convert 11.1 degrees Celsius to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 11.1 -InputUnit 'Celsius' | Should -Be 51.98
        }
        It ' Convert 10000000000001 degrees Celsius to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 10000000000001 -InputUnit 'Celsius' | Should -Be 18000000000033.8
        }
        It ' Convert -1 degree Celsius to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -1 -InputUnit 'Celsius' | Should -Be 30.2
        }
        It ' Convert -11.1 degree Celsius to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -11.1 -InputUnit 'Celsius' | Should -Be 12.02
        }
        It ' Convert -10000000000001 degrees Celsius to Fahrenheit' {
            (TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -10000000000001 -InputUnit 'Celsius').ToString() | Should -Be '-17999999999969.8'
        }
    }
        
    Context ' Kelvin to Fahrenheit' {
        It ' Convert 1 degree Kelvin to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 1 -InputUnit 'Kelvin' | Should -Be -457.87
        }
        It ' Convert 11.1 degrees Kelvin to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 11.1 -InputUnit 'Kelvin' | Should -Be -439.69
        }
        It ' Convert 10000000000001 degrees Kelvin to Fahrenheit' {
            (TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 10000000000001 -InputUnit 'Kelvin').ToString() | Should -Be '17999999999542.13'
        }
        It ' Convert -1 degree Kelvin to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -1 -InputUnit 'Kelvin' | Should -Be -461.47
        }
        It ' Convert -11.1 degree Kelvin to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -11.1 -InputUnit 'Kelvin' | Should -Be -479.65
        }
        It ' Convert -10000000000001 degrees Kelvin to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -10000000000001 -InputUnit 'Kelvin' | Should -Be -18000000000461.47
        }
    }

    Context ' Rakine to Fahrenheit' {
        It ' Convert 1 degree Rankine to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 1 -InputUnit 'Rankine' | Should -Be -458.67
        }
        It ' Convert 11.1 degrees Rankine to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 11.1 -InputUnit 'Rankine' | Should -Be -448.57
        }
        It ' Convert 10000000000001 degrees Rankine to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue 10000000000001 -InputUnit 'Rankine' | Should -Be '9999999999541.33'
        }
        It ' Convert -1 degree Rankine to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -1 -InputUnit 'Rankine' | Should -Be -460.67
        }
        It ' Convert -11.1 degree Rankine to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -11.1 -InputUnit 'Rankine' | Should -Be -470.77
        }
        It ' Convert -10000000000001 degrees Rankine to Fahrenheit' {
            TemperatureConverter -OutputUnit 'Fahrenheit' -InputValue -10000000000001 -InputUnit 'Rankine' | Should -Be -10000000000460.67
        }
    }
}

Describe 'TemperatureConverter Celsius coversion tests' -tag 'unit' {
    Context ' Celsius to Celsius' {
        It ' Convert 1 degree Celsius to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 1 -InputUnit 'Celsius' | Should -Be 1
        }
    }
    Context ' Fahrenheit to Celsius' {
        It ' Convert 1 degree Fahrenheit to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 1 -InputUnit 'Fahrenheit' | Should -Be -17.222222222222222222222222222
        }
        It ' Convert 11.1 degrees Fahrenheit to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 11.1 -InputUnit 'Fahrenheit' | Should -Be -11.611111111111111111111111111
        }
        It ' Convert 10000000000001 degrees Fahrenheit to Celsius' {
        (TemperatureConverter -OutputUnit 'Celsius' -InputValue 10000000000001 -InputUnit 'Fahrenheit').ToString() | Should -Be '5555555555538.3333333333333333'
        }
        It ' Convert -1 degree Fahrenheit to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -1 -InputUnit 'Fahrenheit' | Should -Be -18.333333333333333333333333333
        }
        It ' Convert -11.1 degree Fahrenheit to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -11.1 -InputUnit 'Fahrenheit' | Should -Be -23.944444444444444444444444444
        }
        It ' Convert -10000000000001 degrees Fahrenheit to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -10000000000001 -InputUnit 'Fahrenheit' | Should -Be -5555555555573.8888888888888889
        }
    }    
    Context ' Kelvin to Celsius' {
        It ' Convert 1 degree Kelvin to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 1 -InputUnit 'Kelvin' | Should -Be -272.15
        }
        It ' Convert 11.1 degrees Kelvin to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 11.1 -InputUnit 'Kelvin' | Should -Be -262.05
        }
        It ' Convert 10000000000001 degrees Kelvin to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 10000000000001 -InputUnit 'Kelvin' | Should -Be '9999999999727.85'
        }
        It ' Convert -1 degree Kelvin to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -1 -InputUnit 'Kelvin' | Should -Be -274.15
        }
        It ' Convert -11.1 degree Kelvin to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -11.1 -InputUnit 'Kelvin' | Should -Be -284.25
        }
        It ' Convert -10000000000001 degrees Kelvin to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -10000000000001 -InputUnit 'Kelvin' | Should -Be -10000000000274.15
        }
    }    
    Context ' Rankine to Celsius' {
        It ' Convert 1 degree Rankine to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 1 -InputUnit 'Rankine' | Should -Be -272.59444444444444444444444444
        }
        It ' Convert 11.1 degrees Rankine to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue 11.1 -InputUnit 'Rankine' | Should -Be -266.98333333333333333333333333
        }
        It ' Convert 10000000000001 degrees Rankine to Celsius' {
        (TemperatureConverter -OutputUnit 'Celsius' -InputValue 10000000000001 -InputUnit 'Rankine').ToString() | Should -Be '5555555555282.9611111111111111'
        }
        It ' Convert -1 degree Rankine to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -1 -InputUnit 'Rankine' | Should -Be -273.70555555555555555555555556
        }
        It ' Convert -11.1 degree Rankine to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -11.1 -InputUnit 'Rankine' | Should -Be -279.31666666666666666666666667
        }
        It ' Convert -10000000000001 degrees Rankine to Celsius' {
            TemperatureConverter -OutputUnit 'Celsius' -InputValue -10000000000001 -InputUnit 'Rankine' | Should -Be -5555555555829.2611111111111111
        }
    }
}

Describe 'TemperatureConverter Kelvin coversion tests' -tag 'unit' {
    Context ' Kelvin to Kelvin' {
        It ' Convert 1 degree Kelvin to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue 1 -InputUnit 'Kelvin' | Should -Be 1
        }
    }
    Context ' Fahrenheit to Kelvin' {
        It ' Convert 1 degree Fahrenheit to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 1 -InputUnit 'Fahrenheit').ToString() | Should -Be '255.92777777777777777777777778'
        }
        It ' Convert 11.1 degrees Fahrenheit to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 11.1 -InputUnit 'Fahrenheit').ToString() | Should -Be '261.53888888888888888888888889'
        }
        It ' Convert 10000000000001 degrees Fahrenheit to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 10000000000001 -InputUnit 'Fahrenheit').ToString() | Should -Be '5555555555811.4833333333333333'
        }
        It ' Convert -1 degree Fahrenheit to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue -1 -InputUnit 'Fahrenheit'.ToString()) | Should -Be '254.81666666666666666666666667'
        }
        It ' Convert -11.1 degree Fahrenheit to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue -11.1 -InputUnit 'Fahrenheit').ToString() | Should -Be '249.20555555555555555555555556'
        }
        It ' Convert -10000000000001 degrees Fahrenheit to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -10000000000001 -InputUnit 'Fahrenheit' | Should -Be -5555555555300.7388888888888889
        }
    }    
    Context ' Celsius to Kelvin' {
        It ' Convert 1 degree Celsius to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue 1 -InputUnit 'Celsius' | Should -Be 274.15
        }
        It ' Convert 11.1 degrees Celsius to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue 11.1 -InputUnit 'Celsius' | Should -Be 284.25
        }
        It ' Convert 10000000000001 degrees Celsius to Kelvin' {
            (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 10000000000001 -InputUnit 'Celsius').ToString() | Should -Be '10000000000274.15'
        }
        It ' Convert -1 degree Celsius to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -1 -InputUnit 'Celsius' | Should -Be 272.15
        }
        It ' Convert -11.1 degree Celsius to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -11.1 -InputUnit 'Celsius' | Should -Be 262.05
        }
        It ' Convert -10000000000001 degrees Celsius to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -10000000000001 -InputUnit 'Celsius' | Should -Be -9999999999727.85
        }
    }
    Context ' Rankine to Kelvin' {
        It ' Convert 1 degree Rankine to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 1 -InputUnit 'Rankine').ToString() | Should -Be '0.5555555555555555555555555556'
        }
        It ' Convert 11.1 degrees Rankine to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 11.1 -InputUnit 'Rankine').ToString() | Should -Be '6.1666666666666666666666666667'
        }
        It ' Convert 10000000000001 degrees Rankine to Kelvin' {
        (TemperatureConverter -OutputUnit 'Kelvin' -InputValue 10000000000001 -InputUnit 'Rankine').ToString() | Should -Be '5555555555556.1111111111111111'
        }
        It ' Convert -1 degree Rankine to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -1 -InputUnit 'Rankine' | Should -Be -0.5555555555555555555555555556
        }
        It ' Convert -11.1 degree Rankine to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -11.1 -InputUnit 'Rankine' | Should -Be -6.1666666666666666666666666667
        }
        It ' Convert -10000000000001 degrees Rankine to Kelvin' {
            TemperatureConverter -OutputUnit 'Kelvin' -InputValue -10000000000001 -InputUnit 'Rankine' | Should -Be -5555555555556.1111111111111111
        }
    } 
}

Describe 'TemperatureConverter Rankine coversion tests' -tag 'unit' {
    Context ' Rankine to Rankine' {
        It ' Convert 1 degree Rankine to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 1 -InputUnit 'Rankine' | Should -Be 1
        }
    }
    Context ' Fahrenheit to Rankine' {
        It ' Convert 1 degree Fahrenheit to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 1 -InputUnit 'Fahrenheit' | Should -Be 460.67
        }
        It ' Convert 11.1 degrees Fahrenheit to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 11.1 -InputUnit 'Fahrenheit' | Should -Be 470.77
        }
        It ' Convert 10000000000001 degrees Fahrenheit to Rankine' {
            (TemperatureConverter -OutputUnit 'Rankine' -InputValue 10000000000001 -InputUnit 'Fahrenheit').ToString() | Should -Be '10000000000460.67'
        }
        It ' Convert -1 degree Fahrenheit to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -1 -InputUnit 'Fahrenheit' | Should -Be 458.67
        }
        It ' Convert -11.1 degree Fahrenheit to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -11.1 -InputUnit 'Fahrenheit' | Should -Be 448.57
        }
        It ' Convert -10000000000001 degrees Fahrenheit to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -10000000000001 -InputUnit 'Fahrenheit' | Should -Be -9999999999541.33
        }
    }    
    Context ' Celsius to Rankine' {
        It ' Convert 1 degree Celsius to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 1 -InputUnit 'Celsius' | Should -Be 493.470
        }
        It ' Convert 11.1 degrees Celsius to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 11.1 -InputUnit 'Celsius' | Should -Be 511.650
        }
        It ' Convert 10000000000001 degrees Celsius to Rankine' {
            (TemperatureConverter -OutputUnit 'Rankine' -InputValue 10000000000001 -InputUnit 'Celsius').ToString() | Should -Be '18000000000493.470'
        }
        It ' Convert -1 degree Celsius to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -1 -InputUnit 'Celsius' | Should -Be 489.870
        }
        It ' Convert -11.1 degree Celsius to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -11.1 -InputUnit 'Celsius' | Should -Be 471.690
        }
        It ' Convert -10000000000001 degrees Celsius to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -10000000000001 -InputUnit 'Celsius' | Should -Be -17999999999510.130
        }
    }    
    Context ' Kelvin to Rankine' {
        It ' Convert 1 degree Kelvin to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 1 -InputUnit 'Kelvin' | Should -Be 1.8
        }
        It ' Convert 11.1 degrees Kelvin to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 11.1 -InputUnit 'Kelvin' | Should -Be 19.98
        }
        It ' Convert 10000000000001 degrees Kelvin to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue 10000000000001 -InputUnit 'Kelvin' | Should -Be 18000000000001.8
        }
        It ' Convert -1 degree Kelvin to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -1 -InputUnit 'Kelvin' | Should -Be -1.8
        }
        It ' Convert -11.1 degree Kelvin to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -11.1 -InputUnit 'Kelvin' | Should -Be -19.98
        }
        It ' Convert -10000000000001 degrees Kelvin to Rankine' {
            TemperatureConverter -OutputUnit 'Rankine' -InputValue -10000000000001 -InputUnit 'Kelvin' | Should -Be -18000000000001.8
        }
    }
}

