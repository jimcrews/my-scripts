########################################
## Extracts secure data
########################################

param([string]$url="", [Int32]$top=1000000)

[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'
$SecretApi = "https://safe.server.local/winauthwebservices/api/v1"
$endpoint = "$SecretApi/secrets/286"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$password = $secret.Items.itemValue[2]
$endpoint = "$SecretApi/secrets/288"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$clientSecret = $secret.Items.itemValue[2]

$cred = "grant_type=password&username=API&password="+$password+"&client_id=xxxxxxxxx&client_secret="+$clientSecret+"&scope=session-type:Analyst"
$auth_url = 'http://api.server.local/f/Asz.Web/oauth/login'
$result = Invoke-RestMethod -Method Post -Uri $auth_url -Body $cred -ContentType 'application/x-www-form-urlencoded'
$access_token = $result.token_type + ' ' + $result.access_token

$results = Invoke-RestMethod -Method GET -Uri $url -Headers @{"Authorization"=$access_token}
$results.Results

