# Define the username and password for the new user
$Username = "your_admin"
$Password = ConvertTo-SecureString "YourPassrandomPhrasesw0rd@H3re" -AsPlainText -Force //password will be rotated by LAPS so no worries

try  {
    # Create a new local user account
    New-LocalUser -Name $Username -Password $Password 

    # Add the user to the local administrators group
    Add-LocalGroupMember -Group "Administrators" -Member $Username

  
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
}