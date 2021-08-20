
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
Import-Module WebAdministration
Start-Sleep -Seconds 60
#create Share and Enable Access-Based enumeration

#Need to create Variables
New-Item -Path f:\ -Name $FTPDir -ItemType Directory
New-SMBShare –Name FTP –Path "F:\FTP" –FullAccess 'Administrators' -ChangeAccess 'Backup Operators' -ReadAccess 'Users'
Get-SmbShare -Name $FTPDir | Set-SmbShare -FolderEnumerationMode AccessBased -Force

#Create website
#New-WebFtpSite -Name $FTPSiteName -Port $FTPPort -PhysicalPath $FTPRootDir -Force -Verbose

