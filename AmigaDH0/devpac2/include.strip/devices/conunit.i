 IFND    DEVICES_CONUNIT_I
DEVICES_CONUNIT_I       EQU     1
   IFND  EXEC_PORTS_I
   INCLUDE  "exec/ports.i"
   ENDC
   IFND  DEVICES_KEYMAP_I
   INCLUDE  "devices/keymap.i"
   ENDC
PMB_ASM     EQU   M_LNM+1
PMB_AWM     EQU   PMB_ASM+1
MAXTABS     EQU   80
 STRUCTURE  ConUnit,MP_SIZE
   APTR  cu_Window
   WORD  cu_XCP
   WORD  cu_YCP
   WORD  cu_XMax
   WORD  cu_YMax
   WORD  cu_XRSize
   WORD  cu_YRSize
   WORD  cu_XROrigin
   WORD  cu_YROrigin
   WORD  cu_XRExtant
   WORD  cu_YRExtant
   WORD  cu_XMinShrink
   WORD  cu_YMinShrink
   WORD  cu_XCCP
   WORD  cu_YCCP
   STRUCT   cu_KeyMapStruct,km_SIZEOF
   STRUCT   cu_TabStops,2*MAXTABS
   BYTE  cu_Mask
   BYTE  cu_FgPen
   BYTE  cu_BgPen
   BYTE  cu_AOLPen
   BYTE  cu_DrawMode
   BYTE  cu_AreaPtSz
   APTR  cu_AreaPtrn
   STRUCT   cu_Minterms,8
   APTR  cu_Font
   UBYTE cu_AlgoStyle
   UBYTE cu_TxFlags
   UWORD cu_TxHeight
   UWORD cu_TxWidth
   UWORD cu_TxBaseline
   UWORD cu_TxSpacing
   STRUCT   cu_Modes,<(PMB_AWM+7)/8>
   STRUCT   cu_RawEvents,<(IECLASS_MAX+7)/8>
ODDEVEN  EQU   ((PMB_AWM+7)/8)+((IECLASS_MAX+7)/8)
   IFNE  ODDEVEN-((ODDEVEN/2)*2)
      UBYTE cu_pad
   ENDC
   LABEL ConUnit_SIZEOF
 ENDC
