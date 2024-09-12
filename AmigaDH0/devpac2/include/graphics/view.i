	IFND	GRAPHICS_VIEW_I
GRAPHICS_VIEW_I	SET	1
	IFND	GRAPHICS_GFX_I
	INCLUDE	'graphics/gfx.i'
	ENDC
	IFND	GRAPHICS_COPPER_I
	INCLUDE	'graphics/copper.i'
	ENDC
V_PFBA	EQU	$40
V_DUALPF	EQU	$400
V_HIRES	EQU	$8000
V_LACE	EQU	4
V_HAM	EQU	$800
V_SPRITES	EQU	$4000
GENLOCK_VIDEO	EQU	2
	rsreset
ColorMap	rs.b	0
cm_Flags	rs.b	1
cm_Type	rs.b	1
cm_Count	rs.w	1
cm_ColorTable	rs.l	1
cm_SIZEOF	rs.w	0
	rsreset
ViewPort	rs.b	0
vp_Next	rs.l	1
vp_ColorMap	rs.l	1
vp_DspIns	rs.l	1
vp_SprIns	rs.l	1
vp_ClrIns	rs.l	1
vp_UCopIns	rs.l	1
vp_DWidth	rs.w	1
vp_DHeight	rs.w	1
vp_DxOffset	rs.w	1
vp_DyOffset	rs.w	1
vp_Modes	rs.w	1
vp_reserved	rs.w	1
vp_RasInfo	rs.l	1
vp_SIZEOF	rs.w	0
	rsreset
View	rs.b	0
v_ViewPort	rs.l	1
v_LOFCprList	rs.l	1
v_SHFCprList	rs.l	1
v_DyOffset	rs.w	1
v_DxOffset	rs.w	1
v_Modes	rs.w	1
v_SIZEOF	rs.w	0
	rsreset
collTable	rs.b	0
cp_collPtrs	rs.l	1
cp_SIZEOF	rs.w	0
	rsreset
RasInfo	rs.b	0
ri_Next	rs.l	1
ri_BitMap	rs.l	1
ri_RxOffset	rs.w	1
ri_RyOffset	rs.w	1
ri_SIZEOF	rs.w	0
	ENDC

