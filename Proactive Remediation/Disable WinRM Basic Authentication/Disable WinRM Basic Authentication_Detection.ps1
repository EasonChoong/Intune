# Detection Script for AllowBasic (Client and Service)
$regPathClient = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client'
$regPathService = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
$regValueName = 'AllowBasic'
$desiredValue = 0

$detectedIssues = @()

# Detection for Client
if (Test-Path -Path $regPathClient) {
    $currentValueClient = Get-ItemProperty -Path $regPathClient -Name $regValueName
    if ($currentValueClient -eq $null -or $currentValueClient.$regValueName -ne $desiredValue) {
        $detectedIssues += "$regValueName in $regPathClient is not set to $desiredValue."
    }
} else {
    $detectedIssues += "Registry path '$regPathClient' is missing."
}

# Detection for Service
if (Test-Path -Path $regPathService) {
    $currentValueService = Get-ItemProperty -Path $regPathService -Name $regValueName
    if ($currentValueService -eq $null -or $currentValueService.$regValueName -ne $desiredValue) {
        $detectedIssues += "$regValueName in $regPathService is not set to $desiredValue."
    }
} else {
    $detectedIssues += "Registry path '$regPathService' is missing."
}

# Output Detected Issues
if ($detectedIssues.Count -gt 0) {
    Write-Output "Detected Issues:`n$($detectedIssues -join "`n")"
    exit 1
} else {
    Write-Output "All registry checks passed successfully."
    exit 0
}
