
********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Drawing			^ ^^ ^						   *
********************************************************************************

;All draw routines in here please.

_draw_all
	move.w	man_x,d0							;x position
	asr.w	#FOUR,d0							;scale position
	move.w	man_y,d1							;y position
	move.w	man_frame,d2						;sprite to draw
	asr.w	#FOUR,d2							;slow down animation speed
	lea		_man,a1								;gfx data
	jsr		_simple_draw
	rts

********************************************************************************
;very simple interface for tutorial
;d0,d1 x,y pos d2 sprite no and a1 points at data

_simple_draw
	movem.l	a0-a6/d0-d7,-(sp)
	mulu	#240,d2
	adda.l	d2,a1
	moveq.w	#24,d2							;sprite height
	move.l	_w_screen,a0
	jsr		_s16_draw						;d0=x,d1=y,d2=height,a0=screen,a1=data
	movem.l	(sp)+,a0-a6/d0-d7
	rts
