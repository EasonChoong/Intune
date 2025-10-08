$username = "your_admin"

if(get-LocalUser -Name $username){   
    $adm=([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % { ([ADSI]$_).InvokeGet('AdsPath')}

    if($adm.Contains("WinNT://$env:computername/your_admin")){
        Write-Output "Local admin your_admin is already exist. No action required"
        exit 0
    }else{
        Write-Output "Local user your_admin is already exist, but not local administrator"      
        exit 0
    }
}else{
    Write-Output "Local user your_admin not found"
    exit 1
}