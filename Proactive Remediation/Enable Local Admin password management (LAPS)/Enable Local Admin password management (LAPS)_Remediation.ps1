# Remediation Script for AdmPwdEnabled
$desiredValue = 1

# Detection
$path1 = 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd'


try  {
    New-item -Path $path1 -Force
    New-ItemProperty -Path $path1 -Name 'AdmPwdEnabled' -Value 1 -PropertyType DWord -Force
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}
