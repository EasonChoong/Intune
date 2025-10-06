$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Download'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Download'
  
if (($path1 -eq 'TRUE') )
{
    if (($key1.RunInvalidSignatures -eq '0') ){
 
        Write-Output "Running or installing software with invalid signature is disabled"      
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