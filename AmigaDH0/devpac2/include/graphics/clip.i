	IFND	GRAPHICS_CLIP_I
GRAPHICS_CLIP_I	SET	1
	IFND	GRAPHICS_GFX_I
	INCLUDE	'graphics/gfx.i'
	ENDC
	IFND	EXEC_SEMAPHORES_I
	INCLUDE	'exec/semaphores.i'
	ENDC
NEWLOCKS	equ	1
	rsreset
Layer	rs.b	0
lr_front	rs.l	1
lr_back	rs.l	1
lr_ClipRect	rs.l	1
lr_rp	rs.l	1
lr_MinX	rs.w	1
lr_MinY	rs.w	1
lr_MaxX	rs.w	1
lr_MaxY	rs.w	1
lr_reserved	rs.b	4
lr_priority	rs.w	1
lr_Flags	rs.w	1
lr_SuperBitMap	rs.l	1
lr_SuperClipRect	rs.l	1
lr_Window	rs.l	1
lr_Scroll_X	rs.w	1
lr_Scroll_Y	rs.w	1
lr_cr	rs.l	1
lr_cr2	rs.l	1
lr_crnew	rs.l	1
lr_SuperSaverClipRects	rs.l	1
lr__cliprects	rs.l	1
lr_LayerInfo	rs.l	1
lr_Lock	rs.b	SS_SIZE
lr_reserved3	rs.b	8
lr_ClipRegion	rs.l	1
lr_saveClipRects	rs.l	1
lr_reserved2	rs.b	22
lr_DamageList	rs.l	1
lr_SIZEOF	rs.w	0
	rsreset
ClipRect	rs.b	0
cr_Next	rs.l	1
cr_prev	rs.l	1
cr_lobs	rs.l	1
cr_BitMap	rs.l	1
cr_MinX	rs.w	1
cr_MinY	rs.w	1
cr_MaxX	rs.w	1
cr_MaxY	rs.w	1
cr__p1	rs.l	1
cr__p2	rs.l	1
cr_reserved	rs.l	1
cr_Flags	rs.l	1
cr_SIZEOF	rs.w	0
CR_NEEDS_NO_CONCEALED_RASTERS	equ	1
ISLESSX	equ	1
ISLESSY	equ	2
ISGRTRX	equ	4
ISGRTRY	equ	8
	IFND	lr_Front
lr_Front	equ	lr_front
lr_Back	equ	lr_back
lr_RastPort	equ	lr_rp
cr_Prev	equ	cr_prev
cr_LObs	equ	cr_lobs
	ENDC
	ENDC

