


*** startup.i ************************************************************
*
*  Workbench startup definitions
*
* Copyright (C) 1985,  Commodore-Amiga, Inc., All rights reserved.
*
* $Header: startup.i,v 29.1 85/08/15 06:58:52 neil Exp $
*
* $Locker:  $
*
****************************************************************************

        IFND    EXEC_TYPES_I
        INCLUDE "exec/types.i"
        ENDC    !EXEC_TYPES_I

        IFND    EXEC_PORTS_I
        INCLUDE "exec/ports.i"
        ENDC    !EXEC_PORTS_I

        IFND    LIBRARIES_DOS_I
        INCLUDE "libraries/dos.i"
        ENDC    !LIBRARIES_DOS_I

 STRUCTURE WBStartup,0
    STRUCT      sm_Message,MN_SIZE      ; a standard message structure
    APTR        sm_Process              ; the process descriptor for you
    BPTR        sm_Segment              ; a descriptor for your code
    LONG        sm_NumArgs              ; the number of elements in ArgList
    APTR        sm_ToolWindow           ; description of window
    APTR        sm_ArgList              ; the arguments themselves
    LABEL       sm_SIZEOF

 STRUCTURE WBArg,0
    BPTR        wa_Lock                 ; a lock descriptor
    APTR        wa_Name                 ; a string relative to that lock
    LABEL       wa_SIZEOF

