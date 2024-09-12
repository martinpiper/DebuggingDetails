    IFND EXEC_IO_I
EXEC_IO_I SET 1
    IFND EXEC_PORTS_I
    INCLUDE "exec/ports.i"
    ENDC !EXEC_PORTS_I
    IFND EXEC_LIBRARIES_I
    INCLUDE "exec/libraries.i"
    ENDC !EXEC_LIBRARIES_I
 STRUCTURE  IO,MN_SIZE
    APTR    IO_DEVICE
    APTR    IO_UNIT
    UWORD   IO_COMMAND
    UBYTE   IO_FLAGS
    BYTE    IO_ERROR
    LABEL   IO_SIZE
    ULONG   IO_ACTUAL
    ULONG   IO_LENGTH
    APTR    IO_DATA
    ULONG   IO_OFFSET
    LABEL   IOSTD_SIZE
    BITDEF  IO,QUICK,0
     LIBINIT
     LIBDEF  DEV_BEGINIO
     LIBDEF  DEV_ABORTIO
BEGINIO     MACRO
     LINKLIB DEV_BEGINIO,IO_DEVICE(A1)
     ENDM
ABORTIO     MACRO
     LINKLIB DEV_ABORTIO,IO_DEVICE(A1)
     ENDM
DEVINIT     MACRO   *
     IFC     '\1',''
CMD_COUNT   SET     CMD_NONSTD
     ENDC
     IFNC    '\1',''
CMD_COUNT   SET     \1
     ENDC
     ENDM
DEVCMD      MACRO   *
\1          EQU     CMD_COUNT
CMD_COUNT   SET     CMD_COUNT+1
     ENDM
     DEVINIT 0
     DEVCMD  CMD_INVALID
     DEVCMD  CMD_RESET
     DEVCMD  CMD_READ
     DEVCMD  CMD_WRITE
     DEVCMD  CMD_UPDATE
     DEVCMD  CMD_CLEAR
     DEVCMD  CMD_STOP
     DEVCMD  CMD_START
     DEVCMD  CMD_FLUSH
     DEVCMD  CMD_NONSTD
    ENDC !EXEC_IO_I
