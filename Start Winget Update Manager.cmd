@echo off
rem Starts Winget Update Manager from the script, without a console window. The execution-policy
rem bypass applies to this run only; no Windows settings are changed.
rem It asks for administrator rights (UAC) when it starts.
rem If it doesn't open, run   "Start Winget Update Manager.cmd" debug   to keep a console and see what it prints
rem (from a command prompt opened as administrator, or it relaunches itself elevated in a new, hidden window).
if /i "%~1"=="debug" (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File "%~dp0src\Winget-Update-Manager.ps1"
    pause
) else (
    start "" powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -WindowStyle Hidden -File "%~dp0src\Winget-Update-Manager.ps1"
)
