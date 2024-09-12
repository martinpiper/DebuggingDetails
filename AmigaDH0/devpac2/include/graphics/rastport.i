	IFND	GRAPHICS_RASTPORT_I
GRAPHICS_RASTPORT_I	SET	1
	IFND	GRAPHICS_GFX_I
	INCLUDE	'graphics/gfx.i'
	ENDC
	rsreset
TmpRas	rs.b	0
tr_RasPtr	rs.l	1
tr_Size	rs.l	1
tr_SIZEOF	rs.w	0
	rsreset
GelsInfo	rs.b	0
gi_sprRsrvd	rs.b	1
gi_Flags	rs.b	1
gi_gelHead	rs.l	1
gi_gelTail	rs.l	1
gi_nextLine	rs.l	1
gi_lastColor	rs.l	1
gi_collHandler	rs.l	1
gi_leftmost	rs.w	1
gi_rightmost	rs.w	1
gi_topmost	rs.w	1
gi_bottommost	rs.w	1
gi_firstBlissObj	rs.l	1
gi_lastBlissObj	rs.l	1
gi_SIZEOF	rs.w	0
RPB_FRST_DOT	equ	0
RPF_FRST_DOT	equ	1<<0
RPB_ONE_DOT	equ	1
RPF_ONE_DOT	equ	1<<1
RPB_DBUFFER	equ	2
RPF_DBUFFER	equ	1<<2
RPB_AREAOUTLINE	equ	3
RPF_AREAOUTLINE	equ	1<<3
RPB_NOCROSSFILL	equ	5
RPF_NOCROSSFILL	equ	1<<5
RP_JAM1	EQU	0
RP_JAM2	EQU	1
RP_COMPLEMENT	EQU	2
RP_INVERSVID	EQU	4
RPB_TXSCALE	equ	0
RPF_TXSCALE	equ	1<<0
	rsreset
RastPort	rs.b	0
rp_Layer	rs.l	1
rp_BitMap	rs.l	1
rp_AreaPtrn	rs.l	1
rp_TmpRas	rs.l	1
rp_AreaInfo	rs.l	1
rp_GelsInfo	rs.l	1
rp_Mask	rs.b	1
rp_FgPen	rs.b	1
rp_BgPen	rs.b	1
rp_AOLPen	rs.b	1
rp_DrawMode	rs.b	1
rp_AreaPtSz	rs.b	1
rp_Dummy	rs.b	1
rp_linpatcnt	rs.b	1
rp_Flags	rs.w	1
rp_LinePtrn	rs.w	1
rp_cp_x	rs.w	1
rp_cp_y	rs.w	1
rp_minterms	rs.b	8
rp_PenWidth	rs.w	1
rp_PenHeight	rs.w	1
rp_Font	rs.l	1
rp_AlgoStyle	rs.b	1
rp_TxFlags	rs.b	1
rp_TxHeight	rs.w	1
rp_TxWidth	rs.w	1
rp_TxBaseline	rs.w	1
rp_TxSpacing	rs.w	1
rp_RP_User	rs.l	1
rp_longreserved	rs.b	8
	IFND	GFX_RASTPORT_1_2
rp_wordreserved	rs.b	14
rp_reserved	rs.b	8
	endc
rp_SIZEOF	rs.w	0
	rsreset
AreaInfo	rs.b	0
ai_VctrTbl	rs.l	1
ai_VctrPtr	rs.l	1
ai_FlagTbl	rs.l	1
ai_FlagPtr	rs.l	1
ai_Count	rs.w	1
ai_MaxCount	rs.w	1
ai_FirstX	rs.w	1
ai_FirstY	rs.w	1
ai_SIZEOF	rs.w	0
ONE_DOTn	equ	1
ONE_DOT	equ	$2
FRST_DOTn	equ	0
FRST_DOT	equ	1
	ENDC

