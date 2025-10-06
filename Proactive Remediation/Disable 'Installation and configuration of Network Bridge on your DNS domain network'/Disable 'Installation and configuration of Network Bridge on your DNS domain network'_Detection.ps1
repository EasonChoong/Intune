# Detection Script for NC_AllowNetBridge_NLA
$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections'
$desiredValue = 0

if ($path1 -eq 'TRUE') {
    if ($key1.NC_AllowNetBridge_NLA -ne $desiredValue) {
        Write-Output "NC_AllowNetBridge_NLA is not set to $desiredValue."
        exit 1
    } else {
        Write-Output "NC_AllowNetBridge_NLA is configured as required ($desiredValue)."
        exit 0
    }
} else {
    Write-Output "Registry path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Network Connections' is missing."
    exit 1
}
