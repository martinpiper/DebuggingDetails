
   IFND  DEVICES_PRTBASE_I
DEVICES_PRTBASE_I EQU   1
   IFND  EXEC_NODES_I
   INCLUDE  "exec/nodes.i"
   ENDC
   IFND  EXEC_LISTS_I
   INCLUDE  "exec/lists.i"
   ENDC
   IFND  EXEC_PORTS_I
   INCLUDE  "exec/ports.i"
   ENDC
   IFND  EXEC_LIBRARIES_I
   INCLUDE  "exec/libraries.i"
   ENDC
   IFND  EXEC_TASKS_I
   INCLUDE  "exec/tasks.i"
   ENDC
   IFND  DEVICES_PARALLEL_I
   INCLUDE  "devices/parallel.i"
   ENDC
   IFND  DEVICES_SERIAL_I
   INCLUDE  "devices/serial.i"
   ENDC
   IFND  DEVICES_TIMER_I
   INCLUDE  "devices/timer.i"
   ENDC
   IFND  LIBRARIES_DOSEXTENS_I
   INCLUDE  "libraries/dosextens.i"
   ENDC
   IFND  INTUITION_INTUITION_I
   INCLUDE  "intuition/intuition.i"
   ENDC
 STRUCTURE  DeviceData,LIB_SIZE
    APTR dd_Segment
    APTR dd_ExecBase
    APTR dd_CmdVectors
    APTR dd_CmdBytes
    UWORD   dd_NumCommands
    LABEL   dd_SIZEOF
du_Flags EQU   LN_PRI
    BITDEF  IO,QUEUED,4
    BITDEF  IO,CURRENT,5
    BITDEF  IO,SERVICING,6
    BITDEF  IO,DONE,7
    BITDEF  DU,STOPPED,0
P_PRIORITY  EQU         0
P_STKSIZE   EQU         $800
   BITDEF   P,IOR0,0
   BITDEF   P,IOR1,1
   BITDEF   P,EXPUNGED,7
 STRUCTURE  PrinterData,dd_SIZEOF
    STRUCT  pd_Unit,MP_SIZE
    BPTR pd_PrinterSegment
    UWORD   pd_PrinterType
    APTR pd_SegmentData
    APTR pd_PrintBuf
    APTR pd_PWrite
    APTR pd_PBothReady
    IFGT IOEXTPar_SIZE-IOEXTSER_SIZE
    STRUCT  pd_IOR0,IOEXTPar_SIZE
    STRUCT  pd_IOR1,IOEXTPar_SIZE
    ENDC
    IFLE IOEXTPar_SIZE-IOEXTSER_SIZE
    STRUCT  pd_IOR0,IOEXTSER_SIZE
    STRUCT  pd_IOR1,IOEXTSER_SIZE
    ENDC
    STRUCT  pd_TIOR,IOTV_SIZE
    STRUCT  pd_IORPort,MP_SIZE
    STRUCT  pd_TC,TC_SIZE
    STRUCT  pd_Stk,P_STKSIZE
    UBYTE   pd_Flags
    UBYTE   pd_pad
    STRUCT  pd_Preferences,pf_SIZEOF
    UBYTE      pd_PWaitEnabled
    LABEL   pd_SIZEOF
    BITDEF  PPC,GFX,0
    BITDEF  PPC,COLOR,1
PPC_BWALPHA    EQU   0
PPC_BWGFX      EQU   1
PPC_COLORGFX   EQU   3
PCC_BW          EQU     1
PCC_YMC         EQU     2
PCC_YMC_BW      EQU     3
PCC_YMCB        EQU     4
PCC_4COLOR      EQU     $4
PCC_ADDITIVE    EQU     $8
PCC_WB          EQU     $9
PCC_BGR         EQU     $a
PCC_BGR_WB      EQU     $b
PCC_BGRW        EQU     $c
 STRUCTURE  PrinterExtendedData,0
    APTR    ped_PrinterName
    APTR    ped_Init
    APTR    ped_Expunge
    APTR    ped_Open
    APTR    ped_Close
    UBYTE   ped_PrinterClass
    UBYTE   ped_ColorClass
    UBYTE   ped_MaxColumns
    UBYTE   ped_NumCharSets
    UWORD   ped_NumRows
    ULONG   ped_MaxXDots
    ULONG   ped_MaxYDots
    UWORD   ped_XDotsInch
    UWORD   ped_YDotsInch
    APTR    ped_Commands
    APTR    ped_DoSpecial
    APTR    ped_Render
    LONG    ped_TimeoutSecs
    APTR    ped_8BitChars
    LABEL   ped_SIZEOF
 STRUCTURE  PrinterSegment,0
    ULONG   ps_NextSegment
    ULONG   ps_runAlert
    UWORD   ps_Version
    UWORD   ps_Revision
    LABEL   ps_PED
   ENDC
