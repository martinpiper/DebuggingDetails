    IFND EXEC_PORTS_I
EXEC_PORTS_I SET 1
    IFND EXEC_NODES_I
    INCLUDE "exec/nodes.i"
    ENDC !EXEC_NODES_I
    IFND EXEC_LISTS_I
    INCLUDE "exec/lists.i"
    ENDC !EXEC_LISTS_I
 STRUCTURE  MP,LN_SIZE
    UBYTE   MP_FLAGS
    UBYTE   MP_SIGBIT
    APTR    MP_SIGTASK
    STRUCT  MP_MSGLIST,LH_SIZE
    LABEL   MP_SIZE
MP_SOFTINT      EQU  MP_SIGTASK
PF_ACTION       EQU  3
PA_SIGNAL       EQU  0
PA_SOFTINT      EQU  1
PA_IGNORE       EQU  2
 STRUCTURE  MN,LN_SIZE
    APTR    MN_REPLYPORT
    UWORD   MN_LENGTH
    LABEL   MN_SIZE
    ENDC !EXEC_PORTS_I
