# Remediation Script for ConsentPromptBehaviorUser
$desiredValue = 1

# Detection
$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'

if ($path1 -eq 'TRUE') {
    if ($key1.ConsentPromptBehaviorUser -ne $desiredValue) {
        # Remediation
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorUser' -Value $desiredValue
        Write-Output "Remediated: ConsentPromptBehaviorUser is now set to $desiredValue."
    } else {
        Write-Output "No remediation required. ConsentPromptBehaviorUser is already configured as required ($desiredValue)."
    }
} else {
    Write-Output "Registry path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' is missing. No remediation possible."
}
