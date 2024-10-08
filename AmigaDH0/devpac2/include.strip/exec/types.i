    IFND EXEC_TYPES_I
EXEC_TYPES_I SET 1
EXTERN_LIB  MACRO
     XREF    _LVO\1
     ENDM
STRUCTURE   MACRO
\1          EQU     0
SOFFSET     SET     \2
     ENDM
BOOL        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+2
     ENDM
BYTE        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+1
     ENDM
UBYTE       MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+1
     ENDM
WORD        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+2
     ENDM
UWORD       MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+2
     ENDM
SHORT        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+2
     ENDM
USHORT      MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+2
     ENDM
LONG        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+4
     ENDM
ULONG       MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+4
     ENDM
FLOAT       MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+4
     ENDM
APTR        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+4
     ENDM
CPTR        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+4
     ENDM
RPTR        MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+2
     ENDM
STRUCT      MACRO
\1          EQU     SOFFSET
SOFFSET     SET     SOFFSET+\2
     ENDM
LABEL       MACRO
\1          EQU     SOFFSET
     ENDM
BITDEF      MACRO   *
     BITDEF0 \1,\2,B_,\3
\@BITDEF    SET     1<<\3
     BITDEF0 \1,\2,F_,\@BITDEF
     ENDM
BITDEF0     MACRO   *
\1\3\2      EQU     \4
     ENDM
LIBRARY_VERSION EQU     33
    ENDC EXEC_TYPES_I
