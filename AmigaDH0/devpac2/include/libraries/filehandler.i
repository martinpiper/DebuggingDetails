	IFND	LIBRARIES_FILEHANDLER_I
LIBRARIES_FILEHANDLER_I	SET	1
	IFND	EXEC_TYPES_I
	INCLUDE	"exec/types.i"
	ENDC
	IFND	EXEC_PORTS_I
	INCLUDE	"exec/ports.i"
	ENDC
	IFND	LIBRARIES_DOS_I
	INCLUDE	"libraries/dos.i"
	ENDC
DE_TABLESIZE	EQU	0
DE_SIZEBLOCK	EQU	1
DE_SECORG	EQU	2
DE_NUMHEADS	EQU	3
DE_SECSPERBLK	EQU	4
DE_BLKSPERTRACK	EQU	5
DE_RESERVEDBLKS	EQU	6
DE_PREFAC	EQU	7
DE_INTERLEAVE	EQU	8
DE_LOWCYL	EQU	9
DE_UPPERCYL	EQU	10
DE_NUMBUFFERS	EQU	11
DE_MEMBUFTYPE	EQU	12
	rsreset
FileSysStartupMsg	rs.b	0
fssm_Unit	rs.l	1
fssm_Device	rs.l	1
fssm_Environ	rs.l	1
fssm_Flags	rs.l	1
FileSysStartupMsg_SIZEOF	rs.w	0
	rsreset
DeviceNode	rs.b	0
dn_Next	rs.l	1
dn_Type	rs.l	1
	CPTR	dn_Task
dn_Lock	rs.l	1
dn_Handler	rs.l	1
dn_StackSize	rs.l	1
dn_Priority	rs.l	1
dn_Startup	rs.l	1
dn_SegList	rs.l	1
dn_GlobalVec	rs.l	1
dn_Name	rs.l	1
DeviceNode_SIZEOF	rs.w	0
	ENDC

