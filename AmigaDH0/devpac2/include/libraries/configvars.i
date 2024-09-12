	IFND	LIBRARIES_CONFIGVARS_I
LIBRARIES_CONFIGVARS_I	SET	1
	IFND	EXEC_NODES_I
	INCLUDE	"exec/nodes.i"
	ENDC
	IFND	LIBRARIES_CONFIGREGS_I
	INCLUDE	"libraries/configregs.i"
	ENDC
	rsreset
ConfigDev	rs.b	0
cd_Node	rs.b	LN_SIZE
cd_Flags	rs.b	1
cd_Pad	rs.b	1
cd_Rom	rs.b	ExpansionRom_SIZEOF
cd_BoardAddr	rs.l	1
cd_BoardSize	rs.l	1
cd_SlotAddr	rs.w	1
cd_SlotSize	rs.w	1
cd_Driver	rs.l	1
cd_NextCD	rs.l	1
cd_Unused	rs.b	4*4
ConfigDev_SIZEOF	rs.w	0
CDB_SHUTUP	equ	0
CDF_SHUTUP	equ	1<<0
CDB_CONFIGME	equ	1
CDF_CONFIGME	equ	1<<1
	rsreset
CurrentBinding	rs.b	0
cb_ConfigDev	rs.l	1
cb_FileName	rs.l	1
cb_ProductString	rs.l	1
cb_ToolTypes	rs.l	1
CurrentBinding_SIZEOF	rs.w	0
	ENDC

