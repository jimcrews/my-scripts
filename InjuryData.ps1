﻿$csvPath = "InjuryData.csv"
$headers = 'SITE','DEPARTMENT','INJURY_NO','INCIDENT_NO','INJURY_DETAILS','INJURED_PERSON','INJURED_PERSON_SURNAME','DATE_REPORT','INJURY_DATE','DATE_REV','INJURY_TYPE','INJURED_PERSON_TYPE','LOCATION_ON_BODY','MECHANISM','NATURE','INJURY_TIME','FIRST_AID','BUSINESS_RELATED'
$csvData = (Get-Content -Path $csvPath) | Select-Object -Skip 1 | ConvertFrom-Csv -Header $headers
$csvData