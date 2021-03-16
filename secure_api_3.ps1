##################################################
## Gets secure information from API.
##################################################

param([string]$url="", [int]$pageSize=100)

[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'
$SecretApi = "https://safe.server.local/winauthwebservices/api/v1"
$endpoint = "$SecretApi/secrets/293"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$myToken = $secret.Items.itemValue[2]
$endpoint = "$SecretApi/secrets/294"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$myKey = $secret.Items.itemValue[2]

$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$header.Add("authorization", "Basic "+$myToken)
$header.Add("x-api-key", $myKey)
$header.Add("X-Locale", "en")
$header.Add("Accept", "application/json")
$ContentType = 'application/json; charset=utf-8'

$offset = 0
$results = @()
$url = "https://api5.central.api.com/gateway/migration-tool/v1/endpoints"

# API returns data in chunks of 100
while ($true) {
    $Uri = $url + "?offset=$offset"
    $data = Invoke-RestMethod -Method Get -Uri $Uri -ContentType $ContentType -Headers $header
    $results += $data.items
    if ($data.items.count -lt 100) { break }
    $offset += 100
}

$results
