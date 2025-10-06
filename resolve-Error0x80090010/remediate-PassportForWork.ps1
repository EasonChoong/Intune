# Remediation Script for PassportForWork

$devId=(Get-ItemPropertyValue "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\JoinInfo\*" -Name TenantId)
$userID = (Get-CimInstance Win32_ComputerSystem).UserName |    ForEach-Object { (New-Object System.Security.Principal.NTAccount($_)).Translate([System.Security.Principal.SecurityIdentifier]).Value }


$desiredValue = 1


$path1 = 'HKLM:\SOFTWARE\Microsoft\Policies'
$path2 = "HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork\$devId\Device\Policies"
$path3 = "HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork\$devId\$userID\Policies"

try  {    
    if ((test-path $path1) -ne 'TRUE'){
        New-item -Path $path1 -Force
    }
    if ((test-path $path2) -ne 'TRUE'){
        New-item -Path $path2 -Force
    }
    if ((test-path $path3) -ne 'TRUE'){
        New-item -Path $path3 -Force
    }
    $key1 = Get-ItemProperty -Path $path1
    $key2 = Get-ItemProperty -Path $path2
    $key3 = Get-ItemProperty -Path $path3

    if($key1.PassportForWork -ne $desiredValue){       
        New-ItemProperty -Path $path1 -Name 'PassportForWork' -Value $desiredValue -PropertyType DWord -Force
        write-host "$path1 value set"
        }
    if($key2.UsePassportForWork -ne $desiredValue){       
        New-ItemProperty -Path $path2 -Name 'UsePassportForWork' -Value $desiredValue -PropertyType DWord -Force
        write-host "$path2 value set"
        }
    if($key3.UsePassportForWork -ne $desiredValue){       
        New-ItemProperty -Path $path3 -Name 'UsePassportForWork' -Value $desiredValue -PropertyType DWord -Force
        write-host "$path3 value set"
        }
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    #exit 1
}
