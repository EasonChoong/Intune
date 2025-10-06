$path1 = Test-Path -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'

$key1 = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
  
if (($path1 -eq 'TRUE') )
{
    if (($key1.DisableDomainCreds -eq '1') ){
 
        Write-Output "Local credential storage is disable successful"      
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