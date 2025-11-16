@echo off
del Picture1.prg Picture2.prg Intro.prg Game.prg

set COMPOPT=-c64mbu

..\..\C64\acme.exe --lib ..\..\C64\ -v4 --msvc -f cbm -o Picture1.prg PictureLink.a Picture1.a
if not exist Picture1.prg goto error
goto next
:error
echo There was an error!
exit /B -1
:next

..\..\C64\acme.exe --lib ..\..\C64\ -v4 --msvc -f cbm -o Picture2.prg PictureLink.a Picture2.a
if not exist Picture2.prg goto error

..\..\C64\acme.exe --lib ..\..\C64\ -v4 --msvc -f cbm -o Picture3.prg PictureLink.a Picture3.a
if not exist Picture3.prg goto error

..\..\C64\acme.exe --lib ..\..\C64\ -v4 --msvc -f cbm -o Intro.prg IntroLink.a
if not exist Intro.prg goto error


..\..\C64\bin\LZMPi.exe %COMPOPT% Picture1.prg Picture1.prg $c000
..\..\C64\bin\LZMPi.exe %COMPOPT% Picture2.prg Picture2.prg $c000
..\..\C64\bin\LZMPi.exe %COMPOPT% Picture3.prg Picture3.prg $c000
..\..\C64\bin\LZMPi.exe -pp $37 %COMPOPT% Intro.prg Intro.prg $2a00
..\..\C64\bin\LZMPi.exe %COMPOPT% Data\cw80d.prg Game.prg $80d

..\..\C64\ExternalTools\C1541\c1541.exe -attach CyberdyneWarriorLoadingIntro.d64 -format CybWar,12 -write Picture1.prg p1 -write Picture2.prg p2 -write Picture3.prg p3 -write Intro.prg p4 -write Game.prg p5
