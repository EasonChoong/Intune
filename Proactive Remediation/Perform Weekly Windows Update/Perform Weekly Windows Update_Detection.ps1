Set-ExecutionPolicy -ExecutionPolicy Bypass
if((get-module PSWindowsUpdate) -eq $null){
    Install-Module -Force PSWindowsUpdate
    Import-Module PSWindowsUpdate
}

if((Get-WindowsUpdate -UpdateType Software -WindowsUpdate )-eq $null){
    exit 0
}else{
    exit 1
}

Set-ExecutionPolicy -ExecutionPolicy Default
