#ps1_sysnative

# ---------- Post-provisioning Cloud-init script for Windows 2016

# cloud-init log file = C:\Program Files\Cloudbase Solutions\Cloudbase-Init\log\cloudbase-init.log

# -- Also log outputs to another log file
Start-Transcript -Path "C:\users\opc\cloud-init.log" -NoClobber

Write-Output "======== Get argument(s) passed thru metadata"
$par_url=$($(Invoke-WebRequest -UseBasicParsing -Uri http://169.254.169.254/opc/v1/instance/metadata).Content|ConvertFrom-Json).myarg_os_par 

Write-Output "======== Get password from OCI bucket using pre-auth request"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$password = [System.Text.Encoding]::ASCII.GetString( (Invoke-WebRequest -UseBasicParsing -Uri $par_url).Content)

Write-Output "======== Set a password for opc user (replace temporary randomly generated password)"
net user opc $password

Write-Output "======== Create new user account opc2 with Administrators privileges (may be needed if opc is locked)"
net user opc2 $password /add   
net localgroup  administrators opc2 /add  

Write-Output "======== Disable password expiry (42 days by default)"
net accounts /maxpwage:unlimited 
