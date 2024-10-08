
    IFND    DEVICES_SERIAL_I
DEVICES_SERIAL_I SET 1
    IFND     EXEC_STRINGS_I
    include 'exec/strings.i'
    ENDC    !EXEC_STRINGS_I
    IFND     EXEC_IO_I
    include 'exec/io.i'
    ENDC    !EXEC_IO_I
SER_CTL       EQU     $1113
SER_DBAUD     EQU     9600
SDCMD_QUERY     EQU     CMD_NONSTD
SDCMD_BREAK     EQU     CMD_NONSTD+1
SDCMD_SETPARAMS EQU     CMD_NONSTD+2
SER_DEVFINISH   EQU     CMD_NONSTD+2
SERIALNAME:     MACRO
  STRING  'serial.device'
  ENDM
 BITDEF  SER,XDISABLED,7
 BITDEF  SER,EOFMODE,6
 BITDEF  SER,SHARED,5
 BITDEF  SER,RAD_BOOGIE,4
 BITDEF  SER,QUEUEDBRK,3
 BITDEF  SER,7WIRE,2
 BITDEF  SER,PARTY_ODD,1
 BITDEF  SER,PARTY_ON,0
 BITDEF  IOSER,QUEUED,6
 BITDEF  IOSER,ABORT,5
 BITDEF  IOSER,ACTIVE,4
 BITDEF  IOST,XOFFREAD,4
 BITDEF  IOST,XOFFWRITE,3
 BITDEF  IOST,READBREAK,2
 BITDEF  IOST,WROTEBREAK,1
 BITDEF  IOST,OVERRUN,0
 BITDEF  SEXT,MSPON,1
 BITDEF  SEXT,MARK,0
 STRUCTURE TERMARRAY,0
 ULONG    TERMARRAY_0
 ULONG    TERMARRAY_1
 LABEL    TERMARRAY_SIZE
 STRUCTURE IOEXTSER,IOSTD_SIZE
 ULONG   IO_CTLCHAR
 ULONG   IO_RBUFLEN
 ULONG   IO_EXTFLAGS
 ULONG   IO_BAUD
 ULONG   IO_BRKTIME
 STRUCT  IO_TERMARRAY,TERMARRAY_SIZE
 UBYTE   IO_READLEN
 UBYTE   IO_WRITELEN
 UBYTE   IO_STOPBITS
 UBYTE   IO_SERFLAGS
 UWORD   IO_STATUS
 LABEL   IOEXTSER_SIZE
SerErr_DevBusy          EQU     1
SerErr_BaudMismatch     EQU     2
SerErr_InvBaud          EQU     3
SerErr_BufErr           EQU     4
SerErr_InvParam         EQU     5
SerErr_LineErr          EQU     6
SerErr_NotOpen          EQU     7
SerErr_PortReset        EQU     8
SerErr_ParityErr        EQU     9
SerErr_InitErr          EQU    10
SerErr_TimerErr         EQU    11
SerErr_BufOverflow      EQU    12
SerErr_NoDSR            EQU    13
SerErr_NoCTS            EQU    14
SerErr_DetectedBreak    EQU    15
    ENDC    !DEVICES_SERIAL_I
