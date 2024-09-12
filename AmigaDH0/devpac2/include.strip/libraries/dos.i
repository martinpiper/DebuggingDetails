
   IFND LIBRARIES_DOS_I
LIBRARIES_DOS_I            SET      1
DOSNAME     MACRO
      DC.B  'dos.library',0
      ENDM
MODE_OLDFILE         EQU   1005
MODE_NEWFILE         EQU   1006
OFFSET_BEGINNING     EQU   -1
OFFSET_CURRENT       EQU    0
OFFSET_END           EQU    1
OFFSET_BEGINING     EQU   OFFSET_BEGINNING
BITSPERBYTE          EQU   8
BYTESPERLONG         EQU   4
BITSPERLONG          EQU   32
MAXINT               EQU   $7FFFFFFF
MININT               EQU   $80000000
SHARED_LOCK          EQU   -2
ACCESS_READ          EQU   -2
EXCLUSIVE_LOCK       EQU   -1
ACCESS_WRITE         EQU   -1
 STRUCTURE DateStamp,0
   LONG  ds_Days
   LONG  ds_Minute
   LONG  ds_Tick
   LABEL ds_SIZEOF
TICKS_PER_SECOND EQU 50
 STRUCTURE FileInfoBlock,0
   LONG   fib_DiskKey
   LONG   fib_DirEntryType
   STRUCT fib_FileName,108
   LONG   fib_Protection
   LONG   fib_EntryType
   LONG   fib_Size
   LONG   fib_NumBlocks
   STRUCT fib_DateStamp,ds_SIZEOF
   STRUCT fib_Comment,116
   LABEL  fib_SIZEOF
   BITDEF   FIB,ARCHIVE,4
   BITDEF   FIB,READ,3
   BITDEF   FIB,WRITE,2
   BITDEF   FIB,EXECUTE,1
   BITDEF   FIB,DELETE,0
BPTR     MACRO                      *
  LONG     \1
  ENDM
BSTR     MACRO                      *
  LONG     \1
  ENDM
 STRUCTURE InfoData,0
   LONG id_NumSoftErrors
   LONG id_UnitNumber
   LONG id_DiskState
   LONG id_NumBlocks
   LONG id_NumBlocksUsed
   LONG id_BytesPerBlock
   LONG id_DiskType
   BPTR id_VolumeNode
   LONG id_InUse
   LABEL id_SIZEOF
ID_WRITE_PROTECTED      EQU     80
ID_VALIDATING           EQU     81
ID_VALIDATED            EQU     82
ID_NO_DISK_PRESENT      EQU -1
ID_UNREADABLE_DISK      EQU  ('B'<<24)!('A'<<16)!('D'<<8)
ID_NOT_REALLY_DOS       EQU  ('N'<<24)!('D'<<16)!('O'<<8)!('S')
ID_DOS_DISK             EQU  ('D'<<24)!('O'<<16)!('S'<<8)
ID_KICKSTART_DISK       EQU  ('K'<<24)!('I'<<16)!('C'<<8)!('K')
ERROR_NO_FREE_STORE               EQU  103
ERROR_TASK_TABLE_FULL             EQU  105
ERROR_LINE_TOO_LONG               EQU  120
ERROR_FILE_NOT_OBJECT             EQU  121
ERROR_INVALID_RESIDENT_LIBRARY    EQU  122
ERROR_OBJECT_IN_USE               EQU  202
ERROR_OBJECT_EXISTS               EQU  203
ERROR_OBJECT_NOT_FOUND            EQU  205
ERROR_ACTION_NOT_KNOWN            EQU  209
ERROR_INVALID_COMPONENT_NAME      EQU  210
ERROR_INVALID_LOCK                EQU  211
ERROR_OBJECT_WRONG_TYPE           EQU  212
ERROR_DISK_NOT_VALIDATED          EQU  213
ERROR_DISK_WRITE_PROTECTED        EQU  214
ERROR_RENAME_ACROSS_DEVICES       EQU  215
ERROR_DIRECTORY_NOT_EMPTY         EQU  216
ERROR_DEVICE_NOT_MOUNTED          EQU  218
ERROR_SEEK_ERROR                  EQU  219
ERROR_COMMENT_TOO_BIG             EQU  220
ERROR_DISK_FULL                   EQU  221
ERROR_DELETE_PROTECTED            EQU  222
ERROR_WRITE_PROTECTED             EQU  223
ERROR_READ_PROTECTED              EQU  224
ERROR_NOT_A_DOS_DISK              EQU  225
ERROR_NO_DISK                     EQU  226
ERROR_NO_MORE_ENTRIES             EQU  232
RETURN_OK                         EQU    0
RETURN_WARN                       EQU    5
RETURN_ERROR                      EQU   10
RETURN_FAIL                       EQU   20
 BITDEF  SIGBREAK,CTRL_C,12
 BITDEF  SIGBREAK,CTRL_D,13
 BITDEF  SIGBREAK,CTRL_E,14
 BITDEF  SIGBREAK,CTRL_F,15
   ENDC LIBRARIES_DOS_I
