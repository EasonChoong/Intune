$path1 = 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Download\'

try  {
    New-item -Path $path1 -Force
    New-ItemProperty -Path $path1 -Name 'RunInvalidSignatures' -Value 0 -PropertyType DWord -Force
 
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
} 