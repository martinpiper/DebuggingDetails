   IFND     DEVICES_CLIPBOARD_I
DEVICES_CLIPBOARD_I  EQU   1
   IFND     EXEC_NODES_I
   INCLUDE     "exec/nodes.i"
   ENDC
   IFND     EXEC_LISTS_I
   INCLUDE     "exec/lists.i"
   ENDC
   IFND     EXEC_PORTS_I
   INCLUDE     "exec/ports.i"
   ENDC
   IFND     EXEC_IO_I
   INCLUDE     "exec/io.i"
   ENDC
   DEVINIT
   DEVCMD   CBD_POST
   DEVCMD   CBD_CURRENTREADID
   DEVCMD   CBD_CURRENTWRITEID
CBERR_OBSOLETEID  EQU   1
 STRUCTURE  ClipboardUnitPartial,0
    STRUCT  cu_Node,LN_SIZE
    ULONG   cu_UnitNum

 STRUCTURE  IOClipReq,0
    STRUCT  io_Message,MN_SIZE
    APTR    io_Device
    APTR    io_Unit
    UWORD   io_Command
    UBYTE   io_Flags
    BYTE    io_Error
    ULONG   io_Actual
    ULONG   io_Length
    APTR    io_Data
    ULONG   io_Offset
    LONG    io_ClipID
    LABEL   iocr_SIZEOF
PRIMARY_CLIP   EQU   0
 STRUCTURE  SatisfyMsg,0
    STRUCT  sm_Msg,MN_SIZE
    UWORD   sm_Unit
    LONG    sm_ClipID
    LABEL   satisfyMsg_SIZEOF
   ENDC
