# Set the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Set the registry value names
$valueNames = @("LegalNoticeCaption", "LegalNoticeText")

# Check if the registry key exists
if (Test-Path $registryPath) {
    foreach ($valueName in $valueNames) {
        # Remove the registry value if it exists
        if (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue) {
            Remove-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue
            Write-Host "The registry value '$valueName' has been removed."
        } else {
            Write-Host "The registry value '$valueName' does not exist."
            exit 0
        }
    }
} else {
    Write-Host "The specified registry path does not exist."
    exit 0
}
