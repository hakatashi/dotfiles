@echo off
:: Command shell auto-run

::
:: Including other files found
::
for %%f in ("%~dp0\.bashrc.include.*.bat") do call "%%~ff"

:: Set default code page to UTF-8
chcp 65001
