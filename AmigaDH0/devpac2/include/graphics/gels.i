	IFND	GRAPHICS_GELS_I
GRAPHICS_GELS_I	SET	1
SUSERFLAGS	EQU	$00FF
VSB_VSPRITE	equ	0
VSF_VSPRITE	equ	1<<0
VSB_SAVEBACK	equ	1
VSF_SAVEBACK	equ	1<<1
VSB_OVERLAY	equ	2
VSF_OVERLAY	equ	1<<2
VSB_MUSTDRAW	equ	3
VSF_MUSTDRAW	equ	1<<3
VSB_BACKSAVED	equ	8
VSF_BACKSAVED	equ	1<<8
VSB_BOBUPDATE	equ	9
VSF_BOBUPDATE	equ	1<<9
VSB_GELGONE	equ	10
VSF_GELGONE	equ	1<<10
VSB_VSOVERFLOW	equ	11
VSF_VSOVERFLOW	equ	1<<11
BUSERFLAGS	EQU	$00FF
BB_SAVEBOB	equ	0
BF_SAVEBOB	equ	1<<0
BB_BOBISCOMP	equ	1
BF_BOBISCOMP	equ	1<<1
BB_BWAITING	equ	8
BF_BWAITING	equ	1<<8
BB_BDRAWN	equ	9
BF_BDRAWN	equ	1<<9
BB_BOBSAWAY	equ	10
BF_BOBSAWAY	equ	1<<10
BB_BOBNIX	equ	11
BF_BOBNIX	equ	1<<11
BB_SAVEPRESERVE	equ	12
BF_SAVEPRESERVE	equ	1<<12
BB_OUTSTEP	equ	13
BF_OUTSTEP	equ	1<<13
ANFRACSIZE	EQU	6
ANIMHALF	EQU	$0020
RINGTRIGGER	EQU	$0001
InitAnimate	MACRO
	CLR.L	\1
	ENDM
RemBob	MACRO
	OR.W	#BF_BOBSAWAY,b_BobFlags+\1
	ENDM
	rsreset
VS	rs.b	0
vs_NextVSprite	rs.l	1
vs_PrevVSprite	rs.l	1
vs_DrawPath	rs.l	1
vs_ClearPath	rs.l	1
vs_Oldy	rs.w	1
vs_Oldx	rs.w	1
vs_VSFlags	rs.w	1
vs_Y	rs.w	1
vs_X	rs.w	1
vs_Height	rs.w	1
vs_Width	rs.w	1
vs_Depth	rs.w	1
vs_MeMask	rs.w	1
vs_HitMask	rs.w	1
vs_ImageData	rs.l	1
vs_BorderLine	rs.l	1
vs_CollMask	rs.l	1
vs_SprColors	rs.l	1
vs_VSBob	rs.l	1
vs_PlanePick	rs.b	1
vs_PlaneOnOff	rs.b	1
vs_SUserExt	rs.w	0
vs_SIZEOF	rs.w	0
	rsreset
BOB	rs.b	0
bob_BobFlags	rs.w	1
bob_SaveBuffer	rs.l	1
bob_ImageShadow	rs.l	1
bob_Before	rs.l	1
bob_After	rs.l	1
bob_BobVSprite	rs.l	1
bob_BobComp	rs.l	1
bob_DBuffer	rs.l	1
bob_BUserExt	rs.w	0
bob_SIZEOF	rs.w	0
	rsreset
AC	rs.b	0
ac_CompFlags	rs.w	1
ac_Timer	rs.w	1
ac_TimeSet	rs.w	1
ac_NextComp	rs.l	1
ac_PrevComp	rs.l	1
ac_NextSeq	rs.l	1
ac_PrevSeq	rs.l	1
ac_AnimCRoutine	rs.l	1
ac_YTrans	rs.w	1
ac_XTrans	rs.w	1
ac_HeadOb	rs.l	1
ac_AnimBob	rs.l	1
ac_SIZE	rs.w	0
	rsreset
AO	rs.b	0
ao_NextOb	rs.l	1
ao_PrevOb	rs.l	1
ao_Clock	rs.l	1
ao_AnOldY	rs.w	1
ao_AnOldX	rs.w	1
ao_AnY	rs.w	1
ao_AnX	rs.w	1
ao_YVel	rs.w	1
ao_XVel	rs.w	1
ao_XAccel	rs.w	1
ao_YAccel	rs.w	1
ao_RingYTrans	rs.w	1
ao_RingXTrans	rs.w	1
ao_AnimORoutine	rs.l	1
ao_HeadComp	rs.l	1
ao_AUserExt	rs.w	0
ao_SIZEOF	rs.w	0
	rsreset
DBP	rs.b	0
dbp_BufY	rs.w	1
dbp_BufX	rs.w	1
dbp_BufPath	rs.l	1
dbp_BufBuffer	rs.l	1
dbp_BufPlanes	rs.l	1
dbp_SIZEOF	rs.w	0
	ENDC

