
 IFND    LIBRARIES_FILEHANDLER_I
LIBRARIES_FILEHANDLER_I SET     1
 IFND      EXEC_TYPES_I
 INCLUDE "exec/types.i"
 ENDC     !EXEC_TYPES_I
 IFND      EXEC_PORTS_I
 INCLUDE "exec/ports.i"
 ENDC     !EXEC_PORTS_I
 IFND      LIBRARIES_DOS_I
 INCLUDE "libraries/dos.i"
 ENDC     !LIBRARIES_DOS_I
DE_TABLESIZE    EQU     0
DE_SIZEBLOCK    EQU     1
DE_SECORG       EQU     2
DE_NUMHEADS     EQU     3
DE_SECSPERBLK   EQU     4
DE_BLKSPERTRACK EQU     5
DE_RESERVEDBLKS EQU     6
DE_PREFAC       EQU     7
DE_INTERLEAVE   EQU     8
DE_LOWCYL       EQU     9
DE_UPPERCYL     EQU     10
DE_NUMBUFFERS   EQU     11
DE_MEMBUFTYPE   EQU     12

 STRUCTURE FileSysStartupMsg,0
    ULONG       fssm_Unit
    BSTR        fssm_Device
    BPTR        fssm_Environ
    ULONG       fssm_Flags
    LABEL       FileSysStartupMsg_SIZEOF
 STRUCTURE DeviceNode,0
    BPTR        dn_Next
    ULONG       dn_Type
    CPTR        dn_Task
    BPTR        dn_Lock
    BSTR        dn_Handler
    ULONG       dn_StackSize
    LONG        dn_Priority
    BPTR        dn_Startup
    BPTR        dn_SegList
    BPTR        dn_GlobalVec
    BSTR        dn_Name
    LABEL       DeviceNode_SIZEOF
 ENDC    !LIBRARIES_FILEHANDLER_I
