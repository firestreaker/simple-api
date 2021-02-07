using namespace System.Net

param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

try{
    #List items here
    $body = @()
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
