# Registry paths
$internetSettingsPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$wpadPath = "$internetSettingsPath\Wpad"
$winHttpPath = "$internetSettingsPath\WinHttp"
#$winHttpServicePath = "HKLM:\System\CurrentControlSet\Services\WinHttpAutoProxySvc"

# Desired values to disable WPAD
$desiredAutoDetect = 0
$desiredWpadOverride = 1
$desiredDisableWpad = 1
#$desiredWinHttpServiceStart = 4  # Disabled

# Flag to check if remediation is needed
$remediationNeeded = $false

# Detection for AutoDetect
$autoDetect = (Get-ItemProperty -Path $internetSettingsPath -Name "AutoDetect" -ErrorAction SilentlyContinue).AutoDetect
if ($autoDetect -ne $desiredAutoDetect) {
    Write-Host "AutoDetect is not set correctly. Current value: $autoDetect. Desired value: $desiredAutoDetect"
    $remediationNeeded = $true
} else {
    Write-Host "AutoDetect is correctly set to disable WPAD."
}

# Detection for WpadOverride
$wpadOverride = (Get-ItemProperty -Path $wpadPath -Name "WpadOverride" -ErrorAction SilentlyContinue).WpadOverride
if ($wpadOverride -ne $desiredWpadOverride) {
    Write-Host "WpadOverride is not set correctly. Current value: $wpadOverride. Desired value: $desiredWpadOverride"
    $remediationNeeded = $true
} else {
    Write-Host "WpadOverride is correctly set to disable WPAD."
}

# Detection for DisableWpad
$disableWpad = (Get-ItemProperty -Path $winHttpPath -Name "DisableWpad" -ErrorAction SilentlyContinue).DisableWpad
if ($disableWpad -ne $desiredDisableWpad) {
    Write-Host "DisableWpad is not set correctly. Current value: $disableWpad. Desired value: $desiredDisableWpad"
    $remediationNeeded = $true
} else {
    Write-Host "DisableWpad is correctly set to disable WPAD for WinHTTP."
}

<# Detection for WinHttpAutoProxySvc Start value
$winHttpServiceStart = (Get-ItemProperty -Path $winHttpServicePath -Name "Start" -ErrorAction SilentlyContinue).Start
if ($winHttpServiceStart -ne $desiredWinHttpServiceStart) {
    Write-Host "WinHttpAutoProxySvc Start is not set correctly. Current value: $winHttpServiceStart. Desired value: $desiredWinHttpServiceStart"
    $remediationNeeded = $true
} else {
    Write-Host "WinHttpAutoProxySvc Start is correctly set to Disabled."
}
#>
# Exit code based on detection results
if ($remediationNeeded -eq $true) {
    Write-Host "Remediation is required."
    exit 1
} else {
    Write-Host "All WPAD settings are correctly configured. No remediation needed."
    exit 0
}
