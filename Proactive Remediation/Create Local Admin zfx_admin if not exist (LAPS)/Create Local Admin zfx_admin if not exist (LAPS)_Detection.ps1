$username = "zfx_admin"

if(get-LocalUser -Name $username){   
    $adm=([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % { ([ADSI]$_).InvokeGet('AdsPath')}

    if($adm.Contains("WinNT://$env:computername/zfx_admin")){
        Write-Output "Local admin zfx_admin is already exist. No action required"
        exit 0
    }else{
        Write-Output "Local user zfx_admin is already exist, but not local administrator"      
        exit 0
    }
}else{
    Write-Output "Local user zfx_admin not found"
    exit 1
}