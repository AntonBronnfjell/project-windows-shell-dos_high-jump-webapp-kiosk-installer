@echo off

echo Requesting administrator mode...

:: Ask for admin.
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

echo Setting up Desktop...

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCortanaButton /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowStatusBar /t REG_DWORD /d 0 /f

echo Adding Startup apps...

copy /y %~dp0\assets\startup\Highjump.lnk %appdata%\..\..\Desktop
%~dp0\assets\startup\Silverlight_x64.exe

echo Setting Up...

xcopy %~dp0\assets\backgrounds %appdata%\..\..\Documents /e /h /c /i /y
xcopy %~dp0\assets\policies %appdata%\..\..\Documents /e /h /c /i /y
copy /y %~dp0\assets\xml\sites.xml %appdata%\..\..\Documents
copy /y %~dp0\assets\startup\temp.bat %appdata%\Microsoft\Windows\"Start Menu"\Programs\Startup

echo Removing Sleep mode...

powercfg /x -hibernate-timeout-ac 0
powercfg /x -hibernate-timeout-dc 0
powercfg /x -disk-timeout-ac 0
powercfg /x -disk-timeout-dc 0
powercfg /x -monitor-timeout-ac 0
powercfg /x -monitor-timeout-dc 0
Powercfg /x -standby-timeout-ac 0
powercfg /x -standby-timeout-dc 0

echo Changing background...

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d %appdata%\..\..\Documents\background.png 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v LockScreenImage /t REG_SZ /d %appdata%\..\..\Documents\lockscreen.jpg /f
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters

echo Setting up MSEdge mode...

copy %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates\windows\admx\msedge.admx C:\Windows\PolicyDefinitions\
copy %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates\windows\admx\msedgeupdate.admx C:\Windows\PolicyDefinitions\
copy %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates\windows\admx\msedgewebview2.admx C:\Windows\PolicyDefinitions\
copy %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates\windows\admx\en-US\msedge.adml C:\Windows\PolicyDefinitions\en-US\
copy %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates\windows\admx\en-US\msedgeupdate.adml C:\Windows\PolicyDefinitions\en-US\
copy %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates\windows\admx\en-US\msedgewebview2.adml C:\Windows\PolicyDefinitions\en-US\

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v InternetExplorerIntegrationLevel /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v InternetExplorerIntegrationSiteList /t REG_SZ /d file:///%appdata%\..\..\Documents\sites.xml /f

echo Disabling AutoUpdate...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f

echo Restarting PC...

shutdown /r -t 5

pause