
 IFND    EXEC_TYPES_I
 INCLUDE "exec/types.i"
 ENDC    !EXEC_TYPES_I
 IFND    EXEC_NODES_I
 INCLUDE "exec/nodes.i"
 ENDC    !EXEC_NODES_I
 IFND    EXEC_LISTS_I
 INCLUDE "exec/lists.i"
 ENDC    !EXEC_LISTS_I
 IFND    EXEC_TASKS_I
 INCLUDE "exec/tasks.i"
 ENDC    !EXEC_TASKS_I
 IFND    INTUITION_INTUITION_I
 INCLUDE "intuition/intuition.i"
 ENDC    !INTUITION_INTUITION_I
WBDISK          EQU     1
WBDRAWER        EQU     2
WBTOOL          EQU     3
WBPROJECT       EQU     4
WBGARBAGE       EQU     5
WBDEVICE        EQU     6
WBKICK          EQU     7
 STRUCTURE DrawerData,0
    STRUCT      dd_NewWindow,nw_SIZE
    LONG        dd_CurrentX
    LONG        dd_CurrentY
    LABEL       dd_SIZEOF
DRAWERDATAFILESIZE      EQU (dd_SIZEOF)
 STRUCTURE DiskObject,0
    UWORD       do_Magic
    UWORD       do_Version
    STRUCT      do_Gadget,gg_SIZEOF
    UWORD       do_Type
    APTR        do_DefaultTool
    APTR        do_ToolTypes
    LONG        do_CurrentX
    LONG        do_CurrentY
    APTR        do_DrawerData
    APTR        do_ToolWindow
    LONG        do_StackSize
    LABEL       do_SIZEOF
WB_DISKMAGIC    EQU     $e310
WB_DISKVERSION  EQU     1
 STRUCTURE FreeList,0
    WORD        fl_NumFree
    STRUCT      fl_MemList,LH_SIZE
    LABEL       FreeList_SIZEOF
MTYPE_PSTD              EQU     1
MTYPE_TOOLEXIT          EQU     2
MTYPE_DISKCHANGE        EQU     3
MTYPE_TIMER             EQU     4
MTYPE_CLOSEDOWN         EQU     5
MTYPE_IOPROC            EQU     6
GADGBACKFILL            EQU     $0001
NO_ICON_POSITION        EQU     ($80000000)
