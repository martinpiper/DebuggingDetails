    IFND    GRAPHICS_GFXBASE_I
GRAPHICS_GFXBASE_I  SET 1
    IFND    EXEC_LISTS_I
    include 'exec/lists.i'
    ENDC
    IFND    EXEC_LIBRARIES_I
    include 'exec/libraries.i'
    ENDC
    IFND    EXEC_INTERRUPTS_I
    include 'exec/interrupts.i'
    ENDC
 STRUCTURE  GfxBase,LIB_SIZE
    APTR    gb_ActiView
    APTR    gb_copinit
    APTR    gb_cia
    APTR    gb_blitter
    APTR    gb_LOFlist
    APTR    gb_SHFlist
    APTR    gb_blthd
    APTR    gb_blttl
    APTR    gb_bsblthd
    APTR    gb_bsblttl
    STRUCT  gb_vbsrv,IS_SIZE
    STRUCT  gb_timsrv,IS_SIZE
    STRUCT  gb_bltsrv,IS_SIZE
    STRUCT  gb_TextFonts,LH_SIZE
    APTR    gb_DefaultFont
    UWORD   gb_Modes
    BYTE    gb_VBlank
    BYTE    gb_Debug
    UWORD   gb_BeamSync
    WORD    gb_system_bplcon0
    BYTE    gb_SpriteReserved
    BYTE    gb_bytereserved
    WORD    gb_Flags
    WORD    gb_BlitLock
 WORD    gb_BlitNest
 STRUCT  gb_BlitWaitQ,LH_SIZE
 APTR    gb_BlitOwner
 STRUCT  gb_TOF_WaitQ,LH_SIZE
 WORD    gb_DisplayFlags
 APTR    gb_SimpleSprites
 WORD    gb_MaxDisplayRow
 WORD    gb_MaxDisplayColumn
 WORD    gb_NormalDisplayRows
 WORD    gb_NormalDisplayColumns
 WORD    gb_NormalDPMX
 WORD    gb_NormalDPMY
 APTR    gb_LastChanceMemory
 APTR    gb_LCMptr
 WORD    gb_MicrosPerLine
    STRUCT  gb_reserved,8
    LABEL   gb_SIZE
OWNBLITTERn equ 0
QBOWNERn    equ 1
QBOWNER     equ 1<<QBOWNERn
    ENDC
