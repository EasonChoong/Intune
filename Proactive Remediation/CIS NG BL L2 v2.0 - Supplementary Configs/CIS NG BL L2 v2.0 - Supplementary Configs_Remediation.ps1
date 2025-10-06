# Define the list of registry keys, value names, and desired values
$registryEntries = @(
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\pnrpautoReg"; Name = "Start"; DesiredValue = 4 },
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\pnrpsvc"; Name = "Start"; DesiredValue = 4 },
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Print"; Name = "RpcAuthnLevelPrivacyEnabled"; DesiredValue = 1 },
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\lxssmanager"; Name = "Start"; DesiredValue = 4 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; Name = "UploadUserActivities"; DesiredValue = 0 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"; Name = "ManagePreviewBuildsPolicyValue"; DesiredValue = 1 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\AppV\Client"; Name = "AllowPersistence"; DesiredValue = 0 },
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\MSiSCSI"; Name = "Start"; DesiredValue = 4 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"; Name = "EnableSmartScreen"; DesiredValue = 0 },
    @{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"; Name = "EnableMpr"; DesiredValue = 0 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"; Name = "LimitDiagnosticLogCollection"; DesiredValue = 1 },
    @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\P2PIMSvc"; Name = "Start"; DesiredValue = 4 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"; Name = "AllowCortanaAboveLock"; DesiredValue = 0 },
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace"; Name = "AllowWindowsInkWorkspace"; DesiredValue = 1 },
    @{ Path = "HKLM:\SOFTWARE\microsoft\windows\currentversion\policies\system"; Name = "promptonsecuredesktop"; DesiredValue = 0 }
    @{ Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"; Name = "DisableFileSyncNGSC"; DesiredValue = 0 }
)

foreach ($entry in $registryEntries) {
    $registryPath = $entry.Path
    $valueName = $entry.Name
    $desiredValue = $entry.DesiredValue

    Write-Output "Remediating $registryPath\$valueName"

    # Ensure the registry key exists
    if (-not (Test-Path $registryPath)) {
        # Create the registry key
        New-Item -Path $registryPath -Force | Out-Null
        Write-Output "Created registry key: $registryPath"
    }

    # Set the desired value
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue
    Write-Output "Set $valueName to $desiredValue in $registryPath"
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Value 0