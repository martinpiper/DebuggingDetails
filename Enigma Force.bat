..\c64\acme.exe --lib ..\C64\ --msvc -v9 "Enigma Force.a"
c:\work\c64\bin\LZMPi.exe -pp $37 -c64mbu "Enigma Force 4000.prg" EnigmaForceMouse1.prg $4000

..\c64\acme.exe --lib ..\C64\ --msvc -v9 "Enigma Force with pic.a"
c:\work\c64\bin\LZMPi.exe -pp $37 -c64mbu "Enigma Force with pic.prg" EnigmaForceMouse1WithPic.prg $200

C:\Downloads\WinVICE-3.1-x86-r34062\WinVICE-3.1-x86-r34062\x64sc.exe -controlport1device 3 -remotemonitor EnigmaForceMouse1WithPic.prg
