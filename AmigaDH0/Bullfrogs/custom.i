AMIGA		=	1
AMIGADOS	=	1
OS_LEGAL	=	1
;HARDWARE_REL	=	1
*****************************************************************************
*                            SCREEN CONSTANTS                               *
*****************************************************************************
	IFD	AMIGA
SCREEN_WIDTH	=	40
SCREEN_HEIGHT	=	200
NO_PLANES		=	4
NO_SCREENS		=	2
PLANE_SIZE      = 	SCREEN_WIDTH*SCREEN_HEIGHT
	ELSEIF
SCREEN_WIDTH	=   40  160
SCREEN_HEIGHT	=	200
NO_PLANES		=	4
NO_SCREENS		=	2
	ENDC

*****************************************************************************
*                                HARDWARE                                   *
*****************************************************************************
	IFD	AMIGADOS
		IFD	HARDWARE_REL
HARDWARE_REGS =	$dff000

BLTDDAT     EQU   $000
DMACONR     EQU   $002
VPOSR       EQU   $004
VHPOSR      EQU   $006
DSKDATR     EQU   $008
JOY0DAT     EQU   $00A
JOY1DAT     EQU   $00C
CLXDAT      EQU   $00E
ADKCONR     EQU   $010
POT0DAT     EQU   $012
POT1DAT     EQU   $014
POTINP      EQU   $016
SERDATR     EQU   $018
DSKBYTR     EQU   $01A
INTENAR     EQU   $01C
INTREQR     EQU   $01E
DSKPT       EQU   $020
DSKLEN      EQU   $024
DSKDAT      EQU   $026
REFPTR      EQU   $028
VPOSW       EQU   $02A
VHPOSW      EQU   $02C
COPCON      EQU   $02E
SERDAT      EQU   $030
SERPER      EQU   $032
POTGO       EQU   $034
JOYTEST     EQU   $036
STREQU      EQU   $038
STRVBL      EQU   $03A
STRHOR      EQU   $03C
STRLONG     EQU   $03E
BLTCON0     EQU   $040
BLTCON1     EQU   $042
BLTAFWM     EQU   $044
BLTALWM     EQU   $046
BLTCPT      EQU   $048
BLTBPT      EQU   $04C
BLTAPT      EQU   $050
BLTDPT      EQU   $054
BLTSIZE     EQU   $058
BLTCMOD     EQU   $060
BLTBMOD     EQU   $062
BLTAMOD     EQU   $064
BLTDMOD     EQU   $066
BLTCDAT     EQU   $070
BLTBDAT     EQU   $072
BLTADAT     EQU   $074
DSKSYNC     EQU   $07E
COP1LC      EQU   $080
COP2LC      EQU   $084
COPJMP1     EQU   $088
COPJMP2     EQU   $08A
COPINS      EQU   $08C
DIWSTRT     EQU   $08E
DIWSTOP     EQU   $090
DDFSTRT     EQU   $092
DDFSTOP     EQU   $094
DMACON      EQU   $096
CLXCON      EQU   $098
INTENA      EQU   $09A
INTREQ      EQU   $09C
ADKCON      EQU   $09E
AUD         EQU   $0A0
AUD0        EQU   $0A0
AUD1        EQU   $0B0
AUD2        EQU   $0C0
AUD3        EQU   $0D0
AC_PTR      EQU   $00
AC_LEN      EQU   $04
AC_PER      EQU   $06
AC_VOL      EQU   $08
AC_DAT      EQU   $0A
AC_SIZEOF   EQU   $10
BPLPT       EQU   $0E0
BPLCON0     EQU   $100
BPLCON1     EQU   $102
BPLCON2     EQU   $104
BPL1MOD     EQU   $108
BPL2MOD     EQU   $10A
BPLDAT      EQU   $110
SPRPT       EQU   $120
SPR0PT      EQU   $120
SPR1PT      EQU   $124
SPR2PT      EQU   $128
SPR3PT      EQU   $12c
SPR4PT      EQU   $130
SPR5PT      EQU   $134
SPR6PT      EQU   $138
SPR7PT      EQU   $13c
SPR         EQU   $140
SD_POS      EQU   $00
SD_CTL      EQU   $02
SD_DATAA    EQU   $04
SD_DATAB    EQU   $08
COLOR       EQU   $180

		ELSEIF

