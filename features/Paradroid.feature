Feature: Extract Paradroid map data

  Uses Vice and the remote debugger to extract Paradroid map data

  @TC-1
  Scenario: [TC-1] Extract map data by intercepting the decompression
    
    Given I run the command line: cmd /c start C:\Downloads\WinVICE-3.1-x86-r34062\WinVICE-3.1-x86-r34062\x64sc.exe -autostartprgmode 1 +autostart-delay-random +VICIIdsize +VICIIdscan -VICIIborders 2 -VICIIfilter 0 +sound -warp -remotemonitor

    Given connect to remote monitor at TCP "127.0.0.1" port "6510"
    When send remote monitor command without parsing "autostart "c:\temp\pd.g64""

    When send remote monitor command without parsing "break 3590"
    When remote monitor wait for hit
    When remote monitor wait for hit


    When send remote monitor command without parsing "del"
    When send remote monitor command without parsing "break 272e"
    When send remote monitor command without parsing "bank ram"


    When send remote monitor command without parsing "> 33 0"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 0.prg" 0 8000 c000"


    When send remote monitor command without parsing "> 33 1"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 1.prg" 0 8000 c000"


    When send remote monitor command without parsing "> 33 2"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 2.prg" 0 8000 c000"

    When send remote monitor command without parsing "> 33 3"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 3.prg" 0 8000 c000"

    When send remote monitor command without parsing "> 33 4"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 4.prg" 0 8000 c000"

    When send remote monitor command without parsing "> 33 5"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 5.prg" 0 8000 c000"

    When send remote monitor command without parsing "> 33 6"
    When send remote monitor command without parsing "g 2727"
    When send remote monitor command without parsing "s "c:\temp\Paradroid level 6.prg" 0 8000 c000"

