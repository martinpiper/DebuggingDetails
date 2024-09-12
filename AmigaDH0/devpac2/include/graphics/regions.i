	IFND	GRAPHICS_REGIONS_I
GRAPHICS_REGIONS_I	SET	1
	IFND	GRAPHICS_GFX_I
	INCLUDE	'graphics/gfx.i'
	ENDC
	rsreset
Region	rs.b	0
rg_bounds	rs.b	ra_SIZEOF
rg_RegionRectangle	rs.l	1
rg_SIZEOF	rs.w	0
	rsreset
RegionRectangle	rs.b	0
rr_Next	rs.l	1
rr_Prev	rs.l	1
rr_bounds	rs.b	ra_SIZEOF
rr_SIZEOF	rs.w	0
	ENDC

