@echo off
del HTWAM.prg

..\..\C64\acme.exe --lib ..\..\C64\ -v4 --msvc HTWAM4.a
if not exist HTWAM.prg goto error
..\..\C64\bin\LZMPi.exe -c64mu HTWAM.prg HTWAM.prg $800 >t.txt
if not exist HTWAM.prg goto error
goto end
:error
echo HTWAM.prg not created!
exit /B -1
:end
