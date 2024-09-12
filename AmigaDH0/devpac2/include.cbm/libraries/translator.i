        TTL     '$Header: translator.i,v 32.1 86/01/22 01:18:17 sam Exp $'
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
* $Header: translator.i,v 32.1 86/01/22 01:18:17 sam Exp $
*
* $Locker:  $
*
* $Log: translator.i,v $
* Revision 32.1  86/01/22  01:18:17  sam
* placed under source control
* 
*
**********************************************************************
        IFND    LIBRARIES_TRANSLATOR_I
LIBRARIES_TRANSLATOR_I  SET     1


*               ;------ Translator error codes
TR_NotUsed      EQU     -1              ;This is an often used system rc
TR_NoMem        EQU     -2              ;Can't allocate memory
TR_MakeBad      EQU     -4              ;Error in MakeLibrary call


        ENDC
