
   IFND  LIBRARIES_DOSEXTENS_I
LIBRARIES_DOSEXTENS_I   SET   1
     IFND  EXEC_TYPES_I
     INCLUDE "exec/types.i"
     ENDC
     IFND  EXEC_TASKS_I
     INCLUDE "exec/tasks.i"
     ENDC
     IFND  EXEC_PORTS_I
     INCLUDE "exec/ports.i"
     ENDC
     IFND  EXEC_LIBRARIES_I
     INCLUDE "exec/libraries.i"
     ENDC
     IFND  LIBRARIES_DOS_I
     INCLUDE "libraries/dos.i"
     ENDC
 STRUCTURE Process,0
    STRUCT  pr_Task,TC_SIZE
    STRUCT  pr_MsgPort,MP_SIZE
    WORD    pr_Pad
    BPTR    pr_SegList
    LONG    pr_StackSize
    APTR    pr_GlobVec
    LONG    pr_TaskNum
    BPTR    pr_StackBase
    LONG    pr_Result2
    BPTR    pr_CurrentDir
    BPTR    pr_CIS
    BPTR    pr_COS
    APTR    pr_ConsoleTask
    APTR    pr_FileSystemTask
    BPTR    pr_CLI
    APTR    pr_ReturnAddr
    APTR    pr_PktWait
    APTR    pr_WindowPtr
    LABEL   pr_SIZEOF
 STRUCTURE FileHandle,0
   APTR   fh_Link
   APTR   fh_Interactive
   APTR   fh_Type
   LONG   fh_Buf
   LONG   fh_Pos
   LONG   fh_End
   LONG   fh_Funcs
fh_Func1 EQU fh_Funcs
   LONG   fh_Func2
   LONG   fh_Func3
   LONG   fh_Args
fh_Arg1 EQU fh_Args
   LONG   fh_Arg2
   LABEL  fh_SIZEOF
 STRUCTURE DosPacket,0
   APTR   dp_Link
   APTR   dp_Port
   LONG   dp_Type
   LONG   dp_Res1
   LONG   dp_Res2
   LONG   dp_Arg1
dp_Action  EQU  dp_Type
dp_Status  EQU  dp_Res1
dp_Status2 EQU  dp_Res2
dp_BufAddr EQU  dp_Arg1
   LONG   dp_Arg2
   LONG   dp_Arg3
   LONG   dp_Arg4
   LONG   dp_Arg5
   LONG   dp_Arg6
   LONG   dp_Arg7
   LABEL  dp_SIZEOF
 STRUCTURE StandardPacket,0
   STRUCT sp_Msg,MN_SIZE
   STRUCT sp_Pkt,dp_SIZEOF
   LABEL  sp_SIZEOF
ACTION_NIL              EQU     0
ACTION_GET_BLOCK        EQU     2
ACTION_SET_MAP          EQU     4
ACTION_DIE              EQU     5
ACTION_EVENT            EQU     6
ACTION_CURRENT_VOLUME   EQU     7
ACTION_LOCATE_OBJECT    EQU     8
ACTION_RENAME_DISK      EQU     9
ACTION_WRITE            EQU     'W'
ACTION_READ             EQU     'R'
ACTION_FREE_LOCK        EQU     15
ACTION_DELETE_OBJECT    EQU     16
ACTION_RENAME_OBJECT    EQU     17
ACTION_COPY_DIR         EQU     19
ACTION_WAIT_CHAR        EQU     20
ACTION_SET_PROTECT      EQU     21
ACTION_CREATE_DIR       EQU     22
ACTION_EXAMINE_OBJECT   EQU     23
ACTION_EXAMINE_NEXT     EQU     24
ACTION_DISK_INFO        EQU     25
ACTION_INFO             EQU     26
ACTION_SET_COMMENT      EQU     28
ACTION_PARENT           EQU     29
ACTION_TIMER            EQU     30
ACTION_INHIBIT          EQU     31
ACTION_DISK_TYPE        EQU     32
ACTION_DISK_CHANGE      EQU     33
 STRUCTURE DosLibrary,0
    STRUCT  dl_lib,LIB_SIZE
    APTR    dl_Root
    APTR    dl_GV
    LONG    dl_A2
    LONG    dl_A5
    LONG    dl_A6
    LABEL   dl_SIZEOF
 STRUCTURE RootNode,0
    BPTR    rn_TaskArray
    BPTR    rn_ConsoleSegment
    STRUCT  rn_Time,ds_SIZEOF
    LONG    rn_RestartSeg
    BPTR    rn_Info
    BPTR    rn_FileHandlerSegment
    LABEL   rn_SIZEOF
 STRUCTURE DosInfo,0
    BPTR    di_McName
    BPTR    di_DevInfo
    BPTR    di_Devices
    BPTR    di_Handlers
    APTR    di_NetHand
    LABEL   di_SIZEOF
 STRUCTURE CommandLineInterface,0
    LONG   cli_Result2
    BSTR   cli_SetName
    BPTR   cli_CommandDir
    LONG   cli_ReturnCode
    BSTR   cli_CommandName
    LONG   cli_FailLevel
    BSTR   cli_Prompt
    BPTR   cli_StandardInput
    BPTR   cli_CurrentInput
    BSTR   cli_CommandFile
    LONG   cli_Interactive
    LONG   cli_Background
    BPTR   cli_CurrentOutput
    LONG   cli_DefaultStack
    BPTR   cli_StandardOutput
    BPTR   cli_Module
    LABEL  cli_SIZEOF
 STRUCTURE DevList,0
    BPTR        dl_Next
    LONG        dl_Type
    APTR        dl_Task
    BPTR        dl_Lock
    STRUCT      dl_VolumeDate,ds_SIZEOF
    BPTR        dl_LockList
    LONG        dl_DiskType
    LONG        dl_unused
    BSTR        dl_Name
    LABEL       DevList_SIZEOF
DLT_DEVICE      EQU     0
DLT_DIRECTORY   EQU     1
DLT_VOLUME      EQU     2
 STRUCTURE FileLock,0
    BPTR        fl_Link
    LONG        fl_Key
    LONG        fl_Access
    APTR        fl_Task
    BPTR        fl_Volume
    LABEL       fl_SIZEOF
   ENDC  LIBRARIES_DOSEXTENS_I
