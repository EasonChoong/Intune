# Remediation Script for NC_AllowNetBridge_NLA
$desiredValue = 0

# Detection
$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'

if ($path1 -eq 'TRUE') {
    if ($key1.NC_AllowNetBridge_NLA -ne $desiredValue) {
        # Remediation
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections' -Name 'NC_AllowNetBridge_NLA' -Value $desiredValue
        Write-Output "Remediated: NC_AllowNetBridge_NLA is now set to $desiredValue."
    } else {
        Write-Output "No remediation required. NC_AllowNetBridge_NLA is already configured as required ($desiredValue)."
    }
} else {
    Write-Output "Registry path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections' is missing. No remediation possible."
}
