# Remediation Script for CloudAPAuthEnable
$desiredValue = 1

$path1 = 'HKLM:\Software\Policies\Google\Chrome'
$key1 = Get-ItemProperty -Path 'HKLM:\Software\Policies\Google\Chrome'

if ((test-path $path1) -ne 'TRUE'){
    New-item -Path $path1 -Force
}
try  {    
    New-ItemProperty -Path $path1 -Name 'CloudAPAuthEnabled' -Value $desiredValue -PropertyType DWord -Force
    
    #new-ItemProperty -Path 'HKLM:\Software\Policies\Google\Chrome' -Name 'CloudAPAuthEnable' -Value $desiredValue
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}
