
**** expansion.h **********************************************************
*
*  external definitions for expansion.resource
*
* Copyright (C) 1985,  Commodore-Amiga, Inc., All rights reserved.
*
* $Header: expansion.i,v 33.2 86/04/25 12:15:45 neil Exp $
*
* $Locker:  $
*
* $Log: expansion.i,v $
* Revision 33.2  86/04/25  12:15:45  neil
* Added MakeDosNode/AddDosNode; changed Get/SetCurrentBinding
* 
* Revision 33.1  86/04/01  12:17:25  neil
* First version
* 
*
****************************************************************************/

        IFND    LIBRARIES_EXPANSION_I
LIBRARIES_EXPANSION_I   SET     1

EXPANSIONNAME   MACRO
                dc.b    'expansion.library',0
                ENDM


;* flags for the AddDosNode() call */
        BITDEF  ADN,STARTPROC,0


        ENDC    !LIBRARIES_EXPANSION_I

