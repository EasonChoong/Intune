# Define the service name and desired dependencies as an array
$serviceName = "WcmSvc"
$desiredDependencies = @("RpcSs", "NSI")

# Define the registry path for the service dependencies
$serviceKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"

# Get the current dependencies as an array, trimming each element
$currentDependencies = (Get-ItemProperty -Path $serviceKeyPath -Name "DependOnService").DependOnService
$currentDependencies = $currentDependencies | ForEach-Object { $_.Trim() }

# Join arrays to single strings and compare them
    Write-Output "Updating dependencies for $serviceName to '$($desiredDependencies -join ', ')'."
    
    # Update the dependencies
    Set-ItemProperty -Path $serviceKeyPath -Name "DependOnService" -Value $desiredDependencies -Type MultiString
    
    # Restart the service to apply changes (optional)
    Restart-Service -Name $serviceName -Force
    Write-Output "Dependencies updated and service restarted."