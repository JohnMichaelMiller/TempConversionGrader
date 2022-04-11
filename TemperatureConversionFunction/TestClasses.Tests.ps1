BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    . ./TemperatureConversionFunction/TestClasses.ps1
}

Describe 'tests of classes used by other tests' -tag 'unit' {
    It ' Instantiate the Query class, passing Output Unit, Input Value, and Input Unit (Celsius,1,Fahrenheit)' {
        [Query]$Query = [Query]::new('Celsius',1,'Fahrenheit')
        $Query.OutputUnit | Should -Be 'Celsius'
        $Query.InputValue | Should -Be 1
        $Query.InputUnit | Should -Be 'Fahrenheit'
    }
    It ' Instantiate the Query class, passing Output Unit and Input Value (Celsius,1)' {
        [Query]$Query = [Query]::new('Celsius',1)
        $Query.OutputUnit | Should -Be 'Celsius'
        $Query.InputValue | Should -Be 1
        $Query.InputUnit | Should -Be ''
    }

    It ' Instantiate the Query class, passing Output Unit (Celsius)' {
        [Query]$Query = [Query]::new('Celsius')
        $Query.OutputUnit | Should -Be 'Celsius'
        $Query.InputValue | Should -Be 0
        $Query.InputUnit | Should -Be ''
    }

    It ' Instantiate the Query class, passing no parameters' {
        [Query]$Query = [Query]::new()
        $Query.InputValue = 1
        $Query.OutputUnit | Should -Be ''
        $Query.InputValue | Should -Be 1
        $Query.InputUnit | Should -Be ''
    }

    It ' Instantiate the Query class, passing Output Unit, Input Value, and Input Unit (Kelvin,1,Fahrenheit)' {
        [Request]$Request = [Request]::new('Kelvin',1,'Fahrenheit')
        $Request.Query.OutputUnit | Should -Be 'Kelvin'
        $Request.Query.InputValue | Should -Be 1
        $Request.Query.InputUnit | Should -Be 'Fahrenheit'
    }
    It ' Instantiate the Query class, passing Output Unit and Input Value (Kelvin,1)' {
        [Request]$Request = [Request]::new('Kelvin',1)
        $Request.Query.OutputUnit | Should -Be 'Kelvin'
        $Request.Query.InputValue | Should -Be 1
        $Request.Query.InputUnit | Should -Be ''
    }

    It ' Instantiate the Query class, passing Output Unit (Kelvin)' {
        [Request]$Request = [Request]::new('Kelvin')
        $Request.Query.OutputUnit | Should -Be 'Kelvin'
        $Request.Query.InputValue | Should -Be 0
        $Request.Query.InputUnit | Should -Be ''
    }

    It ' Instantiate the HttpResponseContext class' {
        [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new()
        $HttpResponseContext | Should -Not -Be $null
    }
    It ' Instantiate the HttpStatusCode class an test the OK status code' {
        [HttpStatusCode]::OK | Should -Be 200
    }
    It ' Instantiate the HttpStatusCode class an test the InternalServerError status code' {
        [HttpStatusCode]::InternalServerError | Should -Be 500
    }
    It ' Instantiate the Response class' {
        [Response]$Response = [Response]::new()
        $Response.StatusCode = [HttpStatusCode]::OK
        $Response.Body = "Response Body Test"
        $Response.StatusCode | Should -Be 200
        $Response.Body | Should -Be "Response Body Test"
    }
}