    IFND EXEC_ERRORS_I
EXEC_ERRORS_I SET 1
**********************************************************************
*
*   Commodore Amiga -- ROM Operating System Executive Include File
*
**********************************************************************
*
*   Source Control:
*
*       $Header: errors.i,v 1.0 85/08/28 15:07:26 carl Exp $
*
*       $Locker:  $
*
**********************************************************************

*------ Standard IO Errors:

IOERR_OPENFAIL  EQU     -1              * device/unit failed to open
IOERR_ABORTED   EQU     -2              * request aborted
IOERR_NOCMD     EQU     -3              * command not supported
IOERR_BADLENGTH EQU     -4              * not a valid length


ERR_OPENDEVICE  EQU  IOERR_OPENFAIL     * REMOVE !!!

    ENDC !EXEC_ERRORS_I
