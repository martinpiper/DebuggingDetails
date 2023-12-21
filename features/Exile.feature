Feature: Test scenarios for Exile

  Uses Vice and the remote debugger to test Exile related code changes

  @TC-1
  Scenario: [TC-1] Test the sprite cache behaviour
    
    Given I run the command line: ..\C64\acme.exe --lib ..\C64\ Exile.a
    Given I run the command line: cmd /c start C:\Downloads\WinVICE-3.1-x86-r34062\WinVICE-3.1-x86-r34062\x64sc.exe -autostartprgmode 1 +autostart-delay-random +VICIIdsize +VICIIdscan -VICIIborders 2 -VICIIfilter 0 +sound +warp -remotemonitor    

    Given connect to remote monitor at TCP "127.0.0.1" port "6510"
    When send remote monitor command without parsing "bank ram"
    When send remote monitor command without parsing "l "c:\temp\exile 560e.prg" 0"
    When send remote monitor command without parsing "break f40a"
    When send remote monitor command without parsing "g 560e"
    When remote monitor wait for hit

    When send remote monitor command without parsing "del"
    When send remote monitor command without parsing "l "%WCD%\Exile.prg" 0"
    When send remote monitor command without parsing "g 4800"

