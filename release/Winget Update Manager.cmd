@echo off
rem Winget Update Manager - double-click to start it.
rem Each time, this makes (or refreshes) the Winget Update Manager shortcut in this folder and in the Start menu,
rem then starts Winget Update Manager from it. After the first run you can use the shortcut, the Start menu or
rem a pinned taskbar button instead: they start Winget Update Manager without a console window.
rem The execution-policy bypass applies to Winget Update Manager's own run only; no Windows settings are changed.
rem Winget Update Manager asks for administrator rights (UAC) each time it starts.
rem If Winget Update Manager doesn't open, run   "Winget Update Manager.cmd" debug   to start it in this window and see any errors.
rem (Run that from a command prompt opened as administrator, or the app relaunches itself elevated in a new, hidden window.)
setlocal
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if /i "%~1"=="debug" (
    "%PS%" -NoProfile -ExecutionPolicy Bypass -STA -File "%~dp0Winget-Update-Manager.ps1"
    pause
    exit /b
)
"%PS%" -NoProfile -ExecutionPolicy Bypass -File "%~dp0New-WingetUpdateManagerShortcut.ps1" -Launch
if errorlevel 1 pause
