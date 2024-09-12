	IFND	EXEC_ALERTS_I
EXEC_ALERTS_I	SET	1
SB_ALERTWACK	equ	1
SF_ALERTWACK	equ	1<<1
ALERT	macro
	movem.l	d7/a5/a6,-(sp)
	move.l	#\1,d7
	IFNC	'\2',''
	lea	\2,a5
	ENDC
	move.l	4,a6
	jsr	_LVOAlert(a6)
	movem.l	(sp)+,d7/a5/a6
	endm
AT_DeadEnd	equ	$80000000
AT_Recovery	equ	$00000000
AG_NoMemory	equ	$00010000
AG_MakeLib	equ	$00020000
AG_OpenLib	equ	$00030000
AG_OpenDev	equ	$00040000
AG_OpenRes	equ	$00050000
AG_IOError	equ	$00060000
AG_NoSignal	equ	$00070000
AO_ExecLib	equ	$00008001
AO_GraphicsLib	equ	$00008002
AO_LayersLib	equ	$00008003
AO_Intuition	equ	$00008004
AO_MathLib	equ	$00008005
AO_CListLib	equ	$00008006
AO_DOSLib	equ	$00008007
AO_RAMLib	equ	$00008008
AO_IconLib	equ	$00008009
AO_ExpansionLib	equ	$0000800A
AO_AudioDev	equ	$00008010
AO_ConsoleDev	equ	$00008011
AO_GamePortDev	equ	$00008012
AO_KeyboardDev	equ	$00008013
AO_TrackDiskDev	equ	$00008014
AO_TimerDev	equ	$00008015
AO_CIARsrc	equ	$00008020
AO_DiskRsrc	equ	$00008021
AO_MiscRsrc	equ	$00008022
AO_BootStrap	equ	$00008030
AO_Workbench	equ	$00008031
AN_ExecLib	equ	$01000000
AN_ExcptVect	equ	$81000001
AN_BaseChkSum	equ	$81000002
AN_LibChkSum	equ	$81000003
AN_LibMem	equ	$81000004
AN_MemCorrupt	equ	$81000005
AN_IntrMem	equ	$81000006
AN_InitAPtr	equ	$81000007
AN_SemCorrupt	equ	$81000008
AN_FreeTwice	equ	$81000009
AN_BogusExcpt	equ	$8100000A
AN_GraphicsLib	equ	$02000000
AN_GfxNoMem	equ	$82010000
AN_LongFrame	equ	$82010006
AN_ShortFrame	equ	$82010007
AN_TextTmpRas	equ	$02010009
AN_BltBitMap	equ	$8201000A
AN_RegionMemory	equ	$8201000B
AN_MakeVPort	equ	$82010030
AN_GfxNoLCM	equ	$82011234
AN_LayersLib	equ	$03000000
AN_LayersNoMem	equ	$83010000
AN_Intuition	equ	$04000000
AN_GadgetType	equ	$84000001
AN_BadGadget	equ	$04000001
AN_CreatePort	equ	$84010002
AN_ItemAlloc	equ	$04010003
AN_SubAlloc	equ	$04010004
AN_PlaneAlloc	equ	$84010005
AN_ItemBoxTop	equ	$84000006
AN_OpenScreen	equ	$84010007
AN_OpenScrnRast	equ	$84010008
AN_SysScrnType	equ	$84000009
AN_AddSWGadget	equ	$8401000A
AN_OpenWindow	equ	$8401000B
AN_BadState	equ	$8400000C
AN_BadMessage	equ	$8400000D
AN_WeirdEcho	equ	$8400000E
AN_NoConsole	equ	$8400000F
AN_MathLib	equ	$05000000
AN_CListLib	equ	$06000000
AN_DOSLib	equ	$07000000
AN_StartMem	equ	$07010001
AN_EndTask	equ	$07000002
AN_QPktFail	equ	$07000003
AN_AsyncPkt	equ	$07000004
AN_FreeVec	equ	$07000005
AN_DiskBlkSeq	equ	$07000006
AN_BitMap	equ	$07000007
AN_KeyFree	equ	$07000008
AN_BadChkSum	equ	$07000009
AN_DiskError	equ	$0700000A
AN_KeyRange	equ	$0700000B
AN_BadOverlay	equ	$0700000C
AN_RAMLib	equ	$08000000
AN_BadSegList	equ	$08000001
AN_IconLib	equ	$09000000
AN_ExpansionLib	equ	$0A000000
AN_BadExpansionFree	equ	$0A000001
AN_AudioDev	equ	$10000000
AN_ConsoleDev	equ	$11000000
AN_GamePortDev	equ	$12000000
AN_KeyboardDev	equ	$13000000
AN_TrackDiskDev	equ	$14000000
AN_TDCalibSeek	equ	$14000001
AN_TDDelay	equ	$14000002
AN_TimerDev	equ	$15000000
AN_TMBadReq	equ	$15000001
AN_TMBadSupply	equ	$15000002
AN_CIARsrc	equ	$20000000
AN_DiskRsrc	equ	$21000000
AN_DRHasDisk	equ	$21000001
AN_DRIntNoAct	equ	$21000002
AN_MiscRsrc	equ	$22000000
AN_BootStrap	equ	$30000000
AN_BootError	equ	$30000001
AN_Workbench	equ	$31000000
AN_DiskCopy	equ	$32000000
	ENDC

