
	IFND	NOLINK
FUNC_SPRITES	=	1
;	include custom.i
;	include myheader.i
;	INCLUDE funcs.f
	ENDC
*****************************************************************************
*                Both the blitter and the processor sprite                  *
*                       routines use d0-d7 a0 & a1                          *
*                    the blitter version also uses a2                       *
*                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~						*
*****************************************************************************
SPRITE_SCREEN_WIDTH	=	SCREEN_WIDTH

*****************************************************************************
	xdef	_s8_draw
_s8_draw
	rts
*****************************************************************************
*		d0 = x	d1 = y	d2 = height	a0 = the screen	a1 = source             *
*****************************************************************************
	xdef	_s16_draw
_s16_draw ;
	move.w	d2,d7				*1		calculate the plane size
	add.w	d7,d7				*2
	tst.w	d1					is y less than 0
	bge.s	.y_not_minus		no, ok.
******************************************************************************
*	QY is negative
	neg.w	d1
	sub.w	d1,d2				do we see any of it ?
	ble		.not_drawn			no, dont draw the thing at all
; a 16 pixel wide sprite has 2 bytes a line, so we have to multiply by 2
	add.w	d1,d1				*2
	adda.w	d1,a1				move into the source the required no. of lines

	bra.s	.y_clipped
*********
.y_not_minus
	move.w	lines_high(pc),d6
	cmp.w	d6,d1
	bge 	.not_drawn
	IFNE	SCREEN_WIDTH-40
	fail 	'sorry, SCREEN_WIDTH changed you gotta re-write this bit'
	ENDC
	move.w	d1,d3
	add.w	d3,d3				*2
	add.w	d3,d3				*4
	add.w	d1,d3				*5
	lsl.w	#3,d3				*8*5 = *40
	adda.w	d3,a0				move down the screen

	add.w	d2,d1
	sub.w	d6,d1
	blt.s	.y_clipped
	sub.w	d1,d2				adjust height of sprite to fit the fucker on
.y_clipped
*****************************************************************************
*	I suppose I better do the QX stuff now
	tst.w	d0
	bge.s	.x_not_minus		x ok, well at least it isn't negative!
	cmpi.w	#-16,d0
	ble.s	.not_drawn			it is off screen
	bra		blit_left_16
.x_not_minus
	move.w	d0,d3
	andi.w	#$f,d0              just the shift

