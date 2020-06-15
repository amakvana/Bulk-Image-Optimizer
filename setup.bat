<<<<<<< HEAD
@echo off 
@echo off
title Bulk Image Optimizer Setup
mode con: cols=71 lines=15
cls
echo;
echo +--------------------------------------------------------------------+
echo ^|                 Bulk Image Optimizer Setup Script                  ^|
echo ^|          https://github.io/amakvana/bulk-image-optimizer           ^|
echo +--------------------------------------------------------------------+
echo;
echo Press any key to begin setup ...
pause >nul 2>&1 

REM Initialize
set "tempPath=%temp%\BulkImageOptimizer"
mkdir "%tempPath%" >nul 2>&1

REM Download assets
echo; 
echo Fetching assets ...
powershell -Command "Invoke-WebRequest https://github.com/amakvana/Bulk-Image-Optimizer/raw/master/assets/advpng.exe -OutFile %tempPath%\advpng.exe" >nul 2>&1
powershell -Command "Invoke-WebRequest https://github.com/amakvana/Bulk-Image-Optimizer/raw/master/assets/jpegoptim.exe -OutFile %tempPath%\jpegoptim.exe" >nul 2>&1
powershell -Command "Invoke-WebRequest https://github.com/amakvana/Bulk-Image-Optimizer/raw/master/assets/jpegtran.exe -OutFile %tempPath%\jpegtran.exe" >nul 2>&1
powershell -Command "Invoke-WebRequest https://github.com/amakvana/Bulk-Image-Optimizer/raw/master/assets/optimize.bat -OutFile %tempPath%\optimize.bat" >nul 2>&1
powershell -Command "Invoke-WebRequest https://github.com/amakvana/Bulk-Image-Optimizer/raw/master/assets/optipng.exe -OutFile %tempPath%\optipng.exe" >nul 2>&1
powershell -Command "Invoke-WebRequest https://github.com/amakvana/Bulk-Image-Optimizer/raw/master/assets/zopflipng.exe -OutFile %tempPath%\zopflipng.exe" >nul 2>&1

REM move into "%programfiles%\Image Optimization\"
echo Preparing assets ...
robocopy "%tempPath%" "%programfiles%\Image Optimization" /e /xj /xo /fft /r:1 /w:1 >nul 2>&1  

REM Create Reg keys 
echo Creating Registry keys ...
reg add "HKCR\Directory\shell\Optimize Images\command" /ve /t REG_SZ /d "\"C:\Program Files\Image Optimization\optimize.bat\" \"%%1\"" /f >nul 2>&1

REM Cleanup
echo Cleaning up ...
rmdir /s /q "%tempPath%" >nul 2>&1

REM Done
echo;
echo Done! Press any key to exit ...
pause >nul 2>&1 
