

        IFND  INTUITION_INTUITIONBASE_I
INTUITION_INTUITIONBASE_I SET  1


*** intuitionbase.i *********************************************************
*
*  the IntuitionBase structure and supporting structures
*
*  $Header: intuitionbase.i,v 1.4 86/06/13 03:22:44 jimm Exp $
*
*  Confidential Information: Commodore-Amiga Computer, Inc.
*  Copyright (c) Commodore-Amiga Computer, Inc.
*                               Modification History
*      date    :   author :    Comments
*     ------       ------      -------------------------------------
*     3-1-85        -jimm               
*
****************************************************************************/

        IFND EXEC_TYPES_I
        INCLUDE "exec/types.i"
        ENDC

        IFND EXEC_LIBRARIES_I
        INCLUDE "exec/libraries.i"
        ENDC

        IFND    GRAPHICS_VIEW_I
        INCLUDE "graphics/view.i"
        ENDC

* Be sure to protect yourself against someone modifying these data as
* you look at them.  This is done by calling:
*
* lock = LockIBase(0), which returns a ULONG.  When done call
*  D0             D0
* UnlockIBase(lock) where lock is what LockIBase() returned.
*              A0
* NOTE: these library functions are simply stubs now, but should be called
* to be compatible with future releases.

* ======================================================================== *
* === IntuitionBase ====================================================== *
* ======================================================================== *
 STRUCTURE IntuitionBase,0

        STRUCT  ib_LibNode,LIB_SIZE
        STRUCT  ib_ViewLord,v_SIZEOF
        APTR    ib_ActiveWindow
        APTR    ib_ActiveScreen

* the FirstScreen variable points to the frontmost Screen.  Screens are
* then maintained in a front to back order using Screen.NextScreen

        APTR    ib_FirstScreen

* there is not size here because...
*
*
        ENDC


