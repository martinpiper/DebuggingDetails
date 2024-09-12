   IFND  GRAPHICS_TEXT_I
GRAPHICS_TEXT_I      SET   1
   IFND     EXEC_PORTS_I
   INCLUDE  "exec/ports.i"
   ENDC
FS_NORMAL   EQU 0
   BITDEF   FS,EXTENDED,3
   BITDEF   FS,ITALIC,2
   BITDEF   FS,BOLD,1
   BITDEF   FS,UNDERLINED,0
   BITDEF   FP,ROMFONT,0
   BITDEF   FP,DISKFONT,1
   BITDEF   FP,REVPATH,2
   BITDEF   FP,TALLDOT,3
   BITDEF   FP,WIDEDOT,4
   BITDEF   FP,PROPORTIONAL,5
   BITDEF   FP,DESIGNED,6
   BITDEF   FP,REMOVED,7
 STRUCTURE  TextAttr,0
   APTR     ta_Name
   UWORD    ta_YSize
   UBYTE    ta_Style
   UBYTE    ta_Flags
   LABEL    ta_SIZEOF
 STRUCTURE  TextFont,MN_SIZE
   UWORD    tf_YSize
   UBYTE    tf_Style
   UBYTE    tf_Flags
   UWORD    tf_XSize
   UWORD    tf_Baseline
   UWORD    tf_BoldSmear
   UWORD    tf_Accessors
   UBYTE    tf_LoChar
   UBYTE    tf_HiChar
   APTR     tf_CharData
   UWORD    tf_Modulo
   APTR     tf_CharLoc
   APTR     tf_CharSpace
   APTR     tf_CharKern
   LABEL    tf_SIZEOF
   ENDC
