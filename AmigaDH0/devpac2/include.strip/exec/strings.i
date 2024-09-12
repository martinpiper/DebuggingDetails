    IFND EXEC_STRINGS_I
EXEC_STRINGS_I SET 1
EOS             EQU     0
BELL            EQU     7
LF              EQU     10
CR              EQU     13
BS              EQU     8
DEL             EQU     $7F
NL              EQU     LF
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
