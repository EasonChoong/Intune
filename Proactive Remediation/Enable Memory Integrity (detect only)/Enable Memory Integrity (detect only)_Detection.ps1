$regPath = "HKLM:SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
$regValueName = 'Enabled'
$desiredValue = 1

if (Test-Path -Path $regPath) {
    $currentValue = Get-ItemProperty -Path $regPath -Name $regValueName
    if ($currentValue -eq $null -or $currentValue.$regValueName -ne $desiredValue) {
        Write-Output "$regValueName is not set to $desiredValue."
        exit 1
    } else {
        Write-Output "$regValueName is configured as required ($desiredValue)."
        exit 0
    }
} else {
    Write-Output "Registry path '$regPath' is missing."
    exit 1
}
