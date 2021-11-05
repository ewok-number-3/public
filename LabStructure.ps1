[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $DomainPass,
    [Parameter()]
    [String]
    $UserNum,
    [Parameter()]
    [String]
    $DomainFQDN   
)
#Setup Variables
$DCRoot = ([ADSI]"").distinguishedName
$DCUSERDNSDOMAIN = $env:USERDNSDOMAIN

$WVDRoot = "OU=UKHO FTP Accounts,$($DCRoot)"
$WVDRoot = "OU=OU=UKHO FTPS Accounts,$($DCRoot)"

#$WVDRoot = "OU=WVD,$($DCRoot)"
$password = ConvertTo-SecureString "$($DomainPass)" -AsPlainText -Force

#Create Root WVD OU
New-ADOrganizationalUnit -Name "UKHO FTP Accounts" -Path "$($DCRoot)" -ProtectedFromAccidentalDeletion $False -Description "FTP"
#Create Other OUs
New-ADOrganizationalUnit -Name "UKHO FTP Users" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "UKHO FTP Users"
New-ADOrganizationalUnit -Name "UKHO FTP Groups" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "UKHO FTP Groups"
#New-ADOrganizationalUnit -Name "Servers" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "WVD Servers"
#New-ADOrganizationalUnit -Name "Session Hosts" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "WVD WVD Session Hosts"

#Create Root WVD OU
New-ADOrganizationalUnit -Name "UKHO FTPS Accounts" -Path "$($DCRoot)" -ProtectedFromAccidentalDeletion $False -Description "FTPS"
#Create Other OUs
New-ADOrganizationalUnit -Name "UKHO FTPS Users" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "UKHO FTPS Users"
New-ADOrganizationalUnit -Name "UKHO FTPS Groups" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "UKHO FTPS Groups"
#New-ADOrganizationalUnit -Name "Servers" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "WVD Servers"
#New-ADOrganizationalUnit -Name "Session Hosts" -Path "$($WVDRoot)" -ProtectedFromAccidentalDeletion $False -Description "WVD WVD Session Hosts"
#Create Student Accounts within Domain
#for ($User = 1; $User -le $UserNum; $User++)
#{
#    $User
#    New-ADUser -Name "Student$($User) Account" -AccountPassword $password -DisplayName "Student$($User) Account" -Enabled $True -Path "OU=Users,$($WVDRoot)" -SamAccountName "Student$($User)" -Surname "Student$($User)" -UserPrincipalName "Student$($User)@$($DCUSERDNSDOMAIN)"    
#}
