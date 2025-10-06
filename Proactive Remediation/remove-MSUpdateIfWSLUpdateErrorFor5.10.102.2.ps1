$searchTitle = "Windows Subsystem for Linux Update - 5.10.102.2"
$subsystem = dism /online /get-features /format:table | findstr /i "Subsystem"

$target = Get-WindowsUpdate -MicrosoftUpdate -IgnoreUserInput | Where-Object { $_.Title -eq $searchTitle }

if(!$subsystem -and $target){

}else{
    #Do nothing
}