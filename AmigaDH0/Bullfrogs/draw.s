
********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Drawing			^ ^^ ^						   *
********************************************************************************

;All draw routines in here please.

_draw_all
	jsr		_draw_blocks
	jsr		_draw_collectables
	jsr		_draw_bad_guys
	jsr		_draw_score
	jsr		_lives_left
;	jsr		_draw_logo
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

	move.l	map_pointer,a2			;point a2 at the map data
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
	dbra	d4,.loop_y				;sub 1 from rows and loop
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
		move.w	d3,d7
		or.w	d4,d7
		or.w	d5,d7
		or.w	d6,d7
		not.w	d7

		and.w	d7,(a0)
		or.w	d3,(a0)						;plane one
		and.w	d7,PLANE_SIZE(a0)
		or.w	d4,PLANE_SIZE(a0)			;plane two
		and.w	d7,PLANE_SIZE*2(a0)
		or.w	d5,PLANE_SIZE*2(a0)			;plane three
		and.w	d7,PLANE_SIZE*2(a0)
		or.w	d6,PLANE_SIZE*3(a0)			;plane four
		lea		SCREEN_WIDTH(a0),a0			;move to next line
	dbra	d2,.loop						;loop around 16 times
	movem.l	(sp)+,a0-a6/d0-d7				;restore all registers
	rts

********************************************************************************

_draw_collectables
	lea		_objects,a2
	move.w	#MAX_OBJECTS-1,d7

.loop
	tst.w	OBJ_ON(a2)
	beq.s	.next
		movem.w	OBJ_TO_DRAW(a2),d0/d1/d2
		move.l	_w_screen,a0
		lea		_collect,a1
		mulu	#SCREEN_WIDTH,d1
		adda.w	d1,a0
		asr.w	#EIGHT,d0
		adda.w	d0,a0
		mulu	#128,d2
		adda.w	d2,a1
		move.w	#16-1,d0
;		move.l	_w_screen,a0
;		lea		_collect,a1
.draw_loop
			movem.w	(a1)+,d1/d2/d3/d4
			move.w	d1,(a0)
			move.w	d2,PLANE_SIZE(a0)
			move.w	d3,PLANE_SIZE*2(a0)
			move.w	d4,PLANE_SIZE*3(a0)
			lea		SCREEN_WIDTH(a0),a0
		dbra	d0,.draw_loop
.next
	lea		OBJ_SIZE(a2),a2
	dbra	d7,.loop
	rts
********************************************************************************
_draw_score
	lea		_score_text,a0
	move.l	#0,d0
	move.w	score,d0
;	ext.l	d0
	move.w	#5,d1
	adda.l	#7,a0
	jsr		_to_alpha

	move.w	#1,d0
	move.w	#192,d1
	lea		_score_text,a2
	jsr		_draw_font
	rts
********************************************************************************
*pass x block, pixal perfect y, a2 points to text to print
_draw_font
	mulu	#SCREEN_WIDTH,d1
.begin
	move.b	(a2)+,d2				;look at letter
	beq.s	.finished
	cmp.b	#32,d2
	beq.s	.next
		ext.w	d2
		sub.w	#33,d2
		lea		_font,a1
		asl.w	#EIGHT,d2
		adda.w	d2,a1

		move.l	_w_screen,a0
		adda.w	d1,a0
		adda.w	d0,a0

		move.w	#8-1,d3
.draw_loop
			move.b	(a1)+,(a0)
			lea		SCREEN_WIDTH(a0),a0
		dbra	d3,.draw_loop
.next
	add.w	#1,d0
	bra.s	.begin
.finished
	rts
********************************************************************************
_draw_bad_guys
	lea		_bad_guys,a0
	moveq.w	#MAX_BADDIES,d3
.loop
	tst.w	BAD_ON(a0)
	beq.s	.next
		movem.w	BAD_TO_DRAW(a0),d0/d1/d2
		movem.l	a0-a6/d0-d7,-(sp)
		lea		_bad,a1
		mulu	#160,d2
		adda.l	d2,a1
		moveq.w	#16,d2							;sprite height
		move.l	_w_screen,a0
		jsr		_s16_draw						;d0=x,d1=y,d2=height,a0=screen,a1=data
		movem.l	(sp)+,a0-a6/d0-d7
.next
	lea		BAD_SIZE(a0),a0
	dbra	d3,.loop
	rts

********************************************************************************

_lives_left
	move.w	#272,d0								;x position
	move.w	#176,d1								;y position
	move.w	#MAN_STATIONARY,d2					;sprite to draw
	asr.w	#FOUR,d2
	lea		_man,a1								;gfx data
	move.w	#1,d3
	sub.w	game_over,d3
	blt.s	.nothing_to_draw
.loop
	jsr		_simple_draw
	add.w	#16,d0
	dbra	d3,.loop
.nothing_to_draw
	rts
********************************************************************************

