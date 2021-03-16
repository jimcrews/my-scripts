#####################################
## Gets a list of users from AD.
## This returns as JSON string
#####################################

$objForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

$domains = @($objForest.Domains | Select-Object Name)

$array = @()

foreach ($domain in $domains) {
    $results = @(Get-ADUser -Properties * -Filter {enabled -eq $true} -Server $domain.Name | Select-Object -First 9999 -Property ObjectGuid, GivenName, Surname, UserPrincipalName, Enabled, SamAccountName, SID, DistinguishedName, Name, ObjectClass, AccountExpirationDate, AccountExpires, AccountLockoutTime, BadLogonCount, BadPasswordTime, BadPasswordCount, Country, Created, Deleted, Department, Description, DisplayName,  Division, EmailAddress, EmployeeId, EmployeeNumber, Fax, HomeDirectory, HomeDrive, LastBadPasswordAttempt, LastLogon, LastPasswordSet, Manager, Mobile, Modified, MiddleName, PasswordNeverExpires, PasswordNotRequired, ScriptPath, SmartcardLogonRequired, StructuralObjectClass, UserCannotChangePassword, VoiceTelephoneNumber)
    $array += $results
}
$array | ConvertTo-Json

