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

$DomainNB = $DomainFQDN.Split(".")[0]
$password = ConvertTo-SecureString $DomainPass -AsPlainText -Force
$credental = New-Object System.Management.Automation.PSCredential($DomainUserName,$password)

do
{
 $test = (Test-NetConnection -ComputerName $DomainController)

}
while ($test.PingSucceeded -eq $False)

#Add-Computer -DomainName $DomainFQDN -Credential $credental -Restart

Install-ADDSDomainController'
-NoGlobalCatalog:$True
-CreateDnsDelegation:$false
-Credential:$credental
-CriticalReplicationOnly:$false
-DatabasePath "E:\Data"
-DomainName:$DomainFQDN
-InstallDns:$true
-LogPath "E:\Logs"
-NoRebootOnCompletion:$false
-SiteName “Default-First-Site-Name”
-SysvolPath "E:\SYSVOL"
-Force:$true