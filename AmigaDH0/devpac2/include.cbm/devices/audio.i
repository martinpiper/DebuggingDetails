**********************************************************************
*                                                                    *
*   Copyright 1986, Commodore-Amiga Inc.   All rights reserved.      *
*   No part of this program may be reproduced, transmitted,          *
*   transcribed, stored in retrieval system, or translated into      *
*   any language or computer language, in any form or by any         *
*   means, electronic, mechanical, magnetic, optical, chemical,      *
*   manual or otherwise, without the prior written permission of     *
*   Commodore-Amiga Incorporated, 983 University Ave. Building #D,   *
*   Los Gatos, California, 95030                                     *
*                                                                    *
**********************************************************************
*
* $Header: audio.i,v 32.1 86/01/14 21:21:51 sam Exp $
*
* $Locker:  $
*
* $Log: audio.i,v $
* Revision 32.1  86/01/14  21:21:51  sam
* revision set to 32
* 
* Revision 1.1  86/01/14  20:29:21  sam
* Initial revision
* 
*
**********************************************************************
 
                        IFND    DEVICES_AUDIO_I
DEVICES_AUDIO_I         SET     1

                        IFND    EXEC_IO_I
                        INCLUDE "exec/io.i"
                        ENDC

AUDIONAME               MACRO
                        DC.B    'audio.device',0
                        ENDM

ADHARD_CHANNELS         EQU     4

ADALLOC_MINPREC         EQU     -128
ADALLOC_MAXPREC         EQU     127

ADCMD_FREE              EQU     CMD_NONSTD+0
ADCMD_SETPREC           EQU     CMD_NONSTD+1
ADCMD_FINISH            EQU     CMD_NONSTD+2
ADCMD_PERVOL            EQU     CMD_NONSTD+3
ADCMD_LOCK              EQU     CMD_NONSTD+4
ADCMD_WAITCYCLE         EQU     CMD_NONSTD+5
ADCMDB_NOUNIT           EQU     5
ADCMDF_NOUNIT           EQU     1<<5
ADCMD_ALLOCATE          EQU     ADCMDF_NOUNIT+0

ADIOB_PERVOL            EQU     4
ADIOF_PERVOL            EQU     1<<4
ADIOB_SYNCCYCLE         EQU     5
ADIOF_SYNCCYCLE         EQU     1<<5
ADIOB_NOWAIT            EQU     6
ADIOF_NOWAIT            EQU     1<<6
ADIOB_WRITEMESSAGE      EQU     7
ADIOF_WRITEMESSAGE      EQU     1<<7

ADIOERR_NOALLOCATION    EQU     -10
ADIOERR_ALLOCFAILED     EQU     -11
ADIOERR_CHANNELSTOLEN   EQU     -12
 
                        STRUCTURE       IOAudio,IO_SIZE
                        WORD    ioa_AllocKey
                        APTR    ioa_Data
                        ULONG   ioa_Length
                        UWORD   ioa_Period
                        UWORD   ioa_Volume
                        UWORD   ioa_Cycles
                        STRUCT  ioa_WriteMsg,MN_SIZE
                        LABEL   ioa_SIZEOF

                        ENDC
