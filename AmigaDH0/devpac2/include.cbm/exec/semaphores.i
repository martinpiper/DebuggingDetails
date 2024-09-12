
    IFND EXEC_SEMAPHORES_I
EXEC_SEMAPHORES_I SET 1
**********************************************************************
*
*   Commodore Amiga -- ROM Operating System Executive Include File
*
**********************************************************************
*
*   Source Control:
*
*       $Header: semaphores.i,v 33.1 86/03/07 17:31:08 neil Exp $
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

    IFND EXEC_PORTS_I
    INCLUDE "exec/ports.i"
    ENDC !EXEC_PORTS_I


*----------------------------------------------------------------
*
*   Semaphore Structure
*
*----------------------------------------------------------------


 STRUCTURE  SM,MP_SIZE
    WORD    SM_BIDS           * number of bids for lock
    LABEL   SM_SIZE


*------ unions:

SM_LOCKMSG    EQU  MP_SIGTASK


*----------------------------------------------------------------
*
*   Signal Semaphore Structure
*
*----------------------------------------------------------------

* this is the structure used to request a signal semaphore -- allocated
* on the fly by ObtainSemaphore()
 STRUCTURE  SSR,MLN_SIZE
    APTR    SSR_WAITER
    LABEL   SSR_SIZE


* this is the actual semaphore itself -- allocated statically
 STRUCTURE  SS,LN_SIZE
    SHORT   SS_NESTCOUNT
    STRUCT  SS_WAITQUEUE,MLH_SIZE
    STRUCT  SS_MULTIPLELINK,SSR_SIZE
    APTR    SS_OWNER
    SHORT   SS_QUEUECOUNT
    LABEL   SS_SIZE

    ENDC !EXEC_SEMAPHORES_I
