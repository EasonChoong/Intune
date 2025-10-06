Set-ExecutionPolicy -ExecutionPolicy Bypass
$WinGetModule =  Get-Module Microsoft.WinGet.Client -ListAvailable  -ErrorAction SilentlyContinue

if($WinGetModule -eq $null){
Install-Module -Name Microsoft.WinGet.Client
Import-Module -Name Microsoft.WinGet.Client
}
$updateCount=(get-wingetPackage | where IsUpdateAvailable).count
if($updateCount -ge 1){
write-host "$updateCount update(s) available. Proceed to update"
exit 1
}else{
Write-Host "No upgrade available."
exit 0
}

<#
$winUp = (winget list --upgrade-available)
if($winUp[-1][0] -gt 0){
Write-Host "Upgrade available. Proceed to upgrade apps"
exit 0
}else{
Write-Host "No upgrade available."
exit 1
}
#>
Set-ExecutionPolicy -ExecutionPolicy Default