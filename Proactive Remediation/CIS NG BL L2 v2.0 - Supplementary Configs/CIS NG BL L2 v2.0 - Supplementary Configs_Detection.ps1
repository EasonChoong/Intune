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

    Write-Output "Checking $registryPath\$valueName"

    # Check if the registry key exists
    if (Test-Path $registryPath) {
        # Get the current value
        $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

        # Check if the value exists and matches the desired value
        if ($null -ne $currentValue) {
            if ($currentValue.$valueName -eq $desiredValue) {
                Write-Output "The registry key and value exist and are set to the desired value."
            } else {
                Write-Output "The registry key exists but the value is not set to the desired value."
                exit 1
            }
        } else {
            Write-Output "The registry key exists but the value does not exist."
            exit 1
        }
    } else {
        Write-Output "The registry key does not exist."
        exit 1
    }
}
