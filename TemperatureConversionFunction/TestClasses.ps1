class Query {
    [string]$OutputUnit
    [decimal]$InputValue
    [string]$InputUnit
    
    Query(
        [string]$OU,
        [decimal]$IV,
        [string]$IU
    ) {
        $this.OutputUnit = $OU
        $this.InputValue = $IV
        $this.InputUnit = $IU
    }
    Query(
        [string]$OU,
        [decimal]$IV
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
        [decimal]$IV,
        [string]$IU
    ) {
        $this.Query = [Query]::new($OU, $IV, $IU)
    }
    Request(
        [string]$OU,
        [decimal]$IV
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


class HttpResponseContext {
    [int]$StatusCode
    [string]$Body
 }

class HttpStatusCode {
    static [int]$OK = 200
    static [int]$InternalServerError = 500
}

class Response {
    [int]$StatusCode
    [string]$Body
}

Function Push-OutputBinding{}