# Get Windows version and build number
$osVersion = [System.Environment]::OSVersion.Version
$osBuild = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseId).ReleaseId
$osCompatible=$true

$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft Services\AdmPwd'
$desiredValue = 1


if ($path1 -eq 'TRUE') {
    if ($key1.AdmPwdEnabled -ne $desiredValue) {
        if($osVersion.Major -eq 10 -and $osVersion.Build -eq "22621" -and $osBuild -lt "1555"){
            $osCompatible=$false
            }elseif($osVersion.Major -eq 10 -and $osVersion.Build -eq "22000" -and $osBuild -lt "1817"){
            $osCompatible=$false
            }elseif($osVersion.Major -eq 10 -and $osVersion.Build -like "1904*"-and $osBuild -lt "2846"){
            $osCompatible=$false
            }else{
            
            write-output (Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -FilterXPath "*[System[Level=2]]" | Group-Object -Property Id | ForEach-Object {
                        $_.Group | Sort-Object { [DateTime]$_.'TimeCreated' } -Descending | Select-Object -First 1
                    }|fl)
        if(!$osCompatible){
                write-output "Key not set. Update required. OS Version is $osVersion $osBuild"
                exit 1
            }else{
            
<#$event=(Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -FilterXPath "*[System[Level=2]]" | Group-Object -Property Id | ForEach-Object {
                        $_.Group | Sort-Object { [DateTime]$_.'TimeCreated' } -Descending | Select-Object -First 1
                    })#>
#            write-output "Key not set. OS version supported`n $event"
            $event=(Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -FilterXPath "*[System[Level=2]]" -MaxEvents 10).message
                        write-output "Key not set. OS version supported`n-------------`n $event"
                exit 1
                }
            }
            }
      else {
        Write-Output "LAPS Configured"
        exit 0
    }
} else {
    if($osVersion.Major -eq 10 -and $osVersion.Build -eq "22621" -and $osBuild -lt "1555"){
            $osCompatible=$false
            }elseif($osVersion.Major -eq 10 -and $osVersion.Build -eq "22000" -and $osBuild -lt "1817"){
            $osCompatible=$false
            }elseif($osVersion.Major -eq 10 -and $osVersion.Build -like "1904*"-and $osBuild -lt "2846"){
            $osCompatible=$false
            }else{
            
                if(!$osCompatible){
                    write-output "Key is missing. Update required. OS Version is $osVersion $osBuild"
                    exit 1
                        }else{
            
#$event=(Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -FilterXPath "*[System[Level=2]]" | Group-Object -Property Id | ForEach-Object {$_.Group | Sort-Object { [DateTime]$_.'TimeCreated' } -Descending | Select-Object -First 1   })
                        $event=(Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -FilterXPath "*[System[Level=2]]" -MaxEvents 10).message
                        write-output "Key is missing`n-------------`n $event"
                        exit 1
                        }
                }
            }
             

            

#$targetUpdate = "KB5025221" # Replace XXXX with the specific KB number for the April patch

<#
# Check if the update is installed
$updateInstalled = Get-HotFix -Id $targetUpdate -ErrorAction SilentlyContinue

if ($updateInstalled) {
    Write-Output "The Microsoft April patch ($targetUpdate) is installed."
} else {
    Write-Output "The Microsoft April patch ($targetUpdate) is not installed."
}
#>
