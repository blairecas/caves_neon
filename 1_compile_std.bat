@echo off

echo.
echo ===========================================================================
echo Graphics
echo ===========================================================================
php -f ./graphics/conv_graphics.php
if %ERRORLEVEL% NEQ 0 ( exit /b )

echo.
echo ===========================================================================
echo Compiling CPU
echo ===========================================================================
php -f ../scripts/preprocess.php acpu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -l _acpu.lst _acpu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _acpu.lst _acpu.bin bin 1000
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\zx0 -q -f _acpu.bin _acpu_lz.bin

echo.
echo ===========================================================================
echo Compiling CAVES
echo ===========================================================================
php -f ../scripts/preprocess.php bmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _bmain.lst _bmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _bmain.lst ./release/caves.sav sav
if %ERRORLEVEL% NEQ 0 ( exit /b )

..\scripts\rt11dsk.exe d neon.dsk .\release\caves.sav >NUL
..\scripts\rt11dsk.exe a neon.dsk .\release\caves.sav >NUL

del _acpu.mac
del _acpu.lst
del _acpu.bin
del _acpu_lz.bin
del _bmain.mac
del _bmain.lst

del serial.log
run_neonbtl.bat

echo.