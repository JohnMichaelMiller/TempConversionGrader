<# .SYNOPSIS #>
# Converts temparatures from one unit to another. 

function TemperatureConverter {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet('Fahrenheit', 'Celsius', 'Kelvin', 'Rankine')]
        [string]
        $OutputUnit # Valid output units are Fahrenheit, Celsius, Kelvin, and Rankine."
        , [Parameter()]
        [ValidateNotNullOrEmpty()]
        [decimal]
        $InputValue # The input value is any real number.
        , [Parameter()]
        [ValidateSet('Fahrenheit', 'Celsius', 'Kelvin', 'Rankine')]
        [string]
        $InputUnit = 'Fahrenheit' # Valid input units are Fahrenheit, Celsius, Kelvin, and Rankine. The default is Fahrenheit.
    )
    
    Write-Verbose "Output Unit is $OutputUnit"
    Write-Verbose "Input Unit is $InputUnit"
    Write-Verbose "Input Value is $InputValue"
    
    [decimal] $Fahrenheit = 0
    [decimal] $Celsius = 0
    [decimal] $Kelvin = 0 
    [decimal] $Rankine = 0
    
    $InputUnit = $InputUnit.ToLower()
    $OutputUnit = $OutputUnit.ToLower()

    switch ($InputUnit) {
        'fahrenheit' { $Fahrenheit = $InputValue }
        'celsius' { $Celsius = $InputValue }
        'kelvin' { $Kelvin = $InputValue }
        'rankine' { $Rankine = $InputValue }
    }
    
    switch ($OutputUnit) {
        'fahrenheit' {
            switch ($InputUnit) {
                'fahrenheit' {}
                'celsius' { 
                    # Fahrenheit (°F) = (Celsius x 1.8) + 32
                    $Fahrenheit = ($Celsius * 1.8) + 32
                }
                'kelvin' { 
                    # Fahrenheit (°F) = Kelvin x 1.8 - 459.67
                    $Fahrenheit = $Kelvin * 1.8 - 459.67
                }
                'rankine' { 
                    # Fahrenheit (°F) = Rankine - 459.67
                    $Fahrenheit = $Rankine - 459.67
                }
            }
        }
    
        'celsius' {
            switch ($InputUnit) {
                'fahrenheit' { 
                    # Celsius (°C) = (Fahrenheit - 32) / 1.8
                    $Celsius = ($Fahrenheit - 32) / 1.8
                }
                'celsius' {}
                'kelvin' { 
                    # Celsius (°C) = Kelvin - 273.15
                    $Celsius = $Kelvin - 273.15
                }
                'rankine' { 
                    # Celsius (°C) = (Rankine - 491.67) / 1.8
                    $Celsius = ($Rankine - 491.67) / 1.8
                }
            }
        }
    
        'kelvin' {
            switch ($InputUnit) {
                'fahrenheit' { 
                    # Kelvin (K) = (Fahrenheit - 32) / 1.8 + 273.15
                    $Kelvin = ($Fahrenheit - 32) / 1.8 + 273.15
                }
                'celsius' { 
                    # Kelvin (K) = Celsius + 273.15
                    $Kelvin = $Celsius + 273.15
                }
                'kelvin' {}
                'rankine' { 
                    # Kelvin (K) = Rankine / 1.8
                    $Kelvin = $Rankine / 1.8            
                }
            }
        }
    
        'rankine' {
            switch ($InputUnit) {
                'fahrenheit' { 
                    # Rankine (°R) = Fahrenheit + 459.67
                    $Rankine = $Fahrenheit + 459.67
                }
                'celsius' { 
                    # Rankine (°R) = (Celsius + 273.15) x 1.8
                    $Rankine = ($Celsius + 273.15) * 1.8
                }
                'kelvin' { 
                    # Rankine (°R) = Kelvin x 1.8
                    $Rankine = $Kelvin * 1.8
                }
                'rankine' {}
            }
        }
    }
    
    switch ($OutputUnit) {
        'fahrenheit' { return $Fahrenheit }
        'celsius' { return $Celsius }
        'kelvin' { return $Kelvin }
        'rankine' { return $Rankine }
    }
}
