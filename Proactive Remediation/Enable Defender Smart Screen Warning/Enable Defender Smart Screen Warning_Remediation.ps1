# Remediation Script
foreach ($regKey in $regKeys) {
    if (!(Test-Path $regKey.Path)) {
        New-Item -Path $regKey.Path -Force | Out-Null
    }
    if ($regKey.Type -eq "DWORD") {
        New-ItemProperty -Path $regKey.Path -Name $regKey.Name -Value $regKey.DesiredValue -PropertyType DWORD -Force | Out-Null
    } elseif ($regKey.Type -eq "String") {
        New-ItemProperty -Path $regKey.Path -Name $regKey.Name -Value $regKey.DesiredValue -PropertyType String -Force | Out-Null
    }
    Write-Output "[Remediate] Set $($regKey.Name) in $($regKey.Path) to $($regKey.DesiredValue)."
}
