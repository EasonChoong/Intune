# Detection Script for ConsentPromptBehaviorUser
$path1 = Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$key1 = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$desiredValue = 1