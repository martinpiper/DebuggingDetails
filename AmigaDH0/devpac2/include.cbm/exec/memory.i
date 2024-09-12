    IFND EXEC_MEMORY_I
EXEC_MEMORY_I SET 1
**********************************************************************
*
*   Commodore Amiga -- ROM Operating System Executive Include File
*
**********************************************************************
*
*   Source Control:
*
*       $Header: memory.i,v 1.0 85/08/28 15:12:02 carl Exp $
*
*       $Locker:  $
*
**********************************************************************

    IFND EXEC_NODES_I
    INCLUDE "exec/nodes.i"
    ENDC !EXEC_NODES_I


*---------------------------------------------------------------------
*
*   Memory List Structures
*
*---------------------------------------------------------------------
*
*   A memory list appears in two forms:  One is a requirements list*
*   the other is a list of already allocated memory.  The format is
*   the same, with the reqirements/address field occupying the same
*   position.
*
*   The format is a linked list of ML structures each of which has
*   an array of ME entries.
*
*---------------------------------------------------------------------

 STRUCTURE ML,LN_SIZE
    UWORD   ML_NUMENTRIES           * The number of ME structures that follow
    LABEL   ML_ME                   * where the ME structures begin
    LABEL   ML_SIZE


 STRUCTURE ME,0
    LABEL   ME_REQS                 * the AllocMem requirements
    APTR    ME_ADDR                 * the address of this block (an alias
*                                   *   for the same location as ME_REQS)
    ULONG   ME_LENGTH               * the length of this region
    LABEL   ME_SIZE


*------ memory options:

    BITDEF  MEM,PUBLIC,0
    BITDEF  MEM,CHIP,1
    BITDEF  MEM,FAST,2
    BITDEF  MEM,CLEAR,16
    BITDEF  MEM,LARGEST,17


*------ alignment rules for a memory block:

MEM_BLOCKSIZE   EQU 8
MEM_BLOCKMASK   EQU (MEM_BLOCKSIZE-1)


*---------------------------------------------------------------------
*
*   Memory Region Header
*
*---------------------------------------------------------------------

 STRUCTURE  MH,LN_SIZE
    UWORD   MH_ATTRIBUTES           * characteristics of this region
    APTR    MH_FIRST                * first free region
    APTR    MH_LOWER                * lower memory bound
    APTR    MH_UPPER                * upper memory bound+1
    ULONG   MH_FREE                 * number of free bytes
    LABEL   MH_SIZE


*---------------------------------------------------------------------
*
*   Memory Chunk
*
*---------------------------------------------------------------------

 STRUCTURE  MC,0
    APTR    MC_NEXT                 * ptr to next chunk
    ULONG   MC_BYTES                * chunk byte size
    APTR    MC_SIZE

    ENDC !EXEC_MEMORY_I
