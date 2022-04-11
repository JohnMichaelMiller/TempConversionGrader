BeforeAll {
    # . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    . ./ConversionGraderFunction/TestClasses.ps'1'
}

Describe 'Tests of classes used by other tests' -tag 'unit' {
    Context 'Query Instantiation Tests' {
        It ' Instantiate the Query class, passing Output Unit(Celsius), Input Value(1), Input Unit(Fahrenheit), and Student Value(2)' {
            [Query]$Query = [Query]::new('Celsius', '1', 'Fahrenheit', '2')
            $Query.OutputUnit | Should -Be 'Celsius'
            $Query.InputUnit | Should -Be 'Fahrenheit'
            $Query.InputValue | Should -Be '1'
            $Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Query class, passing Output Unit(dogcow), Input Value(1), Input Unit(Fahrenheit), and Student Value(2)' {
            [Query]$Query = [Query]::new('dogcow', '1', 'Fahrenheit', '2')
            $Query.OutputUnit | Should -Be 'dogcow'
            $Query.InputUnit | Should -Be 'Fahrenheit'
            $Query.InputValue | Should -Be '1'
            $Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Query class, passing Output Unit(Celsius), Input Value(cat), Input Unit(Fahrenheit), and Student Value(2)' {
            [Query]$Query = [Query]::new('Celsius', 'cat', 'Fahrenheit', '2')
            $Query.OutputUnit | Should -Be 'Celsius'
            $Query.InputUnit | Should -Be 'Fahrenheit'
            $Query.InputValue | Should -Be 'cat'
            $Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Query class, passing Output Unit(Celsius), Input Value(1), Input Unit(dogcow), and Student Value(2)' {
            [Query]$Query = [Query]::new('Celsius', '1', 'dogcow', '2')
            $Query.OutputUnit | Should -Be 'Celsius'
            $Query.InputUnit | Should -Be 'dogcow'
            $Query.InputValue | Should -Be '1'
            $Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Query class, passing Output Unit(Celsius), Input Value(1), Input Unit(Fahrenheit), and Student Value(dog)' {
            [Query]$Query = [Query]::new('Celsius', '1', 'Fahrenheit', 'dog')
            $Query.OutputUnit | Should -Be 'Celsius'
            $Query.InputUnit | Should -Be 'Fahrenheit'
            $Query.InputValue | Should -Be '1'
            $Query.StudentValue | Should -Be 'dog'
        } 
    }
    Context 'Request instantiation tests' { 
        It ' Instantiate the Request class, passing Output Unit(Celsius), Input Value(1), Input Unit(Fahrenheit), and Student Value(2)' {
            [Request]$Request = [Request]::new('dogcow', '1', 'Fahrenheit', '2')
            $Request.Query.OutputUnit | Should -Be 'dogcow'
            $Request.Query.InputUnit | Should -Be 'Fahrenheit'
            $Request.Query.InputValue | Should -Be '1'
            $Request.Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Request class, passing Output Unit(dogcow), Input Value(1), Input Unit(Fahrenheit), and Student Value(2)' {
            [Request]$Request = [Request]::new('dogcow', '1', 'Fahrenheit', '2')
            $Request.Query.OutputUnit | Should -Be 'dogcow'
            $Request.Query.InputUnit | Should -Be 'Fahrenheit'
            $Request.Query.InputValue | Should -Be '1'
            $Request.Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Request class, passing Output Unit(Celsius), Input Value(cat), Input Unit(Fahrenheit), and Student Value(2)' {
            [Request]$Request = [Request]::new('Celsius', 'cat', 'Fahrenheit', '2')
            $Request.Query.OutputUnit | Should -Be 'Celsius'
            $Request.Query.InputUnit | Should -Be 'Fahrenheit'
            $Request.Query.InputValue | Should -Be 'cat'
            $Request.Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Request class, passing Output Unit(Celsius), Input Value(1), Input Unit(dogcow), and Student Value(2)' {
            [Request]$Request = [Request]::new('Celsius', '1', 'dogcow', '2')
            $Request.Query.OutputUnit | Should -Be 'Celsius'
            $Request.Query.InputUnit | Should -Be 'dogcow'
            $Request.Query.InputValue | Should -Be '1'
            $Request.Query.StudentValue | Should -Be '2'
        }
        It ' Instantiate the Request class, passing Output Unit(Celsius), Input Value(1), Input Unit(Fahrenheit), and Student Value(dog)' {
            [Request]$Request = [Request]::new('Celsius', '1', 'Fahrenheit', 'dog')
            $Request.Query.OutputUnit | Should -Be 'Celsius'
            $Request.Query.InputUnit | Should -Be 'Fahrenheit'
            $Request.Query.InputValue | Should -Be '1'
            $Request.Query.StudentValue | Should -Be 'dog'
        } 
    }
    Context ' HttpStatusCode instantiation' {
        It ' Instantiate the HttpStatusCode class an test the OK status code' {
            [HttpStatusCode]::OK | Should -Be 200
        }

        It ' Instantiate the HttpStatusCode class an test the InternalServerError status code' {
            [HttpStatusCode]::InternalServerError | Should -Be 500
        }
    }
    Context ' HttpResponseContext instantiation' {
        It ' Instantiate the HttpResponseContext class with the default constructor' {
            [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new()
            $HttpResponseContext | Should -Not -Be $null
            $HttpResponseContext.StatusCode | Should -Be $([HttpStatusCode]::OK)
            $HttpResponseContext.Body | Should -Be ''
            $HttpResponseContext.StatusDescription | Should -Be 'OK'
            $HttpResponseContext.Content | Should -Be ''
        }
        It ' Instantiate the HttpResponseContext class with the customer constructor creating a 200 response' {
            [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new([HttpStatusCode]::OK, 'Response Body Test', 'OK', 'Response Content Test')
            $HttpResponseContext | Should -Not -Be $null
            $HttpResponseContext.StatusCode | Should -Be $([HttpStatusCode]::OK)
            $HttpResponseContext.Body | Should -Be 'Response Body Test'
            $HttpResponseContext.StatusDescription | Should -Be 'OK'
            $HttpResponseContext.Content | Should -Be 'Response Content Test'
        }
        It ' Instantiate the HttpResponseContext class with the customer constructor creating a 500 response' {
            [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new([HttpStatusCode]::InternalServerError, 'Response Body Test', 'OK', 'Exception: A major malfunction has occured!')
            $HttpResponseContext | Should -Not -Be $null
            $HttpResponseContext.StatusCode | Should -Be $([HttpStatusCode]::InternalServerError)
            $HttpResponseContext.Body | Should -Be 'Response Body Test'
            $HttpResponseContext.StatusDescription | Should -Be 'OK'
            $HttpResponseContext.Content | Should -Be 'Exception: A major malfunction has occured!'
        }
    }
    Context ' Response instantiation' {
        It ' Instantiate the Response class using the default constructor' {
            [Response]$Response = [Response]::new()
            $Response | Should -Not -Be $null
            $Response.StatusCode | Should -Be 0
            $Response.Body | Should -Be $null
            $Response.StatusDescription | Should -Be $null
            $Response.Content | Should -Be $null
            # Set properties and retest
            $Response.StatusCode = [HttpStatusCode]::OK
            $Response.Body = 'Response Body Test'
            $Response.StatusDescription = 'OK'
            $Response.Content = 'Response Body Test'
            $Response.StatusCode | Should -Be 200
            $Response.Body | Should -Be 'Response Body Test'
            $Response.StatusDescription | Should -Be 'OK'
            $Response.Content | Should -Be 'Response Body Test'
        } 
        It ' Instantiate the Response class using the HttpResponseContext constructor' {
            [HttpResponseContext]$HttpResponseContext = [HttpResponseContext]::new([HttpStatusCode]::OK, 'Response Body Test', 'OK', 'Response Content Test')
            [Response]$Response = [Response]::new($HttpResponseContext)
            $Response.StatusCode = [HttpStatusCode]::OK
            $Response.Body = 'Response Body Test'
            $StatusDescription = 'OK'
            $Content = 'Response Body Test'
            $Response.StatusCode | Should -Be 200
            $Response.Body | Should -Be 'Response Body Test'
            $StatusDescription | Should -Be 'OK'
            $Content | Should -Be 'Response Body Test'
        } 
        It ' Instantiate the Response class using a custom constructor' {
            [Response]$Response = [Response]::new([HttpStatusCode]::OK, 'Response Body Test', 'OK', 'Response Content Test')
            $Response.StatusCode = [HttpStatusCode]::OK
            $Response.Body = 'Response Body Test'
            $StatusDescription = 'OK'
            $Content = 'Response Body Test'
            $Response.StatusCode | Should -Be 200
            $Response.Body | Should -Be 'Response Body Test'
            $StatusDescription | Should -Be 'OK'
            $Content | Should -Be 'Response Body Test'
        }  -Skip
    }
}