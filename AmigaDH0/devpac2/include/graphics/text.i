	IFND	GRAPHICS_TEXT_I
GRAPHICS_TEXT_I	SET	1
	IFND	EXEC_PORTS_I
	INCLUDE	"exec/ports.i"
	ENDC
FS_NORMAL	EQU	0
FSB_EXTENDED	equ	3
FSF_EXTENDED	equ	1<<3
FSB_ITALIC	equ	2
FSF_ITALIC	equ	1<<2
FSB_BOLD	equ	1
FSF_BOLD	equ	1<<1
FSB_UNDERLINED	equ	0
FSF_UNDERLINED	equ	1<<0
FPB_ROMFONT	equ	0
FPF_ROMFONT	equ	1<<0
FPB_DISKFONT	equ	1
FPF_DISKFONT	equ	1<<1
FPB_REVPATH	equ	2
FPF_REVPATH	equ	1<<2
FPB_TALLDOT	equ	3
FPF_TALLDOT	equ	1<<3
FPB_WIDEDOT	equ	4
FPF_WIDEDOT	equ	1<<4
FPB_PROPORTIONAL	equ	5
FPF_PROPORTIONAL	equ	1<<5
FPB_DESIGNED	equ	6
FPF_DESIGNED	equ	1<<6
FPB_REMOVED	equ	7
FPF_REMOVED	equ	1<<7
	rsreset
TextAttr	rs.b	0
ta_Name	rs.l	1
ta_YSize	rs.w	1
ta_Style	rs.b	1
ta_Flags	rs.b	1
ta_SIZEOF	rs.w	0
	rsreset
TextFont	rs.b	MN_SIZE
tf_YSize	rs.w	1
tf_Style	rs.b	1
tf_Flags	rs.b	1
tf_XSize	rs.w	1
tf_Baseline	rs.w	1
tf_BoldSmear	rs.w	1
tf_Accessors	rs.w	1
tf_LoChar	rs.b	1
tf_HiChar	rs.b	1
tf_CharData	rs.l	1
tf_Modulo	rs.w	1
tf_CharLoc	rs.l	1
tf_CharSpace	rs.l	1
tf_CharKern	rs.l	1
tf_SIZEOF	rs.w	0
	ENDC

