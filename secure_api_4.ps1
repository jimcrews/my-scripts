######################################################
# Gets secure data
######################################################

[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'
$SecretApi = "https://safe.server.local/winauthwebservices/api/v1"
$endpoint = "$SecretApi/secrets/287"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$password = $secret.Items.itemValue[2]


$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$bearer = "Bearer",$password
$header.Add("authorization", $bearer)
$ContentType = 'application/json; charset=utf-8'
$Uri = 'https://webapi.api.com/api/v1/devices/'
        
$results = Invoke-RestMethod -Method Get -Uri $Uri -Headers $header -ContentType $ContentType
$results.devices
