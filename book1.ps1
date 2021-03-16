#
# Requires Import-Excel module
# https://www.powershellgallery.com/packages/ImportExcel/7.1.1
#
# Install-Module -Name ImportExcel
#

Import-Module importexcel


$excelPath = "Book1.xlsx"



$data = Import-Excel -Path $excelPath -WorksheetName Data


$data = $data |ForEach-Object {
    if ($_.{Date Changed}) {
        # change date time powershell object to string
        $_.{Date Changed} = $_.{Date Changed}.toString('dd/MM/yyyy')
    }
    $_
}

$data