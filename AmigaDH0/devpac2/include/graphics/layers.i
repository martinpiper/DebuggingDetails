	IFND	GRAPHICS_LAYERS_I
GRAPHICS_LAYERS_I	SET	1
	IFND	EXEC_SEMAPHORES_I
	INCLUDE	'exec/semaphores.i'
	ENDC
	IFND	EXEC_LISTS_I
	INCLUDE	'exec/lists.i'
	ENDC
	rsreset
LayerInfo_extra	rs.b	0
lie_env	rs.b	13*4
lie_mem	rs.b	LH_SIZE
lie_SIZEOF	rs.w	0
LAYERSIMPLE	equ	1
LAYERSMART	equ	2
LAYERSUPER	equ	4
LAYERUPDATING	equ	$10
LAYERBACKDROP	equ	$40
LAYERREFRESH	equ	$80
LAYER_CLIPRECTS_LOST	equ	$100
LMN_REGION	equ	-1
	rsreset
Layer_Info	rs.b	0
li_top_layer	rs.l	1
li_check_lp	rs.l	1
li_obs	rs.l	1
li_FreeClipRects	rs.b	MLH_SIZE
li_Lock	rs.b	SS_SIZE
li_gs_Head	rs.b	LH_SIZE
li_long_reserved	rs.l	1
li_Flags	rs.w	1
li_fatten_count	rs.b	1
li_LockLayersCount	rs.b	1
li_LayerInfo_extra_size	rs.w	1
li_blitbuff	rs.l	1
li_LayerInfo_extra	rs.l	1
li_SIZEOF	rs.w	0
NEWLAYERINFO_CALLED	equ	1
ALERTLAYERSNOMEM	equ	$83010000
	ENDC

