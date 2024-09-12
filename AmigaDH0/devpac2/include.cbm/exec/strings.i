    IFND EXEC_STRINGS_I
EXEC_STRINGS_I SET 1
**********************************************************************
*
*   Commodore Amiga -- ROM Operating System Executive Include File
*
**********************************************************************
*
*   Source Control:
*
*       $Header: strings.i,v 1.0 85/08/28 15:14:06 carl Exp $
*
*       $Locker:  $
*
**********************************************************************


*------ Terminal Control:

EOS             EQU     0
BELL            EQU     7
LF              EQU     10
CR              EQU     13
BS              EQU     8
DEL             EQU     $7F
NL              EQU     LF


*----------------------------------------------------------------
*
*   String Support Macros
*
*----------------------------------------------------------------

STRING      MACRO
            DC.B    \1
            DC.B    0
            CNOP    0,2
            ENDM


STRINGL     MACRO
            DC.B    13,10
            DC.B    \1
            DC.B    0
            CNOP    0,2
            ENDM


STRINGR     MACRO
            DC.B    \1
            DC.B    13,10,0
            CNOP    0,2
            ENDM


STRINGLR    MACRO
            DC.B    13,10
            DC.B    \1
            DC.B    13,10,0
            CNOP    0,2
            ENDM

    ENDC !EXEC_STRINGS_I