* we want . . . 0-15 ->0, 16-31->2 etc.........

	eor.w	d0,d3				all but the shift
	lsr.w	#3,d3				AMIGA
	move.w	sprite_screen_width(pc),d6				"""""
	cmp.w	d6,d3				is it off the right side of the screen ?
	bge.s	.not_drawn			yes
	adda.w	d3,a0				adjust destination
	subq.w	#2,d6				AMIGA
	cmp.w	d6,d3
	bne		blit_mid_16
*	right hand only case

	moveq	#0,d1
	bra		blit_right_16
.not_drawn
	rts
;left_gone	BLTCON0	BLTCON1	BLTAFWM	BLTALWM
left16lu
	dc.w	$0fca,	$0000,	$0000,	$0000
	dc.w	$1fca,	$1000,	$0001,	$0000
	dc.w	$2fca,	$2000,	$0003,	$0000
	dc.w	$3fca,	$3000,	$0007,	$0000
	dc.w	$4fca,	$4000,	$000f,	$0000
	dc.w	$5fca,	$5000,	$001f,	$0000
	dc.w	$6fca,	$6000,	$003f,	$0000
	dc.w	$7fca,	$7000,	$007f,	$0000
	dc.w	$8fca,	$8000,	$00ff,	$0000
	dc.w	$9fca,	$9000,	$01ff,	$0000
	dc.w	$afca,	$a000,	$03ff,	$0000
	dc.w	$bfca,	$b000,	$07ff,	$0000
	dc.w	$cfca,	$c000,	$0fff,	$0000
	dc.w	$dfca,	$d000,	$1fff,	$0000
	dc.w	$efca,	$e000,	$3fff,	$0000
	dc.w	$ffca,	$f000,	$7fff,	$0000
blit_left_16
	subq.l	#2,a0
	andi.w	#$f,d0
	lsl.w	#3,d0								shifted for lookup
	lea		left16lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#-2,(BLTAMOD).l
	move.w	#-2,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#4/2,d2
	bra		blit_sprite
right_16_lu
;right_gone	BLTCON0	BLTCON1	BLTAFWM	BLTALWM			2 less on the width
	dc.w	$0fca,	$0000,	$ffff,	$ffff
	dc.w	$1fca,	$1000,	$ffff,	$fffe
	dc.w	$2fca,	$2000,	$ffff,	$fffc
	dc.w	$3fca,	$3000,	$ffff,	$fff8
	dc.w	$4fca,	$4000,	$ffff,	$fff0
	dc.w	$5fca,	$5000,	$ffff,	$ffe0
	dc.w	$6fca,	$6000,	$ffff,	$ffc0
	dc.w	$7fca,	$7000,	$ffff,	$ff80
	dc.w	$8fca,	$8000,	$ffff,	$ff00
	dc.w	$9fca,	$9000,	$ffff,	$fe00
	dc.w	$afca,	$a000,	$ffff,	$fc00
	dc.w	$bfca,	$b000,	$ffff,	$f800
	dc.w	$cfca,	$c000,	$ffff,	$f000
	dc.w	$dfca,	$d000,	$ffff,	$e000
	dc.w	$efca,	$e000,	$ffff,	$c000
	dc.w	$ffca,	$f000,	$ffff,	$8000
blit_right_16
	andi.w	#$f,d0
	lsl.w	#3,d0								shifted for lookup
	lea		right_16_lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#0,(BLTAMOD).l
	move.w	#0,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-2,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-2,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#2/2,d2
	bra		blit_sprite
	rts
;mid screen	BLTCON0	BLTCON1	BLTAFWM	BLTALWM
mid16lu
	dc.w	$0fca,	$0000,	$ffff,	$0000
	dc.w	$1fca,	$1000,	$ffff,	$0000
	dc.w	$2fca,	$2000,	$ffff,	$0000
	dc.w	$3fca,	$3000,	$ffff,	$0000
	dc.w	$4fca,	$4000,	$ffff,	$0000
	dc.w	$5fca,	$5000,	$ffff,	$0000
	dc.w	$6fca,	$6000,	$ffff,	$0000
	dc.w	$7fca,	$7000,	$ffff,	$0000
	dc.w	$8fca,	$8000,	$ffff,	$0000
	dc.w	$9fca,	$9000,	$ffff,	$0000
	dc.w	$afca,	$a000,	$ffff,	$0000
	dc.w	$bfca,	$b000,	$ffff,	$0000
	dc.w	$cfca,	$c000,	$ffff,	$0000
	dc.w	$dfca,	$d000,	$ffff,	$0000
	dc.w	$efca,	$e000,	$ffff,	$0000
	dc.w	$ffca,	$f000,	$ffff,	$0000
blit_mid_16
	lsl.w	#3,d0								shifted for lookup
	lea		mid16lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#-2,(BLTAMOD).l
	move.w	#-2,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#4/2,d2
	bra		blit_sprite
*****************************************************************************
	xdef	_s32_draw
_s32_draw ;
;	move.w	#$707,(COLOR).l
	move.w	d2,d7				*1		calculate the plane size
	add.w	d7,d7				*2
	add.w	d7,d7				*4
	tst.w	d1					is y less than 0
	bge.s	.y_not_minus		no, ok.
******************************************************************************
*	QY is negative
	neg.w	d1
	sub.w	d1,d2				do we see any of it ?
	ble		.not_drawn			no, dont draw the thing at all
; a 32 pixel wide sprite has 4 bytes a line, so we have to multiply by 4
	add.w	d1,d1				*2
	add.w	d1,d1				*4
	adda.w	d1,a1				move into the source the required no. of lines

	bra.s	.y_clipped
*********
.y_not_minus
	move.w	lines_high(pc),d6
	cmp.w	d6,d1
	bge 	.not_drawn
	IFNE	SCREEN_WIDTH-40
	fail 	'sorry, SCREEN_WIDTH changed you gotta re-write this bit'
	ENDC
	move.w	d1,d3
	add.w	d3,d3				*2
	add.w	d3,d3				*4
	add.w	d1,d3				*5
	lsl.w	#3,d3				*8*5 = *40
	adda.w	d3,a0				move down the screen

	add.w	d2,d1
	sub.w	d6,d1
	blt.s	.y_clipped
	sub.w	d1,d2				adjust height of sprite to fit the fucker on
.y_clipped
*****************************************************************************
*	I suppose I better do the X stuff now
	tst.w	d0
	bge.s	.x_not_minus		x ok, well at least it isn't negative!
	cmpi.w	#-32,d0
	ble.s	.not_drawn			it is off screen
	cmpi.w	#-16,d0
	blt		blit_left_32_lt16
	bra		blit_left_32_gt16
.x_not_minus
	move.w	d0,d3
	andi.w	#$f,d0              just the shift

* we want . . . 0-15 ->0, 16-31->2 etc.........

	eor.w	d0,d3				all but the shift
	lsr.w	#3,d3
	adda.w	d3,a0				adjust destination
	move.w	sprite_screen_width(pc),d6				"""""
	subq.w	#6,d6
	cmp.w	d6,d3				is it definately on screen ?
	ble		blit_mid_32			yes
	addq.w	#2,d6
	cmp.w	d6,d3				is it mostly on screen ?
	ble		blit_right_32_gt16	yes
	addq.w	#2,d6
	cmp.w	d6,d3				is it partly on screen ?
	ble		blit_right_32_lt16	yes

