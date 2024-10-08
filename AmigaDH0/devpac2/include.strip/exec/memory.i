    IFND EXEC_MEMORY_I
EXEC_MEMORY_I SET 1
    IFND EXEC_NODES_I
    INCLUDE "exec/nodes.i"
    ENDC !EXEC_NODES_I
 STRUCTURE ML,LN_SIZE
    UWORD   ML_NUMENTRIES
    LABEL   ML_ME
    LABEL   ML_SIZE
 STRUCTURE ME,0
    LABEL   ME_REQS
    APTR    ME_ADDR
    ULONG   ME_LENGTH
    LABEL   ME_SIZE
    BITDEF  MEM,PUBLIC,0
    BITDEF  MEM,CHIP,1
    BITDEF  MEM,FAST,2
    BITDEF  MEM,CLEAR,16
    BITDEF  MEM,LARGEST,17
MEM_BLOCKSIZE   EQU 8
MEM_BLOCKMASK   EQU (MEM_BLOCKSIZE-1)
 STRUCTURE  MH,LN_SIZE
    UWORD   MH_ATTRIBUTES
    APTR    MH_FIRST
    APTR    MH_LOWER
    APTR    MH_UPPER
    ULONG   MH_FREE
    LABEL   MH_SIZE
 STRUCTURE  MC,0
    APTR    MC_NEXT
    ULONG   MC_BYTES
    APTR    MC_SIZE
    ENDC !EXEC_MEMORY_I
