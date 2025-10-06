$devId=(Get-ItemPropertyValue "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\JoinInfo\*" -Name TenantId)
$userID = (Get-CimInstance Win32_ComputerSystem).UserName |    ForEach-Object { (New-Object System.Security.Principal.NTAccount($_)).Translate([System.Security.Principal.SecurityIdentifier]).Value }


$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Policies'

$path2 = Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork'
$key2 = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork\$devId\Device\Policies"
$key3 = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork\$devId\$userID\Policies"

write-host "HKLM:\SOFTWARE\Microsoft\Policies\PassportForWork\$userID\Policies"

if (($path1 -eq 'TRUE') -and ($path2 -eq 'TRUE'))
{
    if (($key1.PassportForWork -eq '1') -and ($key2.UsePassportForWork -eq '1') -and ($key3.UsePassportForWork -eq '1')){
 
        Write-Output "Windows PIN enabled"      
        exit 0
    }
    else 
    {
        Write-Output "Keys missing"
        exit 1
    }
}
else
{
    Write-Output "Paths missing"
    exit 1
}