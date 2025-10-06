$desiredValue = 1

# Detection
$path1 = "HKLM:SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
<#
try  {
    New-item -Path $path1 -Force
    New-ItemProperty -Path $path1 -Name 'Enabled' -Value 1 -PropertyType DWord -Force
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}
#>