
******************************************************************
*                                                                *
* Copyright (C) 1985, Commodore Amiga Inc.  All rights reserved. *
*                                                               *
******************************************************************


*****************************************************************
*
* SOURCE CONTROL
* ------ -------
* $Header: timer.i,v 27.1 85/06/24 13:32:40 neil Exp $
*
* $Locker:  $
*
*****************************************************************

        IFND    DEVICES_TIMER_I
DEVICES_TIMER_I SET     1

        IFND    EXEC_IO_I
        INCLUDE "exec/io.i"
        ENDC    EXEC_IO_I

* unit defintions
UNIT_MICROHZ    EQU     0
UNIT_VBLANK     EQU     1

TIMERNAME       MACRO
                DC.B    'timer.device',0
                DS.W    0
                ENDM

 STRUCTURE TIMEVAL,0
        ULONG   TV_SECS
        ULONG   TV_MICRO
        LABEL   TV_SIZE

 STRUCTURE TIMEREQUEST,IO_SIZE
        STRUCT  IOTV_TIME,TV_SIZE
        LABEL   IOTV_SIZE

* IO_COMMAND to use for adding a timer
        DEVINIT
        DEVCMD  TR_ADDREQUEST
        DEVCMD  TR_GETSYSTIME
        DEVCMD  TR_SETSYSTIME

        ENDC
