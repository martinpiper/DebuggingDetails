   IFND  DEVICES_PRINTER_I
DEVICES_PRINTER_I EQU   1
********************************************************************
*               Commodore-Amiga, Inc.                              *
*               printer.i                                          *
********************************************************************
********************************************************************
*
*  printer device command definitions
*
*   Source Control
*   --------------
*   $Header: printer.i,v 1.2 85/12/06 12:30:08 kodiak Exp $
*
*   $Locker:  $
*
********************************************************************

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

;****** printer definitions
aRIS     EQU    0 ; ESCc  reset                       ISO
aRIN     EQU    1 ; ESC#1 initialize                  +++
aIND     EQU    2 ; ESCD  lf                          ISO
aNEL     EQU    3 ; ESCE  return,lf                   ISO
aRI      EQU    4 ; ESCM  reverse lf                  ISO

aSGR0    EQU    5 ; ESC[0m normal char set            ISO    
aSGR3    EQU    6 ; ESC[3m italics on                 ISO        
aSGR23   EQU    7 ; ESC[23m italics off               ISO
aSGR4    EQU    8 ; ESC[4m underline on               ISO
aSGR24   EQU    9 ; ESC[24m underline off             ISO
aSGR1    EQU   10 ; ESC[1m boldface on                ISO
aSGR22   EQU   11 ; ESC[22m boldface off              ISO
aSFC     EQU   12 ; SGR30-39  set foreground color    ISO
aSBC     EQU   13 ; SGR40-49  set background color    ISO

aSHORP0  EQU   14 ; ESC[0w normal pitch               DEC
aSHORP2  EQU   15 ; ESC[2w elite on                   DEC
aSHORP1  EQU   16 ; ESC[1w elite off                  DEC
aSHORP4  EQU   17 ; ESC[4w condensed fine on          DEC
aSHORP3  EQU   18 ; ESC[3w condensed off              DEC
aSHORP6  EQU   19 ; ESC[6w enlarged on                DEC
aSHORP5  EQU   20 ; ESC[5w enlarged off               DEC

aDEN6    EQU   21 ; ESC[6"z shadow print on           DEC (sort of)
aDEN5    EQU   22 ; ESC[5"z shadow print off          DEC
aDEN4    EQU   23 ; ESC[4"z doublestrike on           DEC
aDEN3    EQU   24 ; ESC[3"z doublestrike off          DEC
aDEN2    EQU   25 ; ESC[2"z  NLQ on                   DEC
aDEN1    EQU   26 ; ESC[1"z  NLQ off                  DEC

aSUS2    EQU   27 ; ESC[2v superscript on             +++
aSUS1    EQU   28 ; ESC[1v superscript off            +++
aSUS4    EQU   29 ; ESC[4v subscript on               +++
aSUS3    EQU   30 ; ESC[3v subscript off              +++
aSUS0    EQU   31 ; ESC[0v normalize the line         +++
aPLU     EQU   32 ; ESCL  partial line up             ISO
aPLD     EQU   33 ; ESCK  partial line down           ISO

aFNT0    EQU   34 ; ESC(B US char set                 DEC
aFNT1    EQU   35 ; ESC(R French char set             DEC
aFNT2    EQU   36 ; ESC(K German char set             DEC
aFNT3    EQU   37 ; ESC(A UK char set                 DEC
aFNT4    EQU   38 ; ESC(E Danish I char set           DEC
aFNT5    EQU   39 ; ESC(H Sweden char set             DEC
aFNT6    EQU   40 ; ESC(Y Italian char set            DEC
aFNT7    EQU   41 ; ESC(Z Spanish char set            DEC
aFNT8    EQU   42 ; ESC(J Japanese char set           +++
aFNT9    EQU   43 ; ESC(6 Norweign char set           DEC
aFNT10   EQU   44 ; ESC(C Danish II char set          +++
                              
aPROP2   EQU   45 ; ESC[2p  proportional on           +++
aPROP1   EQU   46 ; ESC[1p  proportional off          +++
aPROP0   EQU   47 ; ESC[0p  proportional clear        +++
aTSS     EQU   48 ; ESC[n E set proportional offset   ISO
aJFY5    EQU   49 ; ESC[5 F auto left justify         ISO
aJFY7    EQU   50 ; ESC[7 F auto right justiy         ISO
aJFY6    EQU   51 ; ESC[6 F auto full justify         ISO
aJFY0    EQU   52 ; ESC[0 F auto justify off          ISO
aJFY2    EQU   53 ; ESC[2 F  word space(auto center)  ISO (special)
aJFY3    EQU   54 ; ESC[3 F letter space (justify)    ISO (special)

aVERP0   EQU   55 ; ESC[0z  1/8" line spacing         +++
aVERP1   EQU   56 ; ESC[1z  1/6" line spacing         +++
aSLPP    EQU   57 ; ESC[nt  set form length n         DEC
aPERF    EQU   58 ; ESC[nq  perf skip n (n>0)         +++
aPERF0   EQU   59 ; ESC[0q  perf skip off             +++
                        
aLMS     EQU   60 ; ESC#9  Left margin set            +++
aRMS     EQU   61 ; ESC#0  Right margin set           +++
aTMS     EQU   62 ; ESC#8  Top margin set             +++
aBMS     EQU   63 ; ESC#2  Bottom marg set            +++
aSTBM    EQU   64 ; ESC[Pn1;Pn2r  T&B margins         DEC
aSLRM    EQU   65 ; ESC[Pn1;Pn2s  L&R margin          DEC
aCAM     EQU   66 ; ESC#3  Clear margins              +++

aHTS     EQU   67 ; ESCH    Set horiz tab             ISO
aVTS     EQU   68 ; ESCJ    Set vertical tabs         ISO
aTBC0    EQU   69 ; ESC[0g  Clr horiz tab             ISO
aTBC3    EQU   70 ; ESC[3g  Clear all h tab           ISO
aTBC1    EQU   71 ; ESC[1g  Clr vertical tabs         ISO
aTBC4    EQU   72 ; ESC[4g  Clr all v tabs            ISO
aTBCALL  EQU   73 ; ESC#4   Clr all h & v tabs        +++
aTBSALL  EQU   74 ; ESC#5   Set default tabs          +++
aEXTEND  EQU   75 ; ESC[Pn"x extended commands        +++ 


 STRUCTURE IOPrtCmdReq,IO_SIZE
    UWORD   io_PrtCommand  ; printer command
    UBYTE   io_Parm0    ; first command parameter
    UBYTE   io_Parm1    ; second command parameter
    UBYTE   io_Parm2    ; third command parameter
    UBYTE   io_Parm3    ; fourth command parameter
    LABEL   iopcr_SIZEOF

 STRUCTURE  IODRPReq,IO_SIZE
    APTR    io_RastPort    ; raster port
    APTR    io_ColorMap    ; color map
    ULONG   io_Modes       ; graphics viewport modes
    UWORD   io_SrcX        ; source x origin
    UWORD   io_SrcY        ; source y origin
    UWORD   io_SrcWidth    ; source x width
    UWORD   io_SrcHeight   ; source x height
    LONG    io_DestCols    ; destination x width
    LONG    io_DestRows    ; destination y height
    UWORD   io_Special     ; option flags
    LABEL   iodrpr_SIZEOF

SPECIAL_MILCOLS      EQU   $01   ; DestCols specified in 1/1000"
SPECIAL_MILROWS      EQU   $02   ; DestRows specified in 1/1000"
SPECIAL_FULLCOLS     EQU   $04   ; make DestCols maximum possible
SPECIAL_FULLROWS     EQU   $08   ; make DestRows maximum possible
SPECIAL_FRACCOLS     EQU   $10   ; DestCols is fraction of FULLCOLS
SPECIAL_FRACROWS     EQU   $20   ; DestRows is fraction of FULLROWS
SPECIAL_ASPECT       EQU   $80   ; ensure correct aspect ratio
SPECIAL_DENSITYMASK  EQU   $F00  ; masks out density bits
SPECIAL_DENSITY1     EQU   $100  ; lowest res
SPECIAL_DENSITY2     EQU   $200  ; next res
SPECIAL_DENSITY3     EQU   $300  ; next res
SPECIAL_DENSITY4     EQU   $400  ; highest res
SPECIAL_CENTER                  EQU     $40     ; center image

PDERR_CANCEL         EQU   1  ; user canceled a printer timeout
PDERR_NOTGRAPHICS    EQU   2  ; printer cannot output graphics
PDERR_INVERTHAM      EQU   3  ; cannot invert hold & modify print
PDERR_BADDIMENSION   EQU   4  ; print dimensions illegal
PDERR_DIMENSIONOVFLOW EQU  5  ; print dimensions too large
PDERR_INTERNALMEMORY EQU   6  ; no memory for internal variables
PDERR_BUFFERMEMORY   EQU   7  ; no memory for print buffer

   ENDC
