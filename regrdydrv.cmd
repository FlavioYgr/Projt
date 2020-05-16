REM Alrighty then, you wanna use ReadyDriver Plus easily?
REM WELL... LETS GET CRACKIN'!!!

REM Makes the window look nice so you won't close it...
cls
@echo off
TITLE Registering ReadyDriver Plus into the Bootloader

REM Makes sure you KNOW what you are doing
REM And also stops N00Bs from screwing their system up
IF "%1"=="" goto badperam

REM Creates the bootloader entry and writes out the GUID
echo Creating ReadyDriver Plus Bootloader Entry
echo.
bcdedit /create /d "ReadyDriver Plus" /application BOOTSECTOR > OSNUM.txt

REM Parses the BCD output and gets us the GUID
for /f "tokens=2 delims={}" %%a in (OSNUM.txt) do (
set OSNUM=%%a
)

REM Specifies that ReadyDriver Plus is on the boot device
bcdedit /set {%OSNUM%} device partition=%SYSTEMDRIVE% > NUL

REM Tells the Bootloader where ReadyDriver Plus is located
bcdedit /set {%OSNUM%}  PATH \BOOT\boot.bin > NUL

REM Now make it be able to be selected
bcdedit /displayorder {%OSNUM%} /addlast > NUL

echo Created Entry (I Think...)
echo Continuing...
goto del

:badperam
echo SCRIPT ABORTED
echo.
echo This should not be run manually unless
echo you know what you are doing. To force
echo it to run, pass this script a perameter.
echo (Anything will work)
echo.
pause
goto end

:del
REM Oh yeah, let's delete this cause you shouldn't be looking at it
REM del /Q regrdydrv.cmd & exit

:end
REM *claps* And you're done. It's Elementary. ;)