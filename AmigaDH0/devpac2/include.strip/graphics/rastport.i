
    IFND    GRAPHICS_RASTPORT_I
GRAPHICS_RASTPORT_I SET 1
    IFND    GRAPHICS_GFX_I
       include 'graphics/gfx.i'
    ENDC
 STRUCTURE  TmpRas,0
   APTR     tr_RasPtr
   LONG     tr_Size
   LABEL    tr_SIZEOF
   STRUCTURE   GelsInfo,0
   BYTE     gi_sprRsrvd
   BYTE     gi_Flags
   APTR     gi_gelHead
   APTR     gi_gelTail
   APTR     gi_nextLine
   APTR     gi_lastColor
   APTR     gi_collHandler
   SHORT    gi_leftmost
   SHORT    gi_rightmost
   SHORT    gi_topmost
   SHORT    gi_bottommost
   APTR     gi_firstBlissObj
   APTR     gi_lastBlissObj
   LABEL    gi_SIZEOF
   BITDEF   RP,FRST_DOT,0
   BITDEF   RP,ONE_DOT,1
   BITDEF   RP,DBUFFER,2
   BITDEF   RP,AREAOUTLINE,3
   BITDEF   RP,NOCROSSFILL,5
RP_JAM1        EQU 0
RP_JAM2        EQU 1
RP_COMPLEMENT  EQU 2
RP_INVERSVID   EQU 4
   BITDEF  RP,TXSCALE,0
 STRUCTURE  RastPort,0
   LONG     rp_Layer
   LONG     rp_BitMap
   LONG     rp_AreaPtrn
   LONG     rp_TmpRas
   LONG     rp_AreaInfo
   LONG     rp_GelsInfo
   BYTE     rp_Mask
   BYTE     rp_FgPen
   BYTE     rp_BgPen
   BYTE     rp_AOLPen
   BYTE     rp_DrawMode
   BYTE     rp_AreaPtSz
   BYTE     rp_Dummy
   BYTE     rp_linpatcnt
   WORD     rp_Flags
   WORD     rp_LinePtrn
   WORD     rp_cp_x
   WORD     rp_cp_y
   STRUCT   rp_minterms,8
   WORD     rp_PenWidth
   WORD     rp_PenHeight
   LONG     rp_Font
   BYTE     rp_AlgoStyle
   BYTE     rp_TxFlags
   WORD     rp_TxHeight
   WORD     rp_TxWidth
   WORD     rp_TxBaseline
   WORD     rp_TxSpacing
   APTR     rp_RP_User
   STRUCT   rp_longreserved,8
 ifnd    GFX_RASTPORT_1_2
   STRUCT   rp_wordreserved,14
   STRUCT   rp_reserved,8
 endc
   LABEL    rp_SIZEOF
 STRUCTURE  AreaInfo,0
   LONG     ai_VctrTbl
   LONG     ai_VctrPtr
   LONG     ai_FlagTbl
   LONG     ai_FlagPtr
   WORD     ai_Count
   WORD     ai_MaxCount
   WORD     ai_FirstX
   WORD     ai_FirstY
   LABEL    ai_SIZEOF
ONE_DOTn    equ     1
ONE_DOT     equ     $2
FRST_DOTn   equ     0
FRST_DOT    equ     1
    ENDC
