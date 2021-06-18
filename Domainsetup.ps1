[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $DomainPass,
    [Parameter()]
    [String]
    $DomainFQDN
)
start-sleep -Seconds 180
$DomainNB = $DomainFQDN.Split(".")[0]
$password = ConvertTo-SecureString $DomainPass -AsPlainText -Force
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "E:\windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName $DomainFQDN `
-DomainNetbiosName $DomainNB `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "E:\windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "E:\windows\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword: $password
