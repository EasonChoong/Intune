# Detection Script
$regKeys = @(
    @{ Path = "HKLM:\Software\Policies\Microsoft\Windows\System"; Name = "EnableSmartScreen"; DesiredValue = 1; Type = "DWORD" },
    @{ Path = "HKLM:\Software\Policies\Microsoft\Windows\System"; Name = "ShellSmartScreenLevel"; DesiredValue = "Warn"; Type = "String" }
)

foreach ($regKey in $regKeys) {
    if (Test-Path $regKey.Path) {
        $value = Get-ItemProperty -Path $regKey.Path -Name $regKey.Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $regKey.Name -ErrorAction SilentlyContinue
        if ($value -ne $regKey.DesiredValue) {
            Write-Output "[Detect] $($regKey.Name) in $($regKey.Path) is not set to $($regKey.DesiredValue). Current value: $value"
        } else {
            Write-Output "[Detect] $($regKey.Name) in $($regKey.Path) is correctly set to $($regKey.DesiredValue)."
        }
    } else {
        Write-Output "[Detect] Path $($regKey.Path) does not exist."
    }
}

