    IFND EXEC_PORTS_I
EXEC_PORTS_I SET 1
**********************************************************************
*
*   Commodore Amiga -- ROM Operating System Executive Include File
*
**********************************************************************
*
*   Source Control:
*
*       $Header: ports.i,v 33.1 86/03/07 17:30:32 neil Exp $
*
*       $Locker:  $
*
**********************************************************************

    IFND EXEC_NODES_I
    INCLUDE "exec/nodes.i"
    ENDC !EXEC_NODES_I

    IFND EXEC_LISTS_I
    INCLUDE "exec/lists.i"
    ENDC !EXEC_LISTS_I


*----------------------------------------------------------------
*
*   Message Port Structure
*
*----------------------------------------------------------------

 STRUCTURE  MP,LN_SIZE
    UBYTE   MP_FLAGS
    UBYTE   MP_SIGBIT               * signal bit number
    APTR    MP_SIGTASK              * task to be signalled
    STRUCT  MP_MSGLIST,LH_SIZE      * message linked list
    LABEL   MP_SIZE


*------ unions:

MP_SOFTINT      EQU  MP_SIGTASK


*------ flags fields:

PF_ACTION       EQU  3


*------ PutMsg actions:

PA_SIGNAL       EQU  0
PA_SOFTINT      EQU  1
PA_IGNORE       EQU  2


*----------------------------------------------------------------
*
*   Message Structure
*
*----------------------------------------------------------------

 STRUCTURE  MN,LN_SIZE
    APTR    MN_REPLYPORT            * message reply port
    UWORD   MN_LENGTH               * message len in bytes
    LABEL   MN_SIZE


    ENDC !EXEC_PORTS_I
