	IFND	GRAPHICS_GFXBASE_I
GRAPHICS_GFXBASE_I	SET	1
	IFND	EXEC_LISTS_I
	INCLUDE	'exec/lists.i'
	ENDC
	IFND	EXEC_LIBRARIES_I
	INCLUDE	'exec/libraries.i'
	ENDC
	IFND	EXEC_INTERRUPTS_I
	INCLUDE	'exec/interrupts.i'
	ENDC
	rsreset
GfxBase	rs.b	LIB_SIZE
gb_ActiView	rs.l	1
gb_copinit	rs.l	1
gb_cia	rs.l	1
gb_blitter	rs.l	1
gb_LOFlist	rs.l	1
gb_SHFlist	rs.l	1
gb_blthd	rs.l	1
gb_blttl	rs.l	1
gb_bsblthd	rs.l	1
gb_bsblttl	rs.l	1
gb_vbsrv	rs.b	IS_SIZE
gb_timsrv	rs.b	IS_SIZE
gb_bltsrv	rs.b	IS_SIZE
gb_TextFonts	rs.b	LH_SIZE
gb_DefaultFont	rs.l	1
gb_Modes	rs.w	1
gb_VBlank	rs.b	1
gb_Debug	rs.b	1
gb_BeamSync	rs.w	1
gb_system_bplcon0	rs.w	1
gb_SpriteReserved	rs.b	1
gb_bytereserved	rs.b	1
gb_Flags	rs.w	1
gb_BlitLock	rs.w	1
gb_BlitNest	rs.w	1
gb_BlitWaitQ	rs.b	LH_SIZE
gb_BlitOwner	rs.l	1
gb_TOF_WaitQ	rs.b	LH_SIZE
gb_DisplayFlags	rs.w	1
gb_SimpleSprites	rs.l	1
gb_MaxDisplayRow	rs.w	1
gb_MaxDisplayColumn	rs.w	1
gb_NormalDisplayRows	rs.w	1
gb_NormalDisplayColumns	rs.w	1
gb_NormalDPMX	rs.w	1
gb_NormalDPMY	rs.w	1
gb_LastChanceMemory	rs.l	1
gb_LCMptr	rs.l	1
gb_MicrosPerLine	rs.w	1
gb_reserved	rs.b	8
gb_SIZE	rs.w	0
OWNBLITTERn	equ	0
QBOWNERn	equ	1
QBOWNER	equ	1<<QBOWNERn
	ENDC

