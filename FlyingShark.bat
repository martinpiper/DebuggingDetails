..\c64\acme.exe --lib ..\C64\ --lib ..\C64\IRQDisk\ --msvc -v9 "Flying Shark.a"
c:\work\c64\bin\LZMPi.exe -c64mbu FlyingSharkLoader.prg c:\temp\fs\comp.prg $a09

..\c64\acme.exe --lib ..\C64\ --lib ..\C64\IRQDisk\ --msvc -v9 FlyingSharkBoot.a
c:\work\c64\bin\LZMPi.exe -c64mbu FlyingSharkBoot.prg c:\temp\fs\compboot.prg $c000

c:\work\C1541-Tweaks\c1541\Release\c1541.exe -attach FlyingShark.d64 -format flyingshark,01 -write c:\temp\fs\compboot.prg boot -write c:\temp\fs\comp.prg game -write c:\temp\fs\00.cmp 00 -write c:\temp\fs\01.cmp 01 -write c:\temp\fs\02.cmp 02 -write c:\temp\fs\03.cmp 03 -write c:\temp\fs\04.cmp 04 -write c:\temp\fs\05.cmp 05 -write c:\temp\fs\06.cmp 06 -write c:\temp\fs\07.cmp 07 -write c:\temp\fs\08.cmp 08 -write c:\temp\fs\09.cmp 09 -write c:\temp\fs\0a.cmp 0a -write c:\temp\fs\0b.cmp 0b -write c:\temp\fs\0c.cmp 0c -write c:\temp\fs\0d.cmp 0d -write c:\temp\fs\0e.cmp 0e -write c:\temp\fs\0f.cmp 0f -write c:\temp\fs\10.cmp 10 -write c:\temp\fs\11.cmp 11 -write c:\temp\fs\12.cmp 12 -write c:\temp\fs\13.cmp 13 -write c:\temp\fs\14.cmp 14 -write c:\temp\fs\15.cmp 15
