#winget upgrade --all --silent --disable-interactivity --verbose --accept-package-agreements --accept-source-agreements

Set-ExecutionPolicy -ExecutionPolicy Bypass

$WinGetModule =  Get-Module Microsoft.WinGet.Client -ListAvailable  -ErrorAction SilentlyContinue

if($WinGetModule -eq $null){
Install-Module -Name Microsoft.WinGet.Client
Import-Module -Name Microsoft.WinGet.Client
}

get-wingetPackage | where IsUpdateAvailable | Update-WinGetPackage -Force  -Confirm -Mode Silent -AllowHashMismatch -IncludeUnknown


Set-ExecutionPolicy -ExecutionPolicy Default