# Remediation Script for AllowBasic (Client and Service)
$path1 = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client'
$path2 = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
$regValueName = 'AllowBasic'
$desiredValue = 0

# Remediation for Client
try  {
    New-item -Path $path1 -Force
    New-ItemProperty -Path $path1 -Name $regValueName -Value $desiredValue -PropertyType DWord -Force
 
    New-item -Path $path2 -Force
    New-ItemProperty -Path $path2 -Name $regValueName -Value $desiredValue -PropertyType DWord -Force
 
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}