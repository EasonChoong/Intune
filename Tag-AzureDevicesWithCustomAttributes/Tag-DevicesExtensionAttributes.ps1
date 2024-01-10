## This is meant to be used in Azure Devops
param (
    $appid,
    $secret
)
#$module = get-module -listavailable -name 'Microsoft.Graph.Identity.DirectoryManagement' -ErrorAction SilentlyContinue
$MsGraphBetaModule =  Get-Module Microsoft.Graph.Beta -ListAvailable  -ErrorAction SilentlyContinue

if($MsGraphBetaModule -eq $null)
{ 
        Write-host "Installing Microsoft Graph Beta module..."
        #Install-Module Microsoft.Graph.Beta -Force
        Install-Module -Force Microsoft.Graph.Beta.Users
        Install-Module -Force Microsoft.Graph.Authentication
        Install-Module -Force Microsoft.Graph.Beta.Identity.DirectoryManagement
        Write-host "Microsoft Graph Beta module is installed in the machine successfully" -ForegroundColor Magenta 
}
<#
if ($module -eq $null) {
    Install-Module Microsoft.Graph.Identity.DirectoryManagement -Force
}#>

$tenantid = 'd1b0c981-f9f5-4358-b764-91d5eb55e26a'

 
$body =  @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $appid
    Client_Secret = $secret
}
 
$connection = Invoke-RestMethod `
    -Uri https://login.microsoftonline.com/$tenantid/oauth2/v2.0/token `
    -Method POST `
    -Body $body
 
$token = ConvertTo-SecureString $connection.access_token -AsPlainText -Force
try{
Connect-MgGraph -AccessToken $token -NoWelcome
$DeviceList = get-mgBetadevice -All | where DeviceOwnership -eq "Company" #| where ApproximateLastSignInDateTime -ge ((get-date).adddays(-7))
$devCount=$DeviceList.count
$currentCount=0
    $DeviceList | %{
    $DeviceId = $_.Id
    $extensionattributes = get-mgbetaDevice -DeviceId $DeviceId | select -ExpandProperty ExtensionAttributes
    $currentCount+=1
    $user = (get-MgBetaDeviceRegisteredUser -DeviceId $DeviceId | %{get-MgBetaUser -UserId $_.id })
    if($user.DisplayName -NotLike "!*"){
        #extensionAttribute10 department
        $dept = $user.Department
        $attributevalue = "$dept"
        if ($extensionattributes.ExtensionAttribute10 -eq $attributevalue) {
            # Write-host -ForegroundColor DarkGreen "Correct Attribute10 Assigned"
        }else {
            if($user.ID -NotLike ""){
                write-output "Attribute10 missing or incorrect"
                Write-host -ForegroundColor Green -NoNewline "Writing $dept attrib $($user.DisplayName)  `n  User ID $($user.id) Deivce ID $deviceId"
                $deviceId | %{Update-MgBetaDevice -DeviceId $_ -BodyParameter @{extensionAttributes=@{extensionAttribute10=$dept}}}
            }else{write-output "No user ID`nAccount Enabled`tIdentities`tId";write-host -ForegroundColor Blue $user.accountEnabled;write-host -ForegroundColor Blue $user.Identities;write-host -ForegroundColor Blue $user.Id}
        }
    }else{
        $dept=""        
        if($user.Department -NotLike  $dept ){
        write-output "Clearing Attribute10"
        $deviceId | %{Update-MgBetaDevice -DeviceId $_ -BodyParameter @{extensionAttributes=@{extensionAttribute10=$dept}}}
        }
    }
    write-host -ForegroundColor green "$currentCount / $devCount"
}

Disconnect-MgGraph

}
catch {
    $errMsg = $_.Exception.Message
    Write-host $errMsg
    Disconnect-MgGraph

    exit 1
}
