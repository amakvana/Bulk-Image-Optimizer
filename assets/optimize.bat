@echo off
title Bulk Image Optimizer
mode con: cols=71 lines=20
cd /d %1
cls
echo;
echo +--------------------------------------------------------------------+
echo ^|                        Bulk Image Optimizer                        ^|
echo ^|          https://github.io/amakvana/bulk-image-optimizer           ^|
echo +--------------------------------------------------------------------+
echo ^|                                                                    ^|
echo ^|     1 - Fast Compression (Recommended for most cases)              ^| 
echo ^|     2 - Best Compression (Very slow but yields smallest files)     ^| 
echo ^|     3 - EXIT                                                       ^|
echo ^|                                                                    ^|
echo +--------------------------------------------------------------------+
echo;
choice /n /C:123 /m "Choose an option (1-3):"
if %ERRORLEVEL%==1 goto fast
if %ERRORLEVEL%==2 goto best
if %ERRORLEVEL%==3 goto EOF

:fast
echo;
echo Compressing PNG files ... 
for /r %%i in (*.png) do (
    "%programfiles%\Image Optimization\optipng.exe" -o1 -strip all "%%i" >nul 2>&1 
    "%programfiles%\Image Optimization\advpng.exe" -q -z2 "%%i" >nul 2>&1
    "%programfiles%\Image Optimization\zopflipng.exe" -q -y "%%i" "%%i" >nul 2>&1
)
goto jpeg

:best
echo;
echo Compressing PNG files ... 
for /r %%i in (*.png) do (
    "%programfiles%\Image Optimization\optipng.exe" -o5 -strip all "%%i" >nul 2>&1 
    "%programfiles%\Image Optimization\advpng.exe" -q -z3 "%%i" >nul 2>&1
    "%programfiles%\Image Optimization\zopflipng.exe" -m -y "%%i" "%%i" >nul 2>&1
)
goto jpeg

:jpeg 
echo Compressing JPEG files ... 
for /r %%i in (*.jpg,*.jpeg) do (
    "%programfiles%\Image Optimization\jpegtran.exe" -copy none -optimize -outfile "%%i" "%%i" >nul 2>&1
    "%programfiles%\Image Optimization\jpegoptim.exe" -q --strip-all --all-normal "%%i" >nul 2>&1 
)