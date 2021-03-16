[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'

#
# get credentials from password safe
#
$SecretApi = "https://safe.server.local/winauthwebservices/api/v1"
$endpoint = "$SecretApi/secrets/285"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$password = $secret.Items.itemValue[2]
$cred = '{"password": "' + $password +'","userName": "user_1"}'

#
# get token from the secure API
#
$auth_url = "https://api.server.local/ams/shared/api/security/login"
$result = Invoke-WebRequest -Method POST -ContentType 'application/json' -Uri $auth_url -Body $cred -Headers @{'Accept'='application/json';'x-dell-api-version'=1} -SessionVariable myWebSession
$CSRF = $result.Headers."x-dell-csrf-token"

#
# API params
#
$limit = 100
$offset = 1
$output = @()

DO {

    $url = "https://api.server.local/api/inventory/softwares?shaping=software all&paging=offset $limit limit $offset"
    $results = Invoke-RestMethod -Method GET -Uri $url -ContentType 'application/json' -Headers @{"x-dell-csrf-token"="$CSRF"; Accept="application/json"; "x-dell-api-version"="1"} -WebSession $myWebSession

    foreach ($item in $results.Software) {
        $output += $item
    }

    # Get next page
    $offset = $offset + $limit

} while ($results.Software.Count -gt 0)

$output
