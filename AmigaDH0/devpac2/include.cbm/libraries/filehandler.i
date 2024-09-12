
**** libraries/filehandler.i **********************************************
*
*  device and file handler specific code for AmigaDOS
*
* Copyright (C) 1986,  Commodore-Amiga, Inc., All rights reserved.
*
* $Header: filehandler.i,v 33.4 86/05/21 19:14:20 neil Exp $
*
* $Locker:  $
*
****************************************************************************/

        IFND    LIBRARIES_FILEHANDLER_I
LIBRARIES_FILEHANDLER_I SET     1

        IFND      EXEC_TYPES_I
        INCLUDE "exec/types.i"
        ENDC     !EXEC_TYPES_I

        IFND      EXEC_PORTS_I
        INCLUDE "exec/ports.i"
        ENDC     !EXEC_PORTS_I

        IFND      LIBRARIES_DOS_I
        INCLUDE "libraries/dos.i"
        ENDC     !LIBRARIES_DOS_I


** The disk "environment" is a longword array that describes the
** disk geometry.  It is variable sized, with the length at the beginning.
** Here are the constants for a standard geometry.

** these are the offsets into the array
DE_TABLESIZE    EQU     0       ; standard value is 11
DE_SIZEBLOCK    EQU     1       ; in longwords: standard value is 128
DE_SECORG       EQU     2       ; not used; must be 0
DE_NUMHEADS     EQU     3       ; # of heads (surfaces). drive specific
DE_SECSPERBLK   EQU     4       ; not used; must be 1
DE_BLKSPERTRACK EQU     5       ; blocks per track. drive specific
DE_RESERVEDBLKS EQU     6       ; unavailable blocks at start.  usually 2
DE_PREFAC       EQU     7       ; not used; must be 0
DE_INTERLEAVE   EQU     8       ; usually 0
DE_LOWCYL       EQU     9       ; starting cylinder. typically 0
DE_UPPERCYL     EQU     10      ; max cylinder.  drive specific
DE_NUMBUFFERS   EQU     11      ; starting # of buffers.  typically 5
DE_MEMBUFTYPE   EQU     12      ; type of mem to allocate for buffers.
                                ;     default is 3, hard disks want 0


** The file system startup message is linked into a device node's startup
** field.  It contains a pointer to the above environment, plus the
** information needed to do an exec OpenDevice().

 STRUCTURE FileSysStartupMsg,0
    ULONG       fssm_Unit       ; exec unit number for this device
    BSTR        fssm_Device     ; null terminated bstring to the device name
    BPTR        fssm_Environ    ; ptr to environment table (see above)
    ULONG       fssm_Flags      ; flags for OpenDevice()
    LABEL       FileSysStartupMsg_SIZEOF


** The include file "libraries/dosextens.h" has a DeviceList structure.
** The "device list" can have one of three different things linked onto
** it.  Dosextens defines the structure for a volume.  DLT_DIRECTORY
** is for an assigned directory.  The following structure is for
** a dos "device" (DLT_DEVICE).

 STRUCTURE DeviceNode,0
    BPTR        dn_Next         ; singly linked list
    ULONG       dn_Type         ; always 0 for dos "devices"
    CPTR        dn_Task         ; standard dos "task" field.  If this is
                                ;     null when the node is accesses, a task
                                ;     will be started up
    BPTR        dn_Lock         ; not used for devices -- leave null
    BSTR        dn_Handler      ; filename to loadseg (if seglist is null)
    ULONG       dn_StackSize    ; stacksize to use when starting task
    LONG        dn_Priority     ; task priority when starting task
    BPTR        dn_Startup      ; startup msg: FileSysStartupMsg for disks
    BPTR        dn_SegList      ; code to run to start new task (if necessary).
                                ;     if null then dn_Handler will be loaded.
    BPTR        dn_GlobalVec    ; BCPL global vector to use when starting
                                ;     a task.  -1 means that dn_SegList is not
                                ;     for a bcpl program, so the dos won't
                                ;     try and construct one.  0 tell the
                                ;     dos that you obey BCPL linkage rules,
                                ;     and that it should construct a global
                                ;     vector for you.
    BSTR        dn_Name         ; the node name, e.g. '\3','D','F','3'
    LABEL       DeviceNode_SIZEOF


        ENDC    !LIBRARIES_FILEHANDLER_I
