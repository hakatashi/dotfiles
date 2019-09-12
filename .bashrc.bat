@echo off
:: Command shell auto-run

::
:: Including other files found
::
for %%f in ("%~dp0\.bashrc.include.*.bat") do call "%%~ff"

:: Set default code page to UTF-8
chcp 65001 > NUL

:: Displays Today's xkcd
:: C:\Python36\python %HOME%\dotfiles\xkcd.py
