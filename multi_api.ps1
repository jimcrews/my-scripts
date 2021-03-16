############################################################
#
# Gets data from Analytics servers
#
# exportType: Must be valid key in exportTypes dictionary
# top: optional row limit
############################################################
param([string]$exportType="ProductByCrew", [Int32]$top=1000000)

[Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'
$SecretApi = "https://safe.server.local/winauthwebservices/api/v1"
$endpoint = "$SecretApi/secrets/291"
$secret = Invoke-RestMethod $endpoint -UseDefaultCredentials
$password = $secret.Items.itemValue[2]
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('user123', $securePassword)

Set-Location -Path $PSScriptRoot

# Analytics provides a number of reports for the prodution line sensors
# The data is fetched from 'web services' hosted internally.
# The urls follow a similar pattern for each line.

# Each type of data download is a different url:
$exportTypes = @{
    ProductByCrew = 'http://user123:'+$password+'@$server/$line/server/export/productByCrew?start=day-14&strictStart=true&groupBy=jobByShift&columns=WorkcentreId,WorkcentreName,StartTime,EndTime,DurationSeconds,ShiftEvents,JobEvents,CrewId,CrewName,CrewSortIndex,UserId,UserName,OrderId,OrderQuantity,SKUId,SKUDescription,SpanId,SpanType,JobSpanId,ShiftSpanId,OpenUnitsIn,ProductionUnitsIn,RunUnitsIn,UnitsIn,UnitsOut,UnitsRated,UnitsNamePlate,SetupUnitsIn,ShiftSeconds,OpenSeconds,ProductionSeconds,SetupSeconds,SetupEvents,UnplannedDowntimeSeconds,UnplannedDowntimeEvents,PlannedDowntimeSeconds,PlannedDowntimeEvents,ShortStopSeconds,ShortStopEvents,RunSlowSeconds,RunSlowEvents,RunSeconds,RunEvents,RunSpeed,ProductionSpeed,OpenSpeed,OEE,AVA,PE,Quality&tsv=true';
    LineByCrew = 'http://user123:'+$password+'@$server/$line/server/export/lineByCrew?start=day-14&groupBy=shift&columns=WorkcentreId,WorkcentreName,StartTime,EndTime,DurationSeconds,ShiftEvents,JobEvents,CrewId,CrewName,CrewSortIndex,UserId,UserName,SpanId,SpanType,JobSpanId,OpenUnitsIn,ProductionUnitsIn,RunUnitsIn,UnitsIn,UnitsOut,UnitsRated,UnitsNamePlate,SetupUnitsIn,ShiftSeconds,OpenSeconds,ProductionSeconds,SetupSeconds,SetupEvents,UnplannedDowntimeSeconds,UnplannedDowntimeEvents,PlannedDowntimeSeconds,PlannedDowntimeEvents,ShortStopSeconds,ShortStopEvents,RunSlowSeconds,RunSlowEvents,RunSeconds,RunEvents,RunSpeed,ProductionSpeed,OpenSpeed,OEE,AVA,PE,Quality,Counter_through,Counter_through.unadjusted,Counter_out,Counter_out.unadjusted,Counter_rated&tsv=true';
    Events = 'http://user123:'+$password+'@$server/$line/server/export/events?start=day-14&strictStart=true&groupBy=shift&columns=WorkcentreId,WorkcentreName,StartTime,EndTime,DurationSeconds,CrewId,CrewName,CrewSortIndex,UserId,UserName,OrderId,OrderQuantity,SKUId,SKUDescription,SpanId,SpanType,SpanClass,JobSpanId,ShiftSpanId,UnitsIn,UnitsOut,UnitsRated,ReasonId,ReasonDescription,ReasonCategory&tsv=true';
    Comments = 'http://user123:'+$password+'@$server/$line/server/export/comments?start=day-14&strictStart=true&groupBy=shift&columns=WorkcentreId,WorkcentreName,StartTime,EndTime,DurationSeconds,CrewId,CrewName,CrewSortIndex,UserId,UserName,OrderId,OrderQuantity,SKUId,SKUDescription,SpanId,SpanType,SpanClass,JobSpanId,ShiftSpanId,UnitsIn,UnitsOut,UnitsRated,ReasonId,ReasonDescription,ReasonCategory,PostId,PostFromOFSX,PostSubject,PostCommentId,PostCommentDate,PostCommentAuthor,PostCommentText&tsv=true'
    Product = 'http://$server/$line/server/export/product?start=day-14&groupBy=job&columns=WorkcentreId,WorkcentreName,StartTime,EndTime,DurationSeconds,SKUId,SKUDescription,UnitsIn,UnitsOut&tsv=true'
    OEE = 'http://user123:'+$password+'@$server/$line/server/export/events?start=day-14&groupBy=hour&columns=WorkcentreName,StartTime,EndTime,DurationSeconds,OEE,Quality&tsv=true'
    Line = 'http://user123:'+$password+'@$server/$line/server/export/line?tsv=true&start=day-14&groupBy=hour'
}

# Each line uses potentiall different host
$servers = @{

    SERVER_1 = '192.168.21.21';
    SERVER_2 = '192.168.100.2';
    SERVER_3 = '192.168.100.2';
    SERVER_4 = '192.168.100.2';
    SERVER_5 = '192.168.100.2';
    SERVER_6 = '192.168.100.2';
    SERVER_7 = '192.168.21.21';
}

# The url for each line uses a 'line identifier in the path.
$lines = @{
    SERVER_1 = 'S001';
    SERVER_2 = 'S002';
    SERVER_3 = 'S003';
    SERVER_4 = 'S004';
    SERVER_5 = 'S005';
    SERVER_6 = 'S006';
    SERVER_7 = 'S007';
}

$results = @()

foreach ($key in $lines.Keys) {
    $server = $servers[$key]
    $line = $lines[$key]
    $uri = $exportTypes[$exportType]
    $uri = $ExecutionContext.InvokeCommand.ExpandString($uri)

    # get data
    Invoke-RestMethod -Method Get -Uri $uri -Credential $credential -OutFile 'results.txt' -TimeoutSec 600
    $data = import-Csv -Delimiter "`t" -Path 'results.txt'
    $results += $data
}

$results | ConvertTo-Json -Compress