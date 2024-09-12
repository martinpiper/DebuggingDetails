********************************************************************
*                                                                  *
*               Commodore-Amiga, Inc.                              *
*               gfx.i                                              *
*                                                                  *
********************************************************************
    IFND    GRAPHICS_GFX_I
GRAPHICS_GFX_I  SET 1

BITSET      equ $8000
BITCLR      equ 0
AGNUS       equ 1
DENISE      equ 1

    STRUCTURE   BitMap,0
    WORD    bm_BytesPerRow
    WORD    bm_Rows
    BYTE    bm_Flags
    BYTE    bm_Depth
    WORD    bm_Pad
    STRUCT  bm_Planes,8*4
    LABEL   bm_SIZEOF

   STRUCTURE   Rectangle,0
      WORD  ra_MinX
      WORD  ra_MinY
      WORD  ra_MaxX
      WORD  ra_MaxY
   LABEL    ra_SIZEOF

    ENDC
