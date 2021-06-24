# Windows PowerShell script for AD DS Deployment

[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $DomainPass,
    [Parameter()]
    [String]
    $DomainFQDN
    [Parameter()]
    [String]
    $DomainUserName
)

$DomainNB = $DomainFQDN.Split(".")[0]
$password = ConvertTo-SecureString $DomainPass -AsPlainText -Force
$credental = New-Object System.Management.Automation.PSCredential($DomainUserName,$password)
Add-Computer -DomainName $DomainFQDN -Credential $credental


#Install-ADDSDomainController'
#-NoGlobalCatalog:$false
#-CreateDnsDelegation:$false
#-CriticalReplicationOnly:$false
#-DatabasePath "E:\windows\NTDS"
#-DomainName “harmikbatth.lab”
#-InstallDns:$true
#-LogPath "E:\windows\NTDS"
#-NoRebootOnCompletion:$false
#-SiteName “Default-First-Site-Name”
#-SysvolPath "E:\windows\SYSVOL"
#-Force:$true
