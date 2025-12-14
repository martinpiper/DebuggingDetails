@echo off
del ImpossibleMissionSetSeed.prg

set COMPOPT=-c64mbu
set COMMONLIB=--lib ..\..\C64\ --lib ..\..\c64\IRQTape\TapeTool\ --lib ..\..\c64\IRQTape\ -v4 --msvc

..\..\C64\acme.exe %COMMONLIB% -f cbm -o ImpossibleMissionSetSeed.prg SetSeed.a
if not exist ImpossibleMissionSetSeed.prg goto error
goto next
:error
echo There was an error!
exit /B -1
:next

..\..\C64\bin\LZMPi.exe %COMPOPT% ImpossibleMissionSetSeed.prg ImpossibleMissionSetSeed.prg $4ae
