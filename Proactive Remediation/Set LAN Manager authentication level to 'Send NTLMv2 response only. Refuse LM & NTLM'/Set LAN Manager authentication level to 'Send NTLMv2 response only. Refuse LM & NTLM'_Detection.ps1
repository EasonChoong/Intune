# Detection Script for LmCompatibilityLevel
$path1 = Test-Path -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
$key1 = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
$desiredValue = 5

if ($path1 -eq 'TRUE') {
    if ($key1.LmCompatibilityLevel -ne $desiredValue) {
        Write-Output "LmCompatibilityLevel is not set to $desiredValue."
        exit 1
    } else {
        Write-Output "LmCompatibilityLevel is configured as required ($desiredValue)."
        exit 0
    }
} else {
    Write-Output "Registry path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' is missing."
    exit 1
}
