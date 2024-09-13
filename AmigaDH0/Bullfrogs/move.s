********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Movement	    ^ ^^ ^						   *
********************************************************************************

;LEVEL				equ	0		;Current Level 0 or 1
GRAVITY				equ	2		;Speed at which gravity affects man
MAX_SPEED			equ	16		;maximum speed of man
JUMP				equ	20
ACEL				equ	3		;speed of accleration for man
MAN_LEFT_START		equ	4*4		;start frame number for man running left
MAN_LEFT_FINISH		equ	1*4		;end frame number for man running left
MAN_STATIONARY		equ	5*4		;frame for man standing still
MAN_RIGHT_START		equ	6*4		;start frame number for man running right
MAN_RIGHT_FINISH	equ	9*4		;end frame number for man running right
LEFT_FOOT			equ	3		;mans left foot
RIGHT_FOOT			equ	10		;mans right foot
 
********************************************************************************

_move_all
	tst.w	_pressed_fire				;are we in the middle of a jump	
	bne.s	.no_fire					;yes so dont check for jump
		tst.w	_fire					;is the fire button pressed
		beq.s	.no_fire				;no so dont jump
			move.w	#-JUMP,man_vy		;yes it was, jump into y-velocity
			move.w	#1,_pressed_fire	;and set jump flag
.no_fire
	jsr		_man_x			;move the man left and right
	jsr		_man_y			;move the man up and down
	jsr		_man_anim		;animate the man.
	jsr		_map_collision	;has the man hit a block
	rts						;return

********************************************************************************

*Move man left and right with joystick
*Uses the variables man_x	- mans x position on screen
*					man_vx	- mans current x velocity
*					_dx_joy	- reads the joystick x. -1 if left, 1 if right.
_man_x
	move.w	man_vx,d0			;move the value in man_vx into d0
	move.w	#0,d2
	tst.w	_pressed_fire			;are we jumping
	bne.s	.jumping
		move.w	_dx_joy,d2			;move joystick value to d2
		mulu	#ACEL,d2			;multiply it by accleration
		add.w	d2,d0
		cmp.w	#MAX_SPEED+1,d0		;is the value in d0 is
		ble.s	.lessthanx			;less than or equal to the maximum speed
			move.w	#MAX_SPEED+1,d0	;if it isnt then change it back to max speed
.lessthanx
		cmp.w	#-MAX_SPEED-1,d0	;see if value in d0 is
		bge.s	.greaterthanx		;greater than or equal to the maximum speed
			move.w	#-MAX_SPEED-1,d0	;if not then replace with max speed
.greaterthanx
.jumping
	move.w	man_x,d1				;where the man is
	add.w	d0,d1					;add his velocity
	bgt.s	.not_left_side			;if greater than 0 not at edge of screen
		move.w	#0,d0				;otherwise stop momentum
		move.w	#0,d1				;and place us at edge of screen
.not_left_side
	cmp.w	#304*4,d1				;at the right hand edge of screen?
	blt.s	.not_right_side			;no.  good.
		move.w	#0,d0				;otherwise stop momentum
		move.w	#304*4,d1			;place at edge of screen
.not_right_side

	tst.w	_dx_joy					;have we actual changed velocity
	bne.s	.no_reduction			;yes, then dont slow down
		tst.w	d0					;which way are we going
		beq.s	.no_reduction		;we are not moving
		blt.s	.going_left			;going left
.going_right						;where going right
			sub.w	#2,d0			;reduce speed
.going_left
			add.w	#1,d0			;reduce speed
.no_reduction						;finished
	move.w	d0,man_vx				;store new momentum
	move.w	d1,man_x				;store the new value in man_x
	rts								;return

********************************************************************************


_man_y
	move.w	#1,_pressed_fire		;set falling/jump flag
	move.w	man_y,d0				;get man y position
	move.w	man_vy,d1				;get man y velocity
	add.w	#GRAVITY,d1				;add gravity to it
	cmp.w	#MAX_SPEED,d1			;see if we have gone over max speed
	ble.s	.below_max_speed		;no then jump past this bit
		move.w	#MAX_SPEED,d1		;yes, place max speed into d1
.below_max_speed
	add.w	d1,d0					;change position by speed
	move.w	d0,man_y				;store new position
	move.w	d1,man_vy				;store new speed
	rts								;return


********************************************************************************

*Animation of man.
_man_anim
	move.w	man_frame,d0				;pick up current frame of man
	tst.w	man_vx						;see if man is stationary
	beq.s	.stationary_man				;he is so goto that code
	blt.s	.man_move_left				;is he going left
		add.w	#1,d0					;no so add 1 to animation frame
		cmp.w	#MAN_RIGHT_FINISH,d0	;see if we have got to the end
		blt.s	.finished_anim			;if not then we have finished
			move.w	#MAN_RIGHT_START,d0	;otherwise replace with start anim
			bra.s	.finished_anim		;again we have finished
.man_move_left							;OK so we are going left
		sub.w	#1,d0					;subtract 1 from animation frame
		cmp.w	#MAN_LEFT_FINISH,d0		;have we got to end of animation
		bgt.s	.finished_anim			;no then we have finished
			move.w	#MAN_LEFT_START,d0	;yes, so restart animation
			bra.s	.finished_anim		;again we have finished
.stationary_man							;the man is not moving
	move.w	#MAN_STATIONARY,d0			;so lets put the animation frame in
.finished_anim							;finished changing things
	move.w	d0,man_frame				;so put back current frame
	rts									;and return.

********************************************************************************
_map_collision
	move.w	man_x,d0					;mans x position
	move.w	man_y,d1					;mans y position
	lea		_map_data,a0				;point at map data
	asr.w	#FOUR,d0					;hi res co-ord
	move.w	d0,d4						;take a copy of current x
	add.w	#LEFT_FOOT,d0				;his feet size
	asr.w	#SIXTEEN,d0					;block coord

	asr.w	#FOUR,d1					;hi res co-ord
	add.w	#24,d1						;find bottom of man
	asr.w	#FOUR,d1					;scale down
	btst	#0,d1						;is this an odd number
	bne.s	.no_collision				;yes, then no collide
		btst	#1,d1					;is the second bit set
		bne.s	.no_collision			;yes, then no collide
			asr.w	#FOUR,d1			;scale y position rest of way down

			move.w	d1,d3				;copy of current y
			mulu	#20,d1				;offset into map data
			adda.l	d1,a0				;move to start of line
			adda.l	d0,a0				;move to column
			tst.b	(a0)				;is this a block or not
			bne.s	.collision			;yes then goto collide
										;that was his left foot, now do
										;his right foot
			lea		_map_data,a0		;point at data
			adda.l	d1,a0				;move to start row
			add.w	#RIGHT_FOOT,d4		;change x by size of foot
			asr.w	#SIXTEEN,d4			;and scale down to grid
			adda.l	d4,a0				;move into data
			tst.b	(a0)				;is this a block
			beq.s	.no_collision		;no then finished here
.collision
				clr.w	_pressed_fire	;clear falling flag as on a block
				move.w	#-1,man_vy		;stop mans speed
				asl.w	#SIXTEEN,d3		;and recalculate his y position
				sub.w	#24,d3			;so that he is standing
				asl.w	#FOUR,d3		;on top of the block
				move.w	d3,man_y		;store his new y position

.no_collision
	rts									;finished

********************************************************************************

;;;