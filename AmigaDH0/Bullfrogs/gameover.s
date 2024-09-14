********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 	   Game Over	    ^ ^^ ^						   *
********************************************************************************

_end_game
	move.w	score,d0
	move.w	high_score,d1

	cmp.w	d0,d1
	bge.s	.not_new_high
		move.w	score,high_score
.not_new_high
	lea		mess_8,a0
	moveq.l	#0,d0
	move.w	high_score,d0
	moveq.w	#5,d1
	jsr		_to_alpha

.repeat
	jsr		_wait_vbi				; wait for a vertical blank
	lea		_background,a0
	jsr		_q_redraw


	move.w	#14,d0
	move.w	logo_y,d1
	bge.s	.still_pos
		neg.w	d1
.still_pos

	lsr.w	#2,d1
	lea		.mess,a2
	jsr		_draw_font

	moveq.w	#12,d0
	move.w	#180,d1
	lea		mess_7,a2
	jsr		_draw_font


	moveq.w	#16,d0
	move.w	#192,d1
	lea		mess_8,a2
	jsr		_draw_font

	jsr		_draw_logo

	jsr		_swap_screens			; display the screen

	tst.w	_fire
	beq		.repeat					; no then loop around

.to_here
	rts
.mess	dc.b	'GAME OVER',0
	even
********************************************************************************
********************************************************************************
