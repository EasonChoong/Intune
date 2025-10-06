Set-ExecutionPolicy -ExecutionPolicy Bypass

if((get-module PSWindowsUpdate) -eq $null){
    Install-Module -Force PSWindowsUpdate
    Import-Module PSWindowsUpdate
}

PSWindowsUpdate\Install-WindowsUpdate -UpdateType Software -WindowsUpdate -ComputerName (hostname) -AcceptAll -ForceDownload -ForceInstall -IgnoreReboot
Set-ExecutionPolicy -ExecutionPolicy Default