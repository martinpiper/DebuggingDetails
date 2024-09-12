        IFND    DEVICES_BOOTBLOCK_I
DEVICES_BOOTBLOCK_I     EQU     1
*************************************************************************
*                                                                       *
*       Copyright (C) 1985, Commodore Amiga Inc.  All rights reserved.  *
*                                                                       *
*************************************************************************


*************************************************************************
*
* bootblock.i
*
* Source Control
* ------ -------
* 
* $Header: bootblock.i,v 1.2 86/01/20 17:51:43 kodiak Exp $
*
* $Locker:  $
*
* $Log: bootblock.i,v $
*   Revision 1.2  86/01/20  17:51:43  kodiak
*   1/20/86 first release of smaller bootstrap
*   
*   Revision 1.1  86/01/15  18:35:50  kodiak
*   added to rcs for updating in version 1.2
*   
* Revision 27.1  85/06/24  13:15:16  neil
* *** empty log message ***
* 
* Revision 26.2  85/06/18  23:55:38  neil
* Added BBNAME definitions
* 
* Revision 26.1  85/06/17  20:08:25  neil
* *** empty log message ***
* 
* 
*************************************************************************

******* BootBlock definition:

 STRUCTURE BB,0
        STRUCT  BB_ID,4         * 4 character identifier
        LONG    BB_CHKSUM       * boot block checksum (balance)
        LONG    BB_DOSBLOCK     * reserved for DOS patch
        LABEL   BB_ENTRY        * bootstrap entry point
        LABEL   BB_SIZE

BOOTSECTS       equ     2       * 1K bootstrap

BBID_DOS        macro           * something that is bootable
                dc.b    'DOS',0
                endm

BBID_KICK       macro           * firmware image disk
                dc.b    'KICK'
                endm


BBNAME_DOS      EQU     (('D'<<24)!('O'<<16)!('S'<<8))
BBNAME_KICK     EQU     (('K'<<24)!('I'<<16)!('C'<<8)!('K'))

        ENDC
