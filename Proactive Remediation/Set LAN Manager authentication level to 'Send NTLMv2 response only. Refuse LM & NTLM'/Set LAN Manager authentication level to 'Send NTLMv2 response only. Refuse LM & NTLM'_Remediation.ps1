# Remediation Script for LmCompatibilityLevel
$desiredValue = 5

# Detection
$path1 = Test-Path -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
$key1 = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'

if ($path1 -eq 'TRUE') {
    if ($key1.LmCompatibilityLevel -ne $desiredValue) {
        # Remediation
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'LmCompatibilityLevel' -Value $desiredValue
        Write-Output "Remediated: LmCompatibilityLevel is now set to $desiredValue."
    } else {
        Write-Output "No remediation required. LmCompatibilityLevel is already configured as required ($desiredValue)."
    }
} else {
    Write-Output "Registry path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' is missing. No remediation possible."
}
