	IFND	LIBRARIES_DISKFONT_I
LIBRARIES_DISKFONT_I	SET	1
	IFND	EXEC_NODES_I
	INCLUDE	"exec/nodes.i"
	ENDC
	IFND	EXEC_LISTS_I
	INCLUDE	"exec/lists.i"
	ENDC
	IFND	GRAPHICS_TEXT_I
	INCLUDE	"graphics/text.i"
	ENDC
MAXFONTPATH	EQU	256
	rsreset
FC	rs.b	0
fc_FileName	rs.b	MAXFONTPATH
fc_YSize	rs.w	1
fc_Style	rs.b	1
fc_Flags	rs.b	1
fc_SIZEOF	rs.w	0
FCH_ID	EQU	$0f00
	rsreset
FCH	rs.b	0
fch_FileID	rs.w	1
fch_NumEntries	rs.w	1
fch_FC	rs.w	0
DFH_ID	EQU	$0f80
MAXFONTNAME	EQU	32
	rsreset
DiskFontHeader	rs.b	0
dfh_DF	rs.b	LN_SIZE
dfh_FileID	rs.w	1
dfh_Revision	rs.w	1
dfh_Segment	rs.l	1
dfh_Name	rs.b	MAXFONTNAME
dfh_TF	rs.b	tf_SIZEOF
dfh_SIZEOF	rs.w	0
AFB_MEMORY	equ	0
AFF_MEMORY	equ	1<<0
AFB_DISK	equ	1
AFF_DISK	equ	1<<1
	rsreset
AF	rs.b	0
af_Type	rs.w	1
af_Attr	rs.b	ta_SIZEOF
af_SIZEOF	rs.w	0
	rsreset
AFH	rs.b	0
afh_NumEntries	rs.w	1
afh_AF	rs.w	0
	ENDC

