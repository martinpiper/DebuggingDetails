
********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Drawing			^ ^^ ^						   *
********************************************************************************

;All draw routines in here please.

_draw_all
	jsr		_draw_blocks
	move.w	man_x,d0							;x position
	asr.w	#FOUR,d0							;scale position
	move.w	man_y,d1							;y position
	asr.w	#FOUR,d1							;scale position
	move.w	man_frame,d2						;sprite to draw
	asr.w	#FOUR,d2							;slow down animation speed
	lea		_man,a1								;gfx data
	jsr		_simple_draw
	rts

********************************************************************************
_draw_blocks
* Therefore a2 points at map data
* d3,d4 is position inside map
* d0,d1 is position on screen

	lea		_map_data,a2			;point a2 at the map data
	move.w	#12-1,d4				;number of lines -1.
	move.w	#0,d0					;start x
	move.w	#0,d1					;start y
.loop_y
			move.w	#20-1,d3		;number of columns -1.
.loop_x
			move.b	(a2)+,d2		;pick up first byte of data
			beq.s	.next			;if zero dont draw anything
				sub.w	#1,d2		;subtract 1 to get correct block
				jsr		_block_draw	;and draw it
.next
			add.w	#1,d0			;increase x position
		dbra	d3,.loop_x			;subtract 1 from columns and loop
		move.w	#0,d0				;move to left side
		add.w	#1,d1				;and increase y position
;	dbra	d4,.loop_y				;sub 1 from rows and loop
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

********************************************************************************
;very simple blockdraw routine.
;d0 = x/16, d1 = y/16, d2 = block,

_block_draw
	movem.l	a0-a6/d0-d7,-(sp)				;save all registers
	move.l	_w_screen,a0					;point at screen
	lea		_blocks,a1						;point at block data
	asl.w	#TWO,d0							;find x position on screen
	asl.w	#SIXTEEN,d1						;find y position on screen
	mulu	#SCREEN_WIDTH,d1				;move down that no. of lines
	adda.l	d1,a0							;point at y
	adda.l	d0,a0							;point at x
	mulu	#128,d2							;find start of block to draw
	adda.l	d2,a1							;and move to it.
	moveq.w	#16-1,d2						;sprite height

.loop
		movem.w	(a1)+,d3/d4/d5/d6			;pick up all data
		move.w	d3,(a0)						;plane one
		move.w	d4,PLANE_SIZE(a0)			;plane two
		move.w	d5,PLANE_SIZE*2(a0)			;plane three
		move.w	d6,PLANE_SIZE*3(a0)			;plane four
		lea		SCREEN_WIDTH(a0),a0			;move to next line
	dbra	d2,.loop						;loop around 16 times
	movem.l	(sp)+,a0-a6/d0-d7				;restore all registers
	rts

********************************************************************************
