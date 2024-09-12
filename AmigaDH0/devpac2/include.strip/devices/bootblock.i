 IFND    DEVICES_BOOTBLOCK_I
DEVICES_BOOTBLOCK_I     EQU     1
 STRUCTURE BB,0
 STRUCT  BB_ID,4
 LONG    BB_CHKSUM
 LONG    BB_DOSBLOCK
 LABEL   BB_ENTRY
 LABEL   BB_SIZE
BOOTSECTS       equ     2
BBID_DOS        macro           *
  dc.b    'DOS',0
  endm
BBID_KICK       macro           *
  dc.b    'KICK'
  endm
BBNAME_DOS      EQU     (('D'<<24)!('O'<<16)!('S'<<8))
BBNAME_KICK     EQU     (('K'<<24)!('I'<<16)!('C'<<8)!('K'))
 ENDC
