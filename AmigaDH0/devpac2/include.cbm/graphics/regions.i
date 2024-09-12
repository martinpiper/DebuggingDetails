
    IFND    GRAPHICS_REGIONS_I
GRAPHICS_REGIONS_I  SET 1
********************************************************************
*               Commodore-Amiga, Inc.                              *
*               regions.i                                          *
********************************************************************

   IFND  GRAPHICS_GFX_I
   include  'graphics/gfx.i'
   ENDC

    STRUCTURE   Region,0
      STRUCT   rg_bounds,ra_SIZEOF
      APTR  rg_RegionRectangle
   LABEL    rg_SIZEOF

   STRUCTURE   RegionRectangle,0
      APTR  rr_Next
      APTR  rr_Prev
      STRUCT   rr_bounds,ra_SIZEOF
   LABEL    rr_SIZEOF

    ENDC
