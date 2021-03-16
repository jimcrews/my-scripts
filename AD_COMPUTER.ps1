#####################################
## Gets a list of computers from AD.
## This returns as JSON string
#####################################

Import-Module ActiveDirectory

$objForest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

$domains = @($objForest.Domains | Select-Object Name)

$array = @()

foreach ($domain in $domains) {
    $results = @(Get-ADComputer -Properties * -Filter {enabled -eq $true} -Server $domain.Name | Select-Object -Property DNSHostName,Enabled,DistinguishedName,Name,ObjectClass,ObjectGuid,CanonicalName,CN,Created,Deleted,Description,DisplayName,IPv4Address,IPv6Address,isCriticalSystemObject,LastLogonDate,LastLogonTimestamp,localPolicyFlags,Location,LockedOut,ManagedBy,Modified,ObjectCategory,OperatingSystem,OperatingSystemHotfix,OperatingSystemServicePack,OperatingSystemVersion,PasswordExpired,PasswordNeverExpires,PasswordNotRequired,PrimaryGroup,primaryGroupID,pwdLastSet,SAMAccountType,SDRightsEffective,TrustedForDelegation,TrustedToAuthForDelegation,UseDESKeyOnly,UserAccountControl,uSNCHanged,uSNCreated,whenChanged,whenCreated)
    $array += $results
}
$array | ConvertTo-Json