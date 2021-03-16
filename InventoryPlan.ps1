$csvPath = "InventoryPlan.csv"
$headers = '#Location','Item Name','Bucket Start','Beg On Hand','End On Hand','Dependent Demand','Independent Demand','Released','Unreleased','Start Safety Stock','End Safety Stock'
$csvData = (Get-Content -Path $csvPath) | Select-Object -Skip 1 | ConvertFrom-Csv -Header $headers
$csvData | ForEach-Object {

    # convert US date to AU date
	$date, $time = $_.'Bucket Start'.Split(" ")
	$_.'Bucket Start' = $date

    $year, $month, $day = $_.'Bucket Start'.Split("-")

    if ($day -and $month) {
        $_.'Bucket Start' = $day+"/"+$month+"/"+$year+" "+$time
    } else {
        $_.'Bucket Start' = $date
    }
    
    
}

echo $csvData