class Query {
    [string]$OutputUnit = ''
    [string]$InputValue = '0'
    [string]$InputUnit = ''
    [string]$StudentValue = '0'
    
    Query(
        [string]$OU,
        [string]$IV,
        [string]$IU,
        [string]$SV
    ) {
        $this.OutputUnit = $OU
        $this.InputValue = $IV
        $this.StudentValue = $SV
        $this.InputUnit = $IU
    }
    Query(
        [string]$OU,
        [string]$IV,
        [string]$IU
    ) {
        $this.OutputUnit = $OU
        $this.InputValue = $IV
        $this.InputUnit = $IU
    }
    Query(
        [string]$OU,
        [string]$IV
    ) {
        $this.OutputUnit = $OU
        $this.InputValue = $IV
        $this.InputUnit = ''
    }
    Query(
        [string]$OU
    ) {
        $this.OutputUnit = $OU
        $this.InputValue = 0
        $this.InputUnit = ''
    }
    Query(
    ) {
        $this.OutputUnit = ''
        $this.InputValue = 0
        $this.InputUnit = ''
    }
}


class Request {
    [Query]$Query

    Request(
        [string]$OU,
        [string]$IV,
        [string]$IU,
        [string]$SV
    ) {
        $this.Query = [Query]::new($OU, $IV, $IU, $SV)
    }
    Request(
        [string]$OU,
        [string]$IV,
        [string]$IU
    ) {
        $this.Query = [Query]::new($OU, $IV, $IU)
    }
    Request(
        [string]$OU,
        [string]$IV
    ) {
        $this.Query = [Query]::new($OU, $IV)
    }
    Request(
        [string]$OU
    ) {
        $this.Query = [Query]::new($OU)
    }
    Request(
    ) {
        $this.Query = [Query]::new()
    }
}

#TD: -1 This class is redundant with a class in the TemperatureConverter function. Eliminate the redundancy by creating a common test class folder or by creating a common module.
class HttpResponseContext {
    [int]$StatusCode = [HttpStatusCode]::OK
    [string]$Body = $null
    [string]$StatusDescription = 'OK'
    [string]$Content = $null
    HttpResponseContext(){}
    HttpResponseContext(
        [string]$StatusCode,
        [string]$Body,
        [string]$StatusDescription,
        [string]$Content
    ) {
        $this.StatusCode = $StatusCode
        $this.Body = $Body
        $this.StatusDescription = $StatusDescription
        $this.Content = $Content
    }
}

#TD: -1 This class is redundant with a class in the TemperatureConverter function. Eliminate the redundancy by creating a common test class folder or by creating a common module.
class HttpStatusCode {
    static [int]$OK = 200
    static [int]$InternalServerError = 500
}

#TD: -1 This class is redundant with a class in the TemperatureConverter function. Eliminate the redundancy by creating a common test class folder or by creating a common module.
class Response {
    [HttpResponseContext] hidden $HttpResponseContext
    [int]$StatusCode
    [string]$Body
    [string]$StatusDescription
    [string]$Content
    Response(){}
    Response(
        [HttpStatusCode]$StatusCode,
        [string]$Body,
        [string]$StatusDescription,
        [string]$Content
    ) {
        $this.Response = [HttpResponseContext]::new($StatusCode, $Body, $StatusDescription, $Content)            
    }
    Response(
        [HttpResponseContext]$HttpResponseContext
    ) {
        $this.HttpResponseContext = $HttpResponseContext
        $this.StatusCode = $HttpResponseContext.StatusCode
        $this.Body = $HttpResponseContext.Body
        $this.StatusDescription = $HttpResponseContext.StatusDescription
        $this.Content = $HttpResponseContext.Content
    }
}

#TD: -1 This function is redundant with a function in the TemperatureConverter test classes. Eliminate the redundancy by creating a common test class folder or by creating a common module.
Function Push-OutputBinding {}