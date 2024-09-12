   IFND  DEVICES_PRINTER_I
DEVICES_PRINTER_I EQU   1
   IFND  EXEC_NODES_I
   INCLUDE  "exec/nodes.i"
   ENDC
   IFND  EXEC_LISTS_I
   INCLUDE  "exec/lists.i"
   ENDC
   IFND  EXEC_PORTS_I
   INCLUDE  "exec/ports.i"
   ENDC
   IFND  EXEC_IO_I
   INCLUDE  "exec/io.i"
   ENDC
   DEVINIT
   DEVCMD   PRD_RAWWRITE
   DEVCMD   PRD_PRTCOMMAND
   DEVCMD   PRD_DUMPRPORT
aRIS     EQU    0
aRIN     EQU    1
aIND     EQU    2
aNEL     EQU    3
aRI      EQU    4
aSGR0    EQU    5
aSGR3    EQU    6
aSGR23   EQU    7
aSGR4    EQU    8
aSGR24   EQU    9
aSGR1    EQU   10
aSGR22   EQU   11
aSFC     EQU   12
aSBC     EQU   13
aSHORP0  EQU   14
aSHORP2  EQU   15
aSHORP1  EQU   16
aSHORP4  EQU   17
aSHORP3  EQU   18
aSHORP6  EQU   19
aSHORP5  EQU   20
aDEN6    EQU   21
aDEN5    EQU   22
aDEN4    EQU   23
aDEN3    EQU   24
aDEN2    EQU   25
aDEN1    EQU   26
aSUS2    EQU   27
aSUS1    EQU   28
aSUS4    EQU   29
aSUS3    EQU   30
aSUS0    EQU   31
aPLU     EQU   32
aPLD     EQU   33
aFNT0    EQU   34
aFNT1    EQU   35
aFNT2    EQU   36
aFNT3    EQU   37
aFNT4    EQU   38
aFNT5    EQU   39
aFNT6    EQU   40
aFNT7    EQU   41
aFNT8    EQU   42
aFNT9    EQU   43
aFNT10   EQU   44
aPROP2   EQU   45
aPROP1   EQU   46
aPROP0   EQU   47
aTSS     EQU   48
aJFY5    EQU   49
aJFY7    EQU   50
aJFY6    EQU   51
aJFY0    EQU   52
aJFY2    EQU   53
aJFY3    EQU   54
aVERP0   EQU   55
aVERP1   EQU   56
aSLPP    EQU   57
aPERF    EQU   58
aPERF0   EQU   59
aLMS     EQU   60
aRMS     EQU   61
aTMS     EQU   62
aBMS     EQU   63
aSTBM    EQU   64
aSLRM    EQU   65
aCAM     EQU   66
aHTS     EQU   67
aVTS     EQU   68
aTBC0    EQU   69
aTBC3    EQU   70
aTBC1    EQU   71
aTBC4    EQU   72
aTBCALL  EQU   73
aTBSALL  EQU   74
aEXTEND  EQU   75
 STRUCTURE IOPrtCmdReq,IO_SIZE
    UWORD   io_PrtCommand
    UBYTE   io_Parm0
    UBYTE   io_Parm1
    UBYTE   io_Parm2
    UBYTE   io_Parm3
    LABEL   iopcr_SIZEOF
 STRUCTURE  IODRPReq,IO_SIZE
    APTR    io_RastPort
    APTR    io_ColorMap
    ULONG   io_Modes
    UWORD   io_SrcX
    UWORD   io_SrcY
    UWORD   io_SrcWidth
    UWORD   io_SrcHeight
    LONG    io_DestCols
    LONG    io_DestRows
    UWORD   io_Special
    LABEL   iodrpr_SIZEOF
SPECIAL_MILCOLS      EQU   $01
SPECIAL_MILROWS      EQU   $02
SPECIAL_FULLCOLS     EQU   $04
SPECIAL_FULLROWS     EQU   $08
SPECIAL_FRACCOLS     EQU   $10
SPECIAL_FRACROWS     EQU   $20
SPECIAL_ASPECT       EQU   $80
SPECIAL_DENSITYMASK  EQU   $F00
SPECIAL_DENSITY1     EQU   $100
SPECIAL_DENSITY2     EQU   $200
SPECIAL_DENSITY3     EQU   $300
SPECIAL_DENSITY4     EQU   $400
SPECIAL_CENTER                  EQU     $40
PDERR_CANCEL         EQU   1
PDERR_NOTGRAPHICS    EQU   2
PDERR_INVERTHAM      EQU   3
PDERR_BADDIMENSION   EQU   4
PDERR_DIMENSIONOVFLOW EQU  5
PDERR_INTERNALMEMORY EQU   6
PDERR_BUFFERMEMORY   EQU   7
   ENDC
