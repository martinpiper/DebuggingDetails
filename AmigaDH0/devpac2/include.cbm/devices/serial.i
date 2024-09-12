
*****************************************************************
*                                                               *
* Copyright 1985, Commodore Amiga Inc.  All rights reserved.    *
* No part of this program may be reproduced, transmitted,       *
* transcribed, stored in retrieval system, or translated into   *
* any language or computer language, in any form or by any      *
* means, electronic, mechanical, magnetic, optical, chemical,   *
* manual or otherwise, without the prior written permission of  *
* Commodore-Amiga Incorporated, 983 University Ave. Building #D,*
* Los Gatos, California, 95030                                  *
*                                                               *
*****************************************************************


*****************************************************************
*
* serial.i -- external declarations for Serial Port Driver
*
* SOURCE CONTROL
* ------ -------
* $Header: serial.i,v 33.1 86/04/29 14:19:10 barry Exp $
*
* $Locker:  $
*
*****************************************************************

    IFND    DEVICES_SERIAL_I
DEVICES_SERIAL_I SET 1

    IFND     EXEC_STRINGS_I
    include 'exec/strings.i'
    ENDC    !EXEC_STRINGS_I

    IFND     EXEC_IO_I
    include 'exec/io.i'
    ENDC    !EXEC_IO_I

*--------------------------------------------------------------------
*
* Useful constants
*
*--------------------------------------------------------------------
*
SER_CTL       EQU     $1113     ; default char's for xON,Xoff.
SER_DBAUD     EQU     9600      ; default baud 

*
*--------------------------------------------------------------------
*
* Driver Specific Commands

SDCMD_QUERY     EQU     CMD_NONSTD
SDCMD_BREAK     EQU     CMD_NONSTD+1
SDCMD_SETPARAMS EQU     CMD_NONSTD+2

SER_DEVFINISH   EQU     CMD_NONSTD+2 ; number of device comands 

*--------------------------------------------------------------------

*-- SERIALNAME is a generic macro to get the name of the driver.  This
*-- way if the name is ever changed you will pick up the change
*-- automatically.
*--
*-- Normal usage would be:
*--
*-- internalName:       SERIALNAME
*--

SERIALNAME:     MACRO
                STRING  'serial.device'
                ENDM

        BITDEF  SER,XDISABLED,7   ; SERFLAGS xOn-xOff feature disabled bit
        BITDEF  SER,EOFMODE,6     ;    "     EOF mode enabled bit
        BITDEF  SER,SHARED,5      ;    "     non-exclusive access
        BITDEF  SER,RAD_BOOGIE,4  ;    "     high-speed mode active
        BITDEF  SER,QUEUEDBRK,3   ;    "     queue this Break ioRqst
        BITDEF  SER,7WIRE,2       ;    "     RS232 7-wire protocol 
        BITDEF  SER,PARTY_ODD,1   ;    "     use-odd-parity bit
        BITDEF  SER,PARTY_ON,0    ;    "     parity-enabled bit 
        BITDEF  IOSER,QUEUED,6    ; IO_FLAGS rqst-queued bit
        BITDEF  IOSER,ABORT,5     ;     "    rqst-aborted bit
        BITDEF  IOSER,ACTIVE,4    ;     "    rqst-qued-or-current bit
        BITDEF  IOST,XOFFREAD,4   ; IOST_HOB receive currently xOFF'ed
        BITDEF  IOST,XOFFWRITE,3  ;     "    transmit currently xOFF'ed
        BITDEF  IOST,READBREAK,2  ;     "    break was latest input
        BITDEF  IOST,WROTEBREAK,1 ;     "    break was latest output
        BITDEF  IOST,OVERRUN,0    ;     "    status word RBF overrun
*       BITDEF's (longword field) ; IO_EXTFLAGS (extended flag longword)
        BITDEF  SEXT,MSPON,1      ;     "    use mark-space parity,not odd-even
        BITDEF  SEXT,MARK,0       ;     "    if mark-space, use mark
*
**************************************************************************************
 STRUCTURE TERMARRAY,0
        ULONG    TERMARRAY_0
        ULONG    TERMARRAY_1
        LABEL    TERMARRAY_SIZE

*****************************************************************
* CAUTION !!  IF YOU ACCESS the serial.device, you MUST (!!!!) use an
* IOEXTSER-sized structure or you may overlay innocent memory, okay ?!  
*****************************************************************
 
 STRUCTURE IOEXTSER,IOSTD_SIZE

*     STRUCT   MsgNode
*   0   APTR     Succ
*   4   APTR     Pred
*   8   UBYTE    Type
*   9   UBYTE    Pri
*   A   APTR     Name
*   E   APTR     ReplyPort
*  12   UWORD    MNLength
*     STRUCT   IOExt
*  14   APTR     IO_DEVICE
*  18   APTR     IO_UNIT
*  1C   UWORD    IO_COMMAND
*  1E   UBYTE    IO_FLAGS
*  1F   UBYTE    IO_ERROR
*     STRUCT   IOStdExt
*  20   ULONG    IO_ACTUAL
*  24   ULONG    IO_LENGTH
*  28   APTR     IO_DATA
*  2C   ULONG    IO_OFFSET
*
*  30
        ULONG   IO_CTLCHAR      ; control char's (order = xON,xOFF,rsvd,rsvd)
        ULONG   IO_RBUFLEN      ; length in bytes of serial port's read buffer
        ULONG   IO_EXTFLAGS     ; additional serial flags (see bitdefs above)
        ULONG   IO_BAUD         ; baud rate requested (true baud)
        ULONG   IO_BRKTIME      ; duration of break signal in MICROseconds
        STRUCT  IO_TERMARRAY,TERMARRAY_SIZE ; termination character array
        UBYTE   IO_READLEN      ; bits per read char (bit count)
        UBYTE   IO_WRITELEN     ; bits per write char (bit count)
        UBYTE   IO_STOPBITS     ; stopbits for read (count)
        UBYTE   IO_SERFLAGS     ; see SERFLAGS bit definitions above 
        UWORD   IO_STATUS       ; status of serial port, as follows:
*
*                  BIT  ACTIVE  FUNCTION
*                   0    low    busy
*                   1    low    paper out
*                   2    low    select
*                   3    low    Data Set Ready
*                   4    low    Clear To Send
*                   5    low    Carrier Detect
*                   6    low    Ready To Send
*                   7    low    Data Terminal Ready
*                   8    high   read overrun
*                   9    high   break sent
*                  10    high   break received
*                  11    high   transmit x-OFF'ed       
*                  12    high   receive x-OFF'ed
*               13-15           reserved
*
        LABEL   IOEXTSER_SIZE

*********************************************************************************

*--------------------------------------------------------------------
*
* Driver error definitions
*
*--------------------------------------------------------------------

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
