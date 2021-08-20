
do
{
 $test = (Test-NetConnection www.google.com)

}
while ($test.PingSucceeded -eq $False)

#Set Execution Policy to allow script to run
Set-ExecutionPolicy Bypass -Scope Process -Force
#Set PowerShel to use TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

#Choco install and Choco Apps
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install googlechrome -y
choco install putty -y
choco install winscp -y
choco install sysinternals -y
choco install bginfo -y
choco install powershell-core =y

#Setup and Partition Data Disk
Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'Data' -Confirm:$false
#Allow Ping
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" -enabled True
#Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv6-In)" -enabled True
#Install Roles
Install-WindowsFeature -Name Web-Ftp-Server -IncludeAllSubFeature -IncludeManagementTools
