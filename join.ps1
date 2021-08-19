# Windows PowerShell script for AD DS Deployment

[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $DomainPass,
    [Parameter()]
    [String]
    $DomainFQDN,
    [Parameter()]
    [String]
    $DomainUserName,
    [Parameter()]
    [String]
    $DomainController
)
$MSSvrLog = "C:\MSSvrLog.txt"

IF (Test-path $MSSvrLog)
{Write-host "Log file exits"} 
else
 { 
 Write-host "Creating log file"
 New-Item $MSSvrLog 
 }
 
Add-content $MSSvrLog "Write parameters coming from the script $($DomainPass), $($DomainFQDN), $($DomainUserName), $($DomainController), at the following date/time  $(Get-Date)"

$User = "$($DomainFQDN)\$($DomainUserName)"
$DomainNB = $DomainFQDN.Split(".")[0]
$password = ConvertTo-SecureString "$($DomainPass)" -AsPlainText -Force
$credental = New-Object System.Management.Automation.PSCredential $User,$password

Add-content $MSSvrLog "Write parameters updated with in the script $($DomainNB), $($password), $($credental), $($User),  at the following date/time  $(Get-Date)"

Import-Module ADDSDeployment

do
{
 $test = (Test-NetConnection -ComputerName "$($DomainFQDN)")

}
while ($test.PingSucceeded -eq $False)

#Add-Computer -DomainName $DomainFQDN -Credential $credental -Restart

Install-ADDSDomainController `
-NoGlobalCatalog:$True `
-CreateDnsDelegation:$false `
-Credential:$credental `
-CriticalReplicationOnly:$false `
-DatabasePath "E:\Data" `
-DomainName:$DomainFQDN `
-InstallDns:$true `
-LogPath "E:\Logs" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "E:\SYSVOL" `
-SafeModeAdministratorPassword:$password `
-Force:$true
