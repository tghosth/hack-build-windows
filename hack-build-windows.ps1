# Install pen testing tools onto my Windows VM
# Inspired by: https://github.com/fireeye/flare-vm/blob/master/flarevm_malware.ps1

###############################################################################
# Configure system
###############################################################################

# Boxstarter options
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$true # Is this a machine with no login password?

# Basic setup
Update-ExecutionPolicy Unrestricted
Set-WindowsExplorerOptions -EnableShowFileExtensions -DisableShowProtectedOSFiles -EnableShowHiddenFilesFoldersDrives
Set-TaskbarOptions -Size Small -Lock -Combine Never
Disable-BingSearch
Install-WindowsUpdate

Disable-GameBarTips
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -DisableShowAppsViewOnStartScreen -DisableSearchEverywhereInAppsView -EnableListDesktopAppsFirst
Set-CornerNavigationOptions -DisableUpperRightCornerShowCharms -DisableUpperLeftCornerSwitchApps -DisableUsePowerShellOnWinX

$cache = "$env:userprofile\AppData\Local\ChocoCache"
New-Item -Path $cache -ItemType directory -Force
$startPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PENTEST"

if( -not (Test-Path -path $startPath) ) { New-Item -Path $startPath -ItemType directory }

$desktopShortcut = Join-Path ${Env:USERPROFILE} "Desktop\PENTEST.lnk"

Install-ChocolateyShortcut -shortcutFilePath $desktopShortcut -targetPath $startPath

# Packages requiring reboot
cinst powershell                    --cacheLocation $cache
cinst dotnet4.7.1                   --cacheLocation $cache

cinst jre8 --cacheLocation $cache
cinst zap --cacheLocation $cache
cinst nmap --cacheLocation $cache
cinst winscp --cacheLocation $cache
cinst putty --cacheLocation $cache
cinst hxd --cacheLocation $cache
cinst googlechrome --cacheLocation $cache
cinst notepadplusplus --cacheLocation $cache
cinst vnc-viewer --cacheLocation $cache
cinst vlc --cacheLocation $cache
cinst linqpad --cacheLocation $cache
cinst winmerge --cacheLocation $cache
cinst wireshark --cacheLocation $cache
cinst firefox --cacheLocation $cache
cinst 7zip --cacheLocation $cache
