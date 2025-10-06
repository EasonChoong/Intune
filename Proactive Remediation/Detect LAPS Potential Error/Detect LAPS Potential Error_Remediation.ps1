<## Get Windows version and build number
$osVersion = [System.Environment]::OSVersion.Version
$osBuild = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseId).ReleaseId

# Default KB value (change this as needed)


# Display the detected Windows version, build, and assigned KB value
Write-Output "Detected Windows Version: $osVersion"
Write-Output "Detected Windows Build: $osBuild"
Write-Output "Assigned KB Value: $((Get-HotFix).HotfixID)"


Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -FilterXPath "*[System[Level=2]]" | Group-Object -Property Id | ForEach-Object {
    $_.Group | Sort-Object { [DateTime]$_.'TimeCreated' } -Descending | Select-Object -First 1
} | fl

#$targetUpdate = "KB5025221" # Replace XXXX with the specific KB number for the April patch

<#
# Check if the update is installed
$updateInstalled = Get-HotFix -Id $targetUpdate -ErrorAction SilentlyContinue

if ($updateInstalled) {
    Write-Output "The Microsoft April patch ($targetUpdate) is installed."
} else {
    Write-Output "The Microsoft April patch ($targetUpdate) is not installed."
}
#>
