# Windows PowerShell script join machine to domain

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
$User = "$($DomainNB)\$($DomainUserName)"
$password = ConvertTo-SecureString "$($DomainPass)" -AsPlainText -Force
$credental = New-Object System.Management.Automation.PSCredential ($User,$password)

Import-Module ADDSDeployment

do
{
 $test = (Test-NetConnection -ComputerName "$($DomainFQDN)")

}
while ($test.PingSucceeded -eq $False)

Add-Computer -DomainName $DomainFQDN -Credential $credental -Restart

