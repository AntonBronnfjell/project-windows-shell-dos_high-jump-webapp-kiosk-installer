@echo off

rmdir /s /q %appdata%\..\..\Documents\MicrosoftEdgePolicyTemplates
copy /y %appdata%\..\..\Desktop\Highjump.lnk %appdata%\Microsoft\Windows\"Start Menu"\Programs\Startup

echo Before Finish, Open Edge:
echo        1. Browse to "edge://compat/enterprise".
echo        2. Click on "Force Update".
echo        3. Open the "HighJump" shortcut on Desktop.
echo        4. To verify if everything is working, see if the page loads with the IE icon.
pause


call :deleteSelf&exit /b
:deleteSelf
start /b "" cmd /c del "%~f0"&exit /b