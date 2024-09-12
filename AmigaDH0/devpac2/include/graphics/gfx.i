	IFND	GRAPHICS_GFX_I
GRAPHICS_GFX_I	SET	1
BITSET	equ	$8000
BITCLR	equ	0
AGNUS	equ	1
DENISE	equ	1
	rsreset
BitMap	rs.b	0
bm_BytesPerRow	rs.w	1
bm_Rows	rs.w	1
bm_Flags	rs.b	1
bm_Depth	rs.b	1
bm_Pad	rs.w	1
bm_Planes	rs.b	8*4
bm_SIZEOF	rs.w	0
	rsreset
Rectangle	rs.b	0
ra_MinX	rs.w	1
ra_MinY	rs.w	1
ra_MaxX	rs.w	1
ra_MaxY	rs.w	1
ra_SIZEOF	rs.w	0
	ENDC