.not_drawn
	rts
blit_right_32_gt16
	andi.w	#$f,d0
	lsl.w	#3,d0								shifted for lookup
	lea		right_16_lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#0,(BLTAMOD).l
	move.w	#0,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#4/2,d2
	bra		blit_sprite
	rts
blit_right_32_lt16
	andi.w	#$f,d0
	lsl.w	#3,d0								shifted for lookup
	lea		right_16_lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#2,(BLTAMOD).l
	move.w	#2,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-2,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-2,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#2/2,d2
	bra		blit_sprite
	rts
blit_left_32_lt16
	subq.l	#2,a0
	addq.l	#2,a1
	andi.w	#$f,d0
	lsl.w	#3,d0								shifted for lookup
	lea		left16lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#0,(BLTAMOD).l
	move.w	#0,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-4,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#4/2,d2
	bra		blit_sprite

blit_left_32_gt16
	subq.l	#2,a0
	andi.w	#$f,d0
	lsl.w	#3,d0								shifted for lookup
	lea		left16lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#-2,(BLTAMOD).l
	move.w	#-2,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-6,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-6,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#6/2,d2
	bra		blit_sprite
	rts

blit_mid_32
	lsl.w	#3,d0								shifted for lookup
	lea		mid16lu,a2
	movem.l	(a2,d0.w),d0/d1
	movem.l	d0/d1,(BLTCON0).l

	move.w	#-2,(BLTAMOD).l
	move.w	#-2,(BLTBMOD).l
	move.w	#SCREEN_WIDTH-6,(BLTCMOD).l
	move.w	#SCREEN_WIDTH-6,(BLTDMOD).l

	lsl.w	#6,d2
	addq.w	#6/2,d2

blit_sprite *****************************************************************
*  a0-> screen address; a1-> sprite data; d2 = blitsize; d7 = planesize     *
*                    mods, cons & endmasks are set up                       *
*****************************************************************************
	BLIT_NASTY
;	move.w	#$ff0,(COLOR).l
	lea		(a1,d7.w),a2
	move.l	a0,(BLTCPT).l						dest as source
	move.l	a0,(BLTDPT).l						dest
	move.l  a2,(BLTBPT).l						source
	move.l	a1,(BLTAPT).l						template

	move.w  d2,(BLTSIZE).l						plane 0

;	wait_blit

	add.w	d7,a2            					next plane of source
	lea		PLANE_SIZE(a0),a0					next plane of screen

	move.l	a0,(BLTCPT).l						dest as source
	move.l	a0,(BLTDPT).l						dest
	move.l  a2,(BLTBPT).l						source
	move.l	a1,(BLTAPT).l						template

	move.w  d2,(BLTSIZE).l						plane 1

;	wait_blit

	add.w	d7,a2            					next plane of source
	lea		PLANE_SIZE(a0),a0					next plane of screen

	move.l	a0,(BLTCPT).l						dest as source
	move.l	a0,(BLTDPT).l						dest
	move.l  a2,(BLTBPT).l						source
	move.l	a1,(BLTAPT).l						template

	move.w  d2,(BLTSIZE).l						plane 2

;	wait_blit

	add.w	d7,a2            					next plane of source
	lea		PLANE_SIZE(a0),a0					next plane of screen

	move.l	a0,(BLTCPT).l						dest as source
	move.l	a0,(BLTDPT).l						dest
	move.l  a2,(BLTBPT).l						source
	move.l	a1,(BLTAPT).l						template

	move.w  d2,(BLTSIZE).l						plane 3

;	wait_blit

	BLIT_NICE
;	move.w	#0,(COLOR).l
	rts
*
	xdef	lines_high
lines_high			dc.w	200
	xdef	sprite_screen_width
sprite_screen_width	dc.w	40
