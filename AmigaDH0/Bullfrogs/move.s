********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Movement	    ^ ^^ ^						   *
********************************************************************************

MAX_SPEED			equ	16		;maximum speed of man
ACEL				equ	3		;speed of accleration for man
MAN_LEFT_START		equ	4*4		;start frame number for man running left
MAN_LEFT_FINISH		equ	1*4		;end frame number for man running left
MAN_STATIONARY		equ	5*4		;frame for man standing still
MAN_RIGHT_START		equ	6*4		;start frame number for man running right
MAN_RIGHT_FINISH	equ	9*4		;end frame number for man running right

********************************************************************************

_move_all
	jsr		_man_x			;move the man left and right
	jsr		_man_y			;move the man up and down
	jsr		_man_anim		;animate the man.
	rts						;return

********************************************************************************

*Move man left and right with joystick
*Uses the variables man_x	- mans x position on screen
*					man_vx	- mans current x velocity
*					_dx_joy	- reads the joystick x. -1 if left, 1 if right.
_man_x
	move.w	man_vx,d0			;move the value in man_vx into d0
	move.w	_dx_joy,d2			;move joystick value to d2
	mulu	#ACEL,d2			;multiply it by accleration
	add.w	d2,d0
	cmp.w	#MAX_SPEED,d0		;is the value in d0 is
	ble.s	.lessthanx			;less than or equal to the maximum speed
		move.w	#MAX_SPEED,d0	;if it isnt then change it back to max speed
.lessthanx
	cmp.w	#-MAX_SPEED,d0		;see if value in d0 is
	bge.s	.greaterthanx		;greater than or equal to the maximum speed
		move.w	#-MAX_SPEED,d0	;if not then replace with max speed
.greaterthanx

	move.w	man_x,d1			;where the man is
	add.w	d0,d1				;add his velocity
	bgt.s	.not_left_side		;if greater than 0 not at edge of screen
		move.w	#0,d0			;otherwise stop momentum
		move.w	#0,d1			;and place us at edge of screen
.not_left_side
	cmp.w	#300*4,d1			;at the right hand edge of screen?
	blt.s	.not_right_side		;no.  good.
		move.w	#0,d0			;otherwise stop momentum
		move.w	#300*4,d1		;place at edge of screen
.not_right_side

	tst.w	_dx_joy				;have we actual changed velocity
	bne.s	.no_reduction		;yes, then dont slow down
		tst.w	d0				;which way are we going
		beq.s	.no_reduction	;we are not moving
		blt.s	.going_left		;going left
.going_right					;where going right
			sub.w	#2,d0		;reduce speed
.going_left
			add.w	#1,d0		;reduce speed
.no_reduction					;finished
	move.w	d0,man_vx			;store new momentum
	move.w	d1,man_x			;store the new value in man_x
	rts							;return

********************************************************************************

*Place mans Y movement in here.
*Use the variables 	man_y	- mans y position on screen
*					man_vy	- mans current y velocity
*					_dy_joy	- reads the joystick y. -1 if up, 1 if down.

_man_y

	rts							;return


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


;;;