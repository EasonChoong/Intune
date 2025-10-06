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

# Remediation for AutoDetect
try {
    Set-ItemProperty -Path $internetSettingsPath -Name "AutoDetect" -Value $desiredAutoDetect -ErrorAction Stop
    Write-Host "AutoDetect set to $desiredAutoDetect to disable WPAD."
} catch {
    Write-Host "Failed to set AutoDetect. Error: $_"
}

# Remediation for WpadOverride
try {
    # Ensure the WPAD path exists before setting the value
    if (!(Test-Path -Path $wpadPath)) {
        New-Item -Path $wpadPath -Force | Out-Null
    }
    Set-ItemProperty -Path $wpadPath -Name "WpadOverride" -Value $desiredWpadOverride -ErrorAction Stop
    Write-Host "WpadOverride set to $desiredWpadOverride to disable WPAD."
} catch {
    Write-Host "Failed to set WpadOverride. Error: $_"
}

# Remediation for DisableWpad
try {
    Set-ItemProperty -Path $winHttpPath -Name "DisableWpad" -Value $desiredDisableWpad -ErrorAction Stop
    Write-Host "DisableWpad set to $desiredDisableWpad to disable WPAD for WinHTTP."
} catch {
    Write-Host "Failed to set DisableWpad. Error: $_"
}

<# Remediation for WinHttpAutoProxySvc Start value
try {
    Set-ItemProperty -Path $winHttpServicePath -Name "Start" -Value $desiredWinHttpServiceStart -ErrorAction Stop
    Write-Host "WinHttpAutoProxySvc Start set to $desiredWinHttpServiceStart (Disabled)."
} catch {
    Write-Host "Failed to set WinHttpAutoProxySvc Start. Error: $_"
}
#>