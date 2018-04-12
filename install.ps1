###########################################
#
# Installation Script
#
# To execute this script:
# 1) Open powershell window as administrator
# 2) Allow script execution by running command "Set-ExecutionPolicy Unrestricted"
# 3) If necessary change to an appropriate directory
# 4) If necessary, run Invoke-WebRequest -Uri https://raw.githubusercontent.com/tghosth/hack-build-windows/master/install.ps1 -OutFile install.ps1 to download this script.
# 5) Execute the script by running ".\install.ps1"
#
# Based on https://github.com/fireeye/flare-vm/blob/master/install.ps1
###########################################


$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )

if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Host "[ * ] Installing Boxstarter"
  iex ((New-Object System.Net.WebClient).DownloadString('http://boxstarter.org/bootstrapper.ps1')); get-boxstarter -Force

  # Get user credentials for autologin during reboots
  Write-Host "[ * ] Getting user credentials ..."

  Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds" -Name "ConsolePrompting" -Value $True
  $cred=Get-Credential $env:username

  if ($cred) {
      Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/tghosth/hack-build-windows/master/hack-build-windows.ps1 -Credential $cred
  } else {
      Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/tghosth/hack-build-windows/master/hack-build-windows.ps1
  }

} else {
  Write-Host "[ERR] Please run this script as administrator"
  Read-Host  "      Press ANY key to continue..."
}
