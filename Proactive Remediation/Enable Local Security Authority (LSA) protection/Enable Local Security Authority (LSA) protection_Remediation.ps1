$path1 = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'

if ((test-path $path1) -ne 'TRUE'){
    New-item -Path $path1 -Force
}

try  {
    New-ItemProperty -Path $path1 -Name 'RunAsPPL' -Value 1 -PropertyType DWord -Force
 
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}


