# Detection Script for AdmPwdEnabled
$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd'
$desiredValue = 1

if ($path1 -eq 'TRUE') {
    if ($key1.AdmPwdEnabled -ne $desiredValue) {
        Write-Output "AdmPwdEnabled is not set to $desiredValue."
        exit 1
    } else {
        Write-Output "AdmPwdEnabled is configured as required ($desiredValue)."
        exit 0
    }
} else {
    Write-Output "Registry path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd' is missing."
    exit 1
}
