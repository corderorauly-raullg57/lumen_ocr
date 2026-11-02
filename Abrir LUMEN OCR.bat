@echo off
rem LUMEN OCR - abre la app sin internet (inicia el servidor local minimizado)
cd /d "%~dp0"
start "LUMEN OCR - servidor local" /min powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0servidor.ps1"
exit /b 0
