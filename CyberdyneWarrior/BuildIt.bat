@echo off
del Picture1.prg Picture2.prg Picture3.prg Intro.prg Game.prg cyberdyne.tap

set COMPOPT=-c64mbu
set COMMONLIB=--lib ..\..\C64\ --lib ..\..\c64\IRQTape\TapeTool\ --lib ..\..\c64\IRQTape\ -v4 --msvc

rem Assemble with disk support
echo !source "CommonLoadCallDisk.a" >CommonLoadCall.a

..\..\C64\acme.exe --lib ..\..\C64\ -f cbm -o Picture1.prg PictureLink.a Picture1.a
if not exist Picture1.prg goto error
goto next
:error
echo There was an error!
exit /B -1
:next

..\..\C64\acme.exe %COMMONLIB% -f cbm -o Picture2.prg PictureLink.a Picture2.a
if not exist Picture2.prg goto error

..\..\C64\acme.exe %COMMONLIB% -f cbm -o Picture3.prg PictureLink.a Picture3.a
if not exist Picture3.prg goto error

..\..\C64\acme.exe %COMMONLIB% -f cbm -o Intro.prg IntroLink.a
if not exist Intro.prg goto error


..\..\C64\bin\LZMPi.exe %COMPOPT% Picture1.prg Picture1.prg $c000
..\..\C64\bin\LZMPi.exe %COMPOPT% Picture2.prg Picture2.prg $c000
..\..\C64\bin\LZMPi.exe %COMPOPT% Picture3.prg Picture3.prg $c000
..\..\C64\bin\LZMPi.exe -pp $37 %COMPOPT% Intro.prg Intro.prg $2a00
..\..\C64\bin\LZMPi.exe %COMPOPT% Data\cw80d.prg Game.prg $80d

..\..\C64\ExternalTools\C1541\c1541.exe -attach CyberdyneWarriorLoadingIntro.d64 -format CybWar,12 -write Picture1.prg p1 -write Picture2.prg p2 -write Picture3.prg p3 -write Intro.prg p4 -write Game.prg p5


echo Tape file generation

rem Assemble with tape support
echo !source "CommonLoadCallTape.a" >CommonLoadCall.a

del Loaders.bin Picture1.prg Picture2.prg Picture3.prg Intro.prg

..\..\C64\acme.exe %COMMONLIB% TapeOptions.a TapeOptionsMessages.a Loaders.a
if not exist Loaders.bin goto error
..\..\C64\acme.exe %COMMONLIB% -f cbm -o Picture1.prg PictureLink.a Picture1.a
if not exist Picture1.prg goto error
..\..\C64\acme.exe %COMMONLIB% -f cbm -o Picture2.prg PictureLink.a Picture2.a
if not exist Picture2.prg goto error
..\..\C64\acme.exe %COMMONLIB% -f cbm -o Picture3.prg PictureLink.a Picture3.a
if not exist Picture3.prg goto error
..\..\C64\acme.exe %COMMONLIB% -f cbm -o Intro.prg IntroLink.a
if not exist Intro.prg goto error

..\..\C64\bin\LZMPi.exe %COMPOPT% Picture1.prg Picture1.prg $c000
..\..\C64\bin\LZMPi.exe %COMPOPT% Picture2.prg Picture2.prg $c000
..\..\C64\bin\LZMPi.exe %COMPOPT% Picture3.prg Picture3.prg $c000
..\..\C64\bin\LZMPi.exe -pp $37 %COMPOPT% Intro.prg Intro.prg $2a00

rem Writes the kernal auto-run data
..\..\C64\bin\TapeTool.exe n 1 wn "cyberdyne.tap" m "Loaders.map" ocb1 Loaders.bin c

rem Writes the first turbo data, the main loader, with the "TinyHeader" option
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otft "Loaders.bin" .RealCodeStart .RealCodeEnd c

rem Write the rest of the file data, without any block compression, all the data files are compressed so there would be no gain
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otfb "Loaders.bin" 0 .SpriteDataStart .SpriteDataEnd $200 c
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otfb "Picture1.prg" 1 c
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otfb "Picture2.prg" 2 c
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otfb "Picture3.prg" 3 c
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otfb "Intro.prg" 4 c
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 otfb "Game.prg" 5 c
rem Writes a final lead out at the end of the tape
..\..\C64\bin\TapeTool.exe n 1 w  "cyberdyne.tap" a m "Loaders.map" otl$c0 c

