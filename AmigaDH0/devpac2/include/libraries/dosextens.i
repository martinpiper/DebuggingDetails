	IFND	LIBRARIES_DOSEXTENS_I
LIBRARIES_DOSEXTENS_I	SET	1
	IFND	EXEC_TYPES_I
	INCLUDE	"exec/types.i"
	ENDC
	IFND	EXEC_TASKS_I
	INCLUDE	"exec/tasks.i"
	ENDC
	IFND	EXEC_PORTS_I
	INCLUDE	"exec/ports.i"
	ENDC
	IFND	EXEC_LIBRARIES_I
	INCLUDE	"exec/libraries.i"
	ENDC
	IFND	LIBRARIES_DOS_I
	INCLUDE	"libraries/dos.i"
	ENDC
	rsreset
Process	rs.b	0
pr_Task	rs.b	TC_SIZE
pr_MsgPort	rs.b	MP_SIZE
pr_Pad	rs.w	1
pr_SegList	rs.l	1
pr_StackSize	rs.l	1
pr_GlobVec	rs.l	1
pr_TaskNum	rs.l	1
pr_StackBase	rs.l	1
pr_Result2	rs.l	1
pr_CurrentDir	rs.l	1
pr_CIS	rs.l	1
pr_COS	rs.l	1
pr_ConsoleTask	rs.l	1
pr_FileSystemTask	rs.l	1
pr_CLI	rs.l	1
pr_ReturnAddr	rs.l	1
pr_PktWait	rs.l	1
pr_WindowPtr	rs.l	1
pr_SIZEOF	rs.w	0
	rsreset
FileHandle	rs.b	0
fh_Link	rs.l	1
fh_Interactive	rs.l	1
fh_Type	rs.l	1
fh_Buf	rs.l	1
fh_Pos	rs.l	1
fh_End	rs.l	1
fh_Funcs	rs.l	1
fh_Func1	EQU	fh_Funcs
fh_Func2	rs.l	1
fh_Func3	rs.l	1
fh_Args	rs.l	1
fh_Arg1	EQU	fh_Args
fh_Arg2	rs.l	1
fh_SIZEOF	rs.w	0
	rsreset
DosPacket	rs.b	0
dp_Link	rs.l	1
dp_Port	rs.l	1
dp_Type	rs.l	1
dp_Res1	rs.l	1
dp_Res2	rs.l	1
dp_Arg1	rs.l	1
dp_Action	EQU	dp_Type
dp_Status	EQU	dp_Res1
dp_Status2	EQU	dp_Res2
dp_BufAddr	EQU	dp_Arg1
dp_Arg2	rs.l	1
dp_Arg3	rs.l	1
dp_Arg4	rs.l	1
dp_Arg5	rs.l	1
dp_Arg6	rs.l	1
dp_Arg7	rs.l	1
dp_SIZEOF	rs.w	0
	rsreset
StandardPacket	rs.b	0
sp_Msg	rs.b	MN_SIZE
sp_Pkt	rs.b	dp_SIZEOF
sp_SIZEOF	rs.w	0
ACTION_NIL	EQU	0
ACTION_GET_BLOCK	EQU	2
ACTION_SET_MAP	EQU	4
ACTION_DIE	EQU	5
ACTION_EVENT	EQU	6
ACTION_CURRENT_VOLUME	EQU	7
ACTION_LOCATE_OBJECT	EQU	8
ACTION_RENAME_DISK	EQU	9
ACTION_WRITE	EQU	'W'
ACTION_READ	EQU	'R'
ACTION_FREE_LOCK	EQU	15
ACTION_DELETE_OBJECT	EQU	16
ACTION_RENAME_OBJECT	EQU	17
ACTION_COPY_DIR	EQU	19
ACTION_WAIT_CHAR	EQU	20
ACTION_SET_PROTECT	EQU	21
ACTION_CREATE_DIR	EQU	22
ACTION_EXAMINE_OBJECT	EQU	23
ACTION_EXAMINE_NEXT	EQU	24
ACTION_DISK_INFO	EQU	25
ACTION_INFO	EQU	26
ACTION_SET_COMMENT	EQU	28
ACTION_PARENT	EQU	29
ACTION_TIMER	EQU	30
ACTION_INHIBIT	EQU	31
ACTION_DISK_TYPE	EQU	32
ACTION_DISK_CHANGE	EQU	33
	rsreset
DosLibrary	rs.b	0
dl_lib	rs.b	LIB_SIZE
dl_Root	rs.l	1
dl_GV	rs.l	1
dl_A2	rs.l	1
dl_A5	rs.l	1
dl_A6	rs.l	1
dl_SIZEOF	rs.w	0
	rsreset
RootNode	rs.b	0
rn_TaskArray	rs.l	1
rn_ConsoleSegment	rs.l	1
rn_Time	rs.b	ds_SIZEOF
rn_RestartSeg	rs.l	1
rn_Info	rs.l	1
rn_FileHandlerSegment	rs.l	1
rn_SIZEOF	rs.w	0
	rsreset
DosInfo	rs.b	0
di_McName	rs.l	1
di_DevInfo	rs.l	1
di_Devices	rs.l	1
di_Handlers	rs.l	1
di_NetHand	rs.l	1
di_SIZEOF	rs.w	0
	rsreset
CommandLineInterface	rs.b	0
cli_Result2	rs.l	1
cli_SetName	rs.l	1
cli_CommandDir	rs.l	1
cli_ReturnCode	rs.l	1
cli_CommandName	rs.l	1
cli_FailLevel	rs.l	1
cli_Prompt	rs.l	1
cli_StandardInput	rs.l	1
cli_CurrentInput	rs.l	1
cli_CommandFile	rs.l	1
cli_Interactive	rs.l	1
cli_Background	rs.l	1
cli_CurrentOutput	rs.l	1
cli_DefaultStack	rs.l	1
cli_StandardOutput	rs.l	1
cli_Module	rs.l	1
cli_SIZEOF	rs.w	0
	rsreset
DevList	rs.b	0
dl_Next	rs.l	1
dl_Type	rs.l	1
dl_Task	rs.l	1
dl_Lock	rs.l	1
dl_VolumeDate	rs.b	ds_SIZEOF
dl_LockList	rs.l	1
dl_DiskType	rs.l	1
dl_unused	rs.l	1
dl_Name	rs.l	1
DevList_SIZEOF	rs.w	0
DLT_DEVICE	EQU	0
DLT_DIRECTORY	EQU	1
DLT_VOLUME	EQU	2
	rsreset
FileLock	rs.b	0
fl_Link	rs.l	1
fl_Key	rs.l	1
fl_Access	rs.l	1
fl_Task	rs.l	1
fl_Volume	rs.l	1
fl_SIZEOF	rs.w	0
	ENDC

