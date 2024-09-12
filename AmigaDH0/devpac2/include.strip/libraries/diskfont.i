   IFND  LIBRARIES_DISKFONT_I
LIBRARIES_DISKFONT_I SET   1
   IFND     EXEC_NODES_I
   INCLUDE     "exec/nodes.i"
   ENDC
   IFND     EXEC_LISTS_I
   INCLUDE     "exec/lists.i"
   ENDC
   IFND     GRAPHICS_TEXT_I
   INCLUDE     "graphics/text.i"
   ENDC
MAXFONTPATH EQU   256
 STRUCTURE  FC,0
   STRUCT   fc_FileName,MAXFONTPATH
   UWORD fc_YSize
   UBYTE fc_Style
   UBYTE fc_Flags
   LABEL fc_SIZEOF
FCH_ID      EQU   $0f00
 STRUCTURE  FCH,0
   UWORD fch_FileID
   UWORD fch_NumEntries
   LABEL fch_FC
DFH_ID      EQU   $0f80
MAXFONTNAME EQU   32
 STRUCTURE  DiskFontHeader,0
   STRUCT   dfh_DF,LN_SIZE
   UWORD dfh_FileID
   UWORD dfh_Revision
   LONG  dfh_Segment
   STRUCT   dfh_Name,MAXFONTNAME
   STRUCT   dfh_TF,tf_SIZEOF
   LABEL dfh_SIZEOF
   BITDEF   AF,MEMORY,0
   BITDEF   AF,DISK,1
 STRUCTURE  AF,0
   UWORD af_Type
   STRUCT   af_Attr,ta_SIZEOF
   LABEL af_SIZEOF
 STRUCTURE  AFH,0
   UWORD afh_NumEntries
   LABEL afh_AF
   ENDC
