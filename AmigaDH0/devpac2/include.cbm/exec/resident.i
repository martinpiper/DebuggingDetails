    IFND EXEC_RESIDENT_I
EXEC_RESIDENT_I SET 1
**********************************************************************
*
*   Commodore Amiga -- ROM Operating System Executive Include File
*
**********************************************************************
*
*   Source Control:
*
*       $Header: resident.i,v 1.0 85/08/28 15:13:41 carl Exp $
*
*       $Locker:  $
*
**********************************************************************


*----------------------------------------------------------------
*
*   Resident Module Tag
*
*----------------------------------------------------------------

 STRUCTURE RT,0
    UWORD RT_MATCHWORD                  * word to match
    APTR  RT_MATCHTAG                   * pointer to structure base
    APTR  RT_ENDSKIP                    * address to continue scan 
    UBYTE RT_FLAGS                      * various tag flags
    UBYTE RT_VERSION                    * release version number
    UBYTE RT_TYPE                       * type of module
    BYTE  RT_PRI                        * initialization priority
    APTR  RT_NAME                       * pointer to node name
    APTR  RT_IDSTRING                   * pointer to id string
    APTR  RT_INIT                       * pointer to init code
    LABEL RT_SIZE


*------ Match word definition:

RTC_MATCHWORD   EQU     $4AFC           * (ILLEGAL instruction)


*------ RT_FLAGS bit and field definitions:

    BITDEF RT,COLDSTART,0
    BITDEF RT,AUTOINIT,7                * RT_INIT points to data

* Compatibility:
RTM_WHEN        EQU     1               * field position in RT_FLAGS
RTW_NEVER       EQU     0               * never ever init
RTW_COLDSTART   EQU     1               * init at coldstart time

    ENDC !EXEC_RESIDENT_I
