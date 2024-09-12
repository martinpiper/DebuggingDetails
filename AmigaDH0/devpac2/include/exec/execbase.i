	IFND	EXEC_EXECBASE_I
EXEC_EXECBASE_I	SET	1
	IFND	EXEC_TYPES_I
	INCLUDE	"exec/types.i"
	ENDC
	IFND	EXEC_LISTS_I
	INCLUDE	"exec/lists.i"
	ENDC
	IFND	EXEC_INTERRUPTS_I
	INCLUDE	"exec/interrupts.i"
	ENDC
	IFND	EXEC_LIBRARIES_I
	INCLUDE	"exec/libraries.i"
	ENDC
	rsreset
ExecBase	rs.b	LIB_SIZE
SoftVer	rs.w	1
LowMemChkSum	rs.w	1
ChkBase	rs.l	1
ColdCapture	rs.l	1
CoolCapture	rs.l	1
WarmCapture	rs.l	1
SysStkUpper	rs.l	1
SysStkLower	rs.l	1
MaxLocMem	rs.l	1
DebugEntry	rs.l	1
DebugData	rs.l	1
AlertData	rs.l	1
MaxExtMem	rs.l	1
ChkSum	rs.w	1
IntVects	rs.w	0
IVTBE	rs.b	IV_SIZE
IVDSKBLK	rs.b	IV_SIZE
IVSOFTINT	rs.b	IV_SIZE
IVPORTS	rs.b	IV_SIZE
IVCOPER	rs.b	IV_SIZE
IVVERTB	rs.b	IV_SIZE
IVBLIT	rs.b	IV_SIZE
IVAUD0	rs.b	IV_SIZE
IVAUD1	rs.b	IV_SIZE
IVAUD2	rs.b	IV_SIZE
IVAUD3	rs.b	IV_SIZE
IVRBF	rs.b	IV_SIZE
IVDSKSYNC	rs.b	IV_SIZE
IVEXTER	rs.b	IV_SIZE
IVINTEN	rs.b	IV_SIZE
IVNMI	rs.b	IV_SIZE
ThisTask	rs.l	1
IdleCount	rs.l	1
DispCount	rs.l	1
Quantum	rs.w	1
Elapsed	rs.w	1
SysFlags	rs.w	1
IDNestCnt	rs.b	1
TDNestCnt	rs.b	1
AttnFlags	rs.w	1
AttnResched	rs.w	1
ResModules	rs.l	1
TaskTrapCode	rs.l	1
TaskExceptCode	rs.l	1
TaskExitCode	rs.l	1
TaskSigAlloc	rs.l	1
TaskTrapAlloc	rs.w	1
MemList	rs.b	LH_SIZE
ResourceList	rs.b	LH_SIZE
DeviceList	rs.b	LH_SIZE
IntrList	rs.b	LH_SIZE
LibList	rs.b	LH_SIZE
PortList	rs.b	LH_SIZE
TaskReady	rs.b	LH_SIZE
TaskWait	rs.b	LH_SIZE
SoftInts	rs.b	SH_SIZE*5
LastAlert	rs.b	4*4
VBlankFrequency	rs.b	1
PowerSupplyFrequency	rs.b	1
SemaphoreList	rs.b	LH_SIZE
KickMemPtr	rs.l	1
KickTagPtr	rs.l	1
KickCheckSum	rs.l	1
ExecBaseReserved	rs.b	10
ExecBaseNewReserved	rs.b	20
SYSBASESIZE	rs.w	0
AFB_68010	equ	0
AFF_68010	equ	1<<0
AFB_68020	equ	1
AFF_68020	equ	1<<1
AFB_68881	equ	4
AFF_68881	equ	1<<4
AFB_RESERVED8	equ	8
AFF_RESERVED8	equ	1<<8
AFB_RESERVED9	equ	9
AFF_RESERVED9	equ	1<<9
	ENDC

