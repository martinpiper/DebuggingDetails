_LVOOpenDiskFont	EQU	-30 
_LVOAvailFonts	EQU	-36 
CALLDISKFONT	MACRO
	move.l	_DiskfontBase,a6
	jsr	_LVO\1(a6)
	ENDM
DISKFONTNAME	MACRO
	dc.b	'diskfont.library',0
	ENDM
