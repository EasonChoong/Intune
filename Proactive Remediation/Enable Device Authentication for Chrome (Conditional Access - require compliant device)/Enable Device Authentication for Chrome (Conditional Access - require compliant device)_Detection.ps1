
$path1 = Test-Path -Path 'HKLM:\Software\Policies\Google\Chrome'
$key1 = Get-ItemProperty -Path 'HKLM:\Software\Policies\Google\Chrome'
  
if (($path1 -eq 'TRUE'))
{
    if (($key1.CloudAPAuthEnabled -eq '1')){
 
        Write-Output "Chrome CloudAP Auth Enabled"      
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