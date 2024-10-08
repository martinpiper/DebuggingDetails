
    IFND     DEVICES_PARALLEL_I
DEVICES_PARALLEL_I SET 1
    IFND     EXEC_STRINGS_I
    include 'exec/strings.i'
    ENDC    !EXEC_STRINGS_I
    IFND     EXEC_IO_I
    include 'exec/io.i'
    ENDC    !EXEC_IO_I
ParErr_DevBusy          EQU     1
ParErr_BufTooBig        EQU     2
ParErr_InvParam         EQU     3
ParErr_LineErr          EQU     4
ParErr_NotOpen          EQU     5
ParErr_PortReset        EQU     6
ParErr_InitErr          EQU     7
PDCMD_QUERY        EQU     CMD_NONSTD
PDCMD_SETPARAMS    EQU     CMD_NONSTD+1
Par_DEVFINISH      EQU     10
PARALLELNAME:   MACRO
  STRING  'parallel.device'
  ENDM
 BITDEF  PAR,SHARED,5
 BITDEF  PAR,RAD_BOOGIE,3
 BITDEF  PAR,EOFMODE,1
 BITDEF  IOPAR,QUEUED,6
 BITDEF  IOPAR,ABORT,5
 BITDEF  IOPAR,ACTIVE,4
 BITDEF  IOPT,RWDIR,3
 BITDEF  IOPT,PBUSY,2
 BITDEF  IOPT,PAPEROUT,1
 BITDEF  IOPT,PSEL,0
 STRUCTURE PTERMARRAY,0
 ULONG    PTERMARRAY_0
 ULONG    PTERMARRAY_1
 LABEL    PTERMARRAY_SIZE
 STRUCTURE IOEXTPAR,IOSTD_SIZE
 ULONG   IO_PEXTFLAGS
 UBYTE   IO_PARSTATUS
 UBYTE   IO_PARFLAGS
 STRUCT  IO_PTERMARRAY,PTERMARRAY_SIZE
 LABEL   IOEXTPar_SIZE
    ENDC    !DEVICES_PARALLEL_I
