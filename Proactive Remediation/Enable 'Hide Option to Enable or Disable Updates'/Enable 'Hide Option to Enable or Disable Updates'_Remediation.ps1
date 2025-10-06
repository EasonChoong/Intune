# Remediation Script for hideenabledisableupdates
$path1 = 'HKLM:\SOFTWARE\policies\Microsoft\office\16.0\common\officeupdate'
$regValueName = 'hideenabledisableupdates'
$desiredValue = 1

try  {
    New-item -Path $path1 -Force
    New-ItemProperty -Path $path1 -Name $regValueName -Value $desiredValue -PropertyType DWord -Force
    
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}