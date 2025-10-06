# Define the service name and desired dependencies as an array
$serviceName = "WcmSvc"
$desiredDependencies = @("RpcSs", "NSI")

# Define the registry path for the service dependencies
$serviceKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"

# Get the current dependencies as an array, trimming each element
$currentDependencies = (Get-ItemProperty -Path $serviceKeyPath -Name "DependOnService").DependOnService
$currentDependencies = $currentDependencies | ForEach-Object { $_.Trim() }

# Join arrays to single strings and compare them
if ($currentDependencies -like "*/*") {
    Write-Output "Updating dependencies for $serviceName to '$($desiredDependencies -join ', ')'."
    exit 1
}elseif (Compare-Object -ReferenceObject  $currentDependencies -DifferenceObject $desiredDependencies) {
    Write-Output "Updating dependencies for $serviceName to '$($desiredDependencies -join ', ')'."
    exit 1
} else {
    Write-Output "No update needed; $currentDependencies are already set to '$($desiredDependencies -join ', ')'."
    exit 0
}
