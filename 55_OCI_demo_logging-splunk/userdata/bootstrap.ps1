#ps1_sysnative
cmd /C 'wmic UserAccount where Name="opc" set PasswordExpires=False'
net  accounts  /MaxPwAge:Unlimited
#$scriptUrl = "https://raw.githubusercontent.com/KopiCloud-AD-API/kopicloud-ad-api-setup-scripts/main/setup-win2019.ps1"
#$scriptPath = "$env:TEMP\\setup-win2019.ps1"
#Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath
#Set-ExecutionPolicy Unrestricted -Force
#powershell -ExecutionPolicy Unrestricted -File $scriptPath