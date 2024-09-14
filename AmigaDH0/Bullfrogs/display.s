FUNC_DISPLAY	=	1
FUNC_MUSIC		=	0
PLANESIZE	=	SCREEN_WIDTH*SCREEN_HEIGHT
******************************************************************************
	xdef	_display
_display
	movem.l	d0-d7/a0-a6,-(sp)
	jsr		_set_up_disc
_intro
	jsr		_intro_screen
.repeat

;	jsr		_wait_vbi				; wait for a vertical blank

;	jsr		_clear_screen
	jsr		_q_redraw

	jsr		_init					; initiate man.

	jsr		_draw_all				; draw all the sprites and things
.wait1
	move.w	$dff004,d0
	btst	#0,d0
	bne.s	.wait1
.wait2
	move.w	$dff004,d0
	btst	#0,d0
	beq.s	.wait2
	jsr		_swap_screens			; display the screen

	jsr		_move_all				; move all the sprites and things
	cmp.w	#NO_LIVES,game_over
	blt.s	.still_going
		jsr		_end_game
		jmp		_intro
.still_going
	cmp.b	#KB_Q,_iinkey			; have we pressed the Q key?
	bne		.repeat					; no then loop around

.the_end							; Oh we have then lets exit
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	even
	dc.l	0,0	
**************************************************************************
_lmul								; long multiply routine
	movem.l	d1-d3,-(sp)
	move.w	d0,d2
	move.w	d1,d3
	swap	d0
	swap	d1
	mulu	d2,d1
	mulu	d3,d0
	mulu	d3,d2
	add.w	d1,d0
	swap	d0
	clr.w	d0
	add.l	d2,d0
	movem.l	(sp)+,d1-d3
	rts
******************************************************************************
*						Random Number Routine								 *
******************************************************************************

_rnd										;takes d1 (0-d1)
	move.w	.seed(pc),d0
	mulu	#9377,d0
	add.w	#9439,d0
	move.w	d0,.seed
	and.l	#$7fff,d0						;make sure positive word

	divu	d1,d0
	swap	d0
	rts
.seed	dc.w	1972
******************************************************************************
_abs						; turn number to absolute
	tst.w	d0
	bpl.s	.positive
		neg.w	d0
.positive
	rts
******************************************************************************
*						Redraw a Background Screen							 *
******************************************************************************

_q_redraw			;needs a0 as data to copy

	BLIT_NASTY
	lea		_background,a0
	move.l	_w_screen,a1
	move.w	#SCREEN_HEIGHT*4<<6+(SCREEN_WIDTH/2),d1
;	lea		HARDWARE_REGS,a6

	wait_blit

	move.l	a0,BLTAPT
	move.l	a1,BLTDPT
	move.l	#$FFFFFFFF,BLTAFWM
	move.w	#0,BLTAMOD
	move.w	#0,BLTDMOD
	move.w	#$09F0,BLTCON0
	move.w	#0,BLTCON1
	move.w	d1,BLTSIZE
;
	wait_blit
	BLIT_NICE
;
	rts

******************************************************************************
_clear_all_registers
	moveq.l	#0,d0
	moveq.l	#0,d1
	moveq.l	#0,d2
	moveq.l	#0,d3
	moveq.l	#0,d4
	moveq.l	#0,d5
	moveq.l	#0,d6
	moveq.l	#0,d7
	move.l	d0,a0
	move.l	d0,a1
	move.l	d0,a2
	move.l	d0,a3
	move.l	d0,a4
	move.l	d0,a5
	move.l	d0,a6
	rts

******************************************************************************
quit					dc.w	0

_sp_screen								;where sprites can be drawn
	dc.l	0


title
backscreen
 	ds.b	32000
	even

an1	dc.l	0,0,0							;animation stack
******************************************************************************
* uses d0 as counter, a0 as screen
_clear_screen
	bsr		_clear_all_registers		; clear all registers
	move.l	_w_screen,a0				; find start of screen to clear
	lea		32000(a0),a0				; and move to the end of it
	moveq.w	#(615/5)-1,d0				; number of times we want to loop -1
.loop
	movem.l	d1-d7/a1-a6,-(a0)			; clear 52 bytes
	movem.l	d1-d7/a1-a6,-(a0)			; 5 times
	movem.l	d1-d7/a1-a6,-(a0) 
	movem.l	d1-d7/a1-a6,-(a0)
	movem.l	d1-d7/a1-a6,-(a0)
	dbra	d0,.loop
	movem.l	d1-d5,-(a0)					;clear off the last 20 bytes
	rts
	
	