BLTDDAT     EQU   $dff000
DMACONR     EQU   $dff002
VPOSR       EQU   $dff004
VHPOSR      EQU   $dff006
DSKDATR     EQU   $dff008
JOY0DAT     EQU   $dff00A
JOY1DAT     EQU   $dff00C
CLXDAT      EQU   $dff00E
ADKCONR     EQU   $dff010
POT0DAT     EQU   $dff012
POT1DAT     EQU   $dff014
POTINP      EQU   $dff016
SERDATR     EQU   $dff018
DSKBYTR     EQU   $dff01A
INTENAR     EQU   $dff01C
INTREQR     EQU   $dff01E
DSKPT       EQU   $dff020
DSKLEN      EQU   $dff024
DSKDAT      EQU   $dff026
REFPTR      EQU   $dff028
VPOSW       EQU   $dff02A
VHPOSW      EQU   $dff02C
COPCON      EQU   $dff02E
SERDAT      EQU   $dff030
SERPER      EQU   $dff032
POTGO       EQU   $dff034
JOYTEST     EQU   $dff036
STREQU      EQU   $dff038
STRVBL      EQU   $dff03A
STRHOR      EQU   $dff03C
STRLONG     EQU   $dff03E
BLTCON0     EQU   $dff040
BLTCON1     EQU   $dff042
BLTAFWM     EQU   $dff044
BLTALWM     EQU   $dff046
BLTCPT      EQU   $dff048
BLTBPT      EQU   $dff04C
BLTAPT      EQU   $dff050
BLTDPT      EQU   $dff054
BLTSIZE     EQU   $dff058
BLTCMOD     EQU   $dff060
BLTBMOD     EQU   $dff062
BLTAMOD     EQU   $dff064
BLTDMOD     EQU   $dff066
BLTCDAT     EQU   $dff070
BLTBDAT     EQU   $dff072
BLTADAT     EQU   $dff074
DSKSYNC     EQU   $dff07E
COP1LC      EQU   $dff080
COP2LC      EQU   $dff084
COPJMP1     EQU   $dff088
COPJMP2     EQU   $dff08A
COPINS      EQU   $dff08C
DIWSTRT     EQU   $dff08E
DIWSTOP     EQU   $dff090
DDFSTRT     EQU   $dff092
DDFSTOP     EQU   $dff094
DMACON      EQU   $dff096
CLXCON      EQU   $dff098
INTENA      EQU   $dff09A
INTREQ      EQU   $dff09C
ADKCON      EQU   $dff09E
AUD         EQU   $dff0A0
AUD0        EQU   $dff0A0
AUD1        EQU   $dff0B0
AUD2        EQU   $dff0C0
AUD3        EQU   $dff0D0
AC_PTR      EQU   $dff00
AC_LEN      EQU   $dff04
AC_PER      EQU   $dff06
AC_VOL      EQU   $dff08
AC_DAT      EQU   $dff0A
AC_SIZEOF   EQU   $dff10
BPLPT       EQU   $dff0E0
BPLCON0     EQU   $dff100
BPLCON1     EQU   $dff102
BPLCON2     EQU   $dff104
BPL1MOD     EQU   $dff108
BPL2MOD     EQU   $dff10A
BPLDAT      EQU   $dff110
SPRPT       EQU   $dff120
SPR0PT      EQU   $dff120
SPR1PT      EQU   $dff124
SPR2PT      EQU   $dff128
SPR3PT      EQU   $dff12c
SPR4PT      EQU   $dff130
SPR5PT      EQU   $dff134
SPR6PT      EQU   $dff138
SPR7PT      EQU   $dff13c
SPR         EQU   $dff140
SD_POS      EQU   $dff00
SD_CTL      EQU   $dff02
SD_DATAA    EQU   $dff04
SD_DATAB    EQU   $dff08
COLOR       EQU   $dff180

		ENDC
    ELSEIF
	fail	'ST HARDWARE ADDRESSES NOT IN YET'
	ENDC
*****************************************************************************
*                   MACHINE SPECIFIC OS FUNCTION NAMES                      *
*****************************************************************************
	IFD	AMIGADOS
OwnBlitter 		=	-456
DisOwnBlitter	=	-462
	ELSEIF
	ENDC
*****************************************************************************
*                         MACHINE SPECIFIC MACROS                           *
*****************************************************************************
	IFD	AMIGADOS

wait_blit   macro
.\@
    btst        #6,DMACONR
    bne         .\@
            endm

own_blit	macro ;				takes a parameter = an address reg
		IFD	OS_LEGAL
	move.l	_GFXBase,\1			if !OS_LEGAL macro expands to nothing
	jsr		OwnBlitter(\1)
        ENDC
			endm

disown_blit	macro ;				takes a parameter = an address reg
		IFD	OS_LEGAL
	move.l	_GFXBase,\1			if !OS_LEGAL macro expands to nothing
	jsr		DisOwnBlitter(\1)
        ENDC
			endm
	ELSEIF
	ENDC

