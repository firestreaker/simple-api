using namespace System.Net

param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

try{
    if (!$request.Headers.Authorization){
        $status = [HttpStatusCode]::Unauthorized
        throw "No credentials found in Authorization header."
    }
    if (!$request.Body){
        throw "No information available to create item."
    }

    #Create item here
    $body = @{}
    $status = [HttpStatusCode]::OK
}
catch{
    $status = $status ?? $_.Exception.Response.StatusCode ?? [HttpStatusCode]::BadRequest
    $body = @{ Error = $_.Exception.Message }
    if ($_.Exception.Response.RequestMessage.RequestUri) { $body.Add("RequestUri", $_.Exception.Response.RequestMessage.RequestUri) }
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
