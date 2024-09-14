********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 	 Introduction	    ^ ^^ ^						   *
********************************************************************************

_intro_screen
	clr.w	_fire
.repeat
;	jsr		_wait_vbi				; wait for a vertical blank
	lea		_background,a0
	jsr		_q_redraw

	jsr		_draw_credits
	
	jsr		_draw_logo

.wait1
	move.w	$dff004,d0
	btst	#0,d0
	bne.s	.wait1
.wait2
	move.w	$dff004,d0
	btst	#0,d0
	beq.s	.wait2

	jsr		_swap_screens			; display the screen

	jsr		_move_credits

	tst.w	_fire
	beq		.repeat					; no then loop around
	clr.w	_fire
	clr.w	game_over
	clr.w	current_level
	clr.w	score
	rts
	even
mess_1	dc.b	'HELLO AND WELCOME',0
	even
mess_2	dc.b	'TO',0
	even
mess_3	dc.b	'A PRACTICAL GUIDE',0
	even
mess_4	dc.b	'HOW TO PROGRAM IN ASSEMBLER',0
	even
mess_5	dc.b	'WRITTEN BY SCOTT JOHNSTON',0
	even
mess_6	dc.b	'MUSIC BY KEVIN EARL',0
	even
mess_7	dc.b	'HIGHEST SCORE',0
	even
mess_8	dc.b	    '     ',0
mess_1y	dc.w	0
mess_2y	dc.w	0
mess_3y	dc.w	0
mess_4y	dc.w	0
mess_5y	dc.w	0
mess_6y	dc.w	0
logo_d	dc.w	1
logo_y	dc.w	30
********************************************************************************

_draw_logo

	move.w	logo_y,d0
	add.w	logo_d,d0
	blt.s	.neg_d
	cmp.w	#200,d0
	ble.s	.finished
.neg_d
	neg.w	logo_d
.finished
	move.w	d1,logo_d


	move.w	logo_y,d1
	moveq.w	#112,d0
	lea		_logo,a1
	moveq.w	#96,d2							;sprite height
	move.l	_w_screen,a0
	jsr		_s32_draw						;d0=x,d1=y,d2=height,a0=screen,a1=data
	move.w	logo_y,d1
	qmove.w	146,d0
;	moveq.l	#1,d2
	lea		_logo,a1
;	mulu	#1920,d2
	adda.w	#1920,a1
	moveq.w	#96,d2							;sprite height
	move.l	_w_screen,a0
	jsr		_s32_draw						;d0=x,d1=y,d2=height,a0=screen,a1=data

	wait_blit

	rts

********************************************************************************
_draw_credits	
	moveq.w	#10,d0
	move.w	mess_1y,d1
	lea		mess_1,a2
	jsr		_draw_font

	moveq.w	#17,d0
	move.w	mess_2y,d1
	lea		mess_2,a2
	jsr		_draw_font

	moveq.w	#10,d0
	move.w	mess_3y,d1
	lea		mess_3,a2
	jsr		_draw_font

	moveq.w	#5,d0
	move.w	mess_4y,d1
	lea		mess_4,a2
	jsr		_draw_font

	moveq.w	#6,d0
	move.w	mess_5y,d1
	lea		mess_5,a2
	jsr		_draw_font

	moveq.w	#9,d0
	move.w	mess_6y,d1
	lea		mess_6,a2
	jsr		_draw_font


	moveq.w	#12,d0
	move.w	#180,d1
	lea		mess_7,a2
	jsr		_draw_font

	lea		mess_8,a0
	moveq.l	#0,d0
	move.w	high_score,d0
	moveq.w	#5,d1
	jsr		_to_alpha

	moveq.w	#16,d0
	move.w	#192,d1
	lea		mess_8,a2
	jsr		_draw_font
	rts
********************************************************************************
_move_credits
	

	move.w	mess_1y,d0
	subq.w	#1,d0
	cmp.w	#10,d0
	bgt.s	.no_at_y1
		moveq.w	#10,d0
.no_at_y1
	move.w	d0,mess_1y

	move.w	mess_2y,d0
	addq.w	#1,d0
	cmp.w	#20,d0
	blt.s	.no_at_y2
		moveq.w	#20,d0
.no_at_y2
	move.w	d0,mess_2y

	move.w	mess_3y,d0
	addq.w	#1,d0
	cmp.w	#30,d0
	blt.s	.no_at_y3
		moveq.w	#30,d0
.no_at_y3
	move.w	d0,mess_3y

	move.w	mess_4y,d0
	addq.w	#1,d0
	cmp.w	#50,d0
	blt.s	.no_at_y4
		moveq.w	#50,d0
.no_at_y4
	move.w	d0,mess_4y

	move.w	mess_5y,d0
	addq.w	#1,d0
	cmp.w	#80,d0
	blt.s	.no_at_y5
		moveq.w	#80,d0
.no_at_y5
	move.w	d0,mess_5y

	move.w	mess_6y,d0
	addq.w	#1,d0
	cmp.w	#100,d0
	blt.s	.no_at_y6
		moveq.w	#100,d0
.no_at_y6
	move.w	d0,mess_6y

	rts
********************************************************************************
