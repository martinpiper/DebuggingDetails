********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Movement	    ^ ^^ ^						   *
********************************************************************************

_move_all
	tst.w	died
	bne.s	.died
		tst.w	_pressed_fire				;are we in the middle of a jump	
		bne.s	.no_fire					;yes so dont check for jump
			tst.w	_fire					;is the fire button pressed
			beq.s	.no_fire				;no so dont jump
				move.w	#-JUMP,man_vy		;yes it was, jump into y-velocity
				move.w	#1,_pressed_fire	;and set jump flag
.no_fire
	jsr		_man_x			;move the man left and right
.died
	jsr		_man_y			;move the man up and down
	jsr		_man_anim		;animate the man.
	jsr		_bad_move		;move any bad guys
	jsr		_map_collision	;has the man hit a block
	jsr		_collect_collision	;have we picked up a collectable.
	jsr		_bad_collision	;have we touched one of the bad guys.
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
			sub.w	#SLOW_DOWN,d0	;reduce speed
			bge.s	.finished_slow_down
			move.w	#0,d0
			bra.s	.finished_slow_down
.going_left
			add.w	#1,d0			;reduce speed
			ble.s	.finished_slow_down
			move.w	#0,d0
.finished_slow_down
.no_reduction						;finished
	move.w	d0,man_vx				;store new momentum
	move.w	d1,man_x				;store the new value in man_x
	rts								;return

********************************************************************************


_man_y
	tst.w	died
	bne.s	.finished
		move.w	#1,_pressed_fire		;set falling/jump flag
		move.w	man_y,d0				;get man y position
		move.w	man_vy,d1				;get man y velocity
		add.w	#GRAVITY,d1				;add gravity to it
		cmp.w	#MAX_SPEED,d1			;see if we have gone over max speed
		ble.s	.below_max_speed		;no then jump past this bit
			add.w	#1,fallen
			move.w	#MAX_SPEED,d1		;yes, place max speed into d1
.below_max_speed
		add.w	d1,d0					;change position by speed
		cmp.w	#200*4,d0
		blt.s	.still_on_screen
			move.w	#-48,d0
.still_on_screen
		move.w	d0,man_y				;store new position
		move.w	d1,man_vy				;store new speed
.finished
	rts								;return



********************************************************************************

*Animation of man.
_man_anim
	move.w	man_frame,d0				;pick up current frame of man
	tst.w	man_vx						;see if man is stationary
	beq.s	.stationary_man				;he is so goto that code
;	tst.w	_dx_joy
	blt.s	.man_move_left				;is he going left
		cmp.w	#MAN_RIGHT_START,d0
		bge.s	.already_going_right
			move.w	#MAN_RIGHT_START,d0
.already_going_right

		add.w	#1,d0					;no so add 1 to animation frame
		cmp.w	#MAN_RIGHT_FINISH,d0	;see if we have got to the end
		blt.s	.finished_anim			;if not then we have finished
			move.w	#MAN_RIGHT_START,d0	;otherwise replace with start anim
			bra.s	.finished_anim		;again we have finished
.man_move_left							;OK so we are going left
		cmp.w	#MAN_LEFT_START,d0
		ble.s	.already_going_left
			move.w	#MAN_LEFT_START,d0
.already_going_left

		sub.w	#1,d0					;subtract 1 from animation frame
		cmp.w	#MAN_LEFT_FINISH,d0		;have we got to end of animation
		bgt.s	.finished_anim			;no then we have finished
			move.w	#MAN_LEFT_START,d0	;yes, so restart animation
			bra.s	.finished_anim		;again we have finished
.stationary_man							;the man is not moving
	cmp.w	#MAN_BOUNCE,d0				;has the man just landed
	blt.s	.no_he_hasnt
		add.w	#1,d0
		cmp.w	#MAN_BOUNCE+4,d0
		blt.s	.finished_anim
			tst.w	died
			beq.s	.no_he_hasnt
				cmp.w	#MAN_CRUMBLE_FINISH,d0
				blt.s	.finished_anim
					sub.w	#1,total_levels
					move.w	#0,to_collect
					move.w	#1,new_level
					move.w	#0,died
					sub.w	#1,current_level
					add.w	#1,game_over
					move.w	#MAN_CRUMBLE_FINISH,d0
					bra.s	.finished_anim
.no_he_hasnt
	move.w	#MAN_STATIONARY,d0			;so lets put the animation frame in
.finished_anim							;finished changing things
	move.w	d0,man_frame				;so put back current frame
	rts									;and return.

********************************************************************************
_map_collision
	move.w	man_x,d0					;mans x position
	move.w	man_y,d1					;mans y position
	move.l	map_pointer,a0				;point at map data
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
			move.l	map_pointer,a0		;point at data
			adda.l	d1,a0				;move to start row
			add.w	#RIGHT_FOOT,d4		;change x by size of foot
			asr.w	#SIXTEEN,d4			;and scale down to grid
			adda.l	d4,a0				;move into data
			tst.b	(a0)				;is this a block
			beq.s	.no_collision		;no then finished here
.collision
				cmp.w	#MAX_SPEED,man_vy
				bne.s	.no_change
					move.w	#MAN_BOUNCE,man_frame
					cmp.w	#MAX_FALL,fallen
					blt.s	.still_alive
						move.w	#0,man_vx
						move.w	#1,died
.still_alive
						move.w	#0,fallen
.no_change
				clr.w	_pressed_fire	;clear falling flag as on a block
				move.w	#-1,man_vy		;stop mans speed
				asl.w	#SIXTEEN,d3		;and recalculate his y position
				sub.w	#24,d3			;so that he is standing
				asl.w	#FOUR,d3		;on top of the block
				move.w	d3,man_y		;store his new y position

.no_collision
	rts									;finished

********************************************************************************
_collect_collision

	move.w	man_x,d0			;pick up our man_x position
	asr.w	#FOUR,d0			;scale down to a screen co-ord
	move.w	man_y,d1			;pick up our man_y position
	asr.w	#FOUR,d1			;scale down to a screen co-ord
	move.w	d0,d2				;take a copy of x
	add.w	#MAN_WIDTH,d2		;and add the width of our man to it
	move.w	d1,d3				;take a copy of y
	add.w	#MAN_HEIGHT,d3		;and add the height of our man to it

	lea		_objects,a0			;point at our objects
	move.w	#MAX_OBJECTS-1,d7	;counter of how many objects to look at
.loop
	tst.w	OBJ_ON(a0)			;is the first one present
	beq.s	.next				;no so lets look at the next on
		move.w	OBJ_X(a0),d4	;yes it was, get the object x
		move.w	OBJ_Y(a0),d5	;and y values
		cmp.w	d3,d5			;Is the bottom of the man greater than the
								;top of the object.
		bgt.s	.no_collision	;yes then we cant collide with it.
		add.w	#ANKH_HEIGHT,d5	;move to top of the object
		cmp.w	d1,d5			;is the top of the man less than the
								;the bottom of the object
		blt.s	.no_collision	;yes then we cant collide with it
		cmp.w	d2,d4			;compare right of man with left of object
		bgt.s	.no_collision	;if it is greater then we cant collide
		add.w	#ANKH_WIDTH,d4	;move to the right side of object
		cmp.w	d0,d4			;compare left of man with right of object
		blt.s	.no_collision	;if less than then we cant collide with it
			move.w	#0,OBJ_ON(a0)	;clear out the object as we have just touched it
			sub.w	#1,to_collect	;reduce the number left to get
			move.w	total_levels,d6	;as compute the score
			mulu	#SCORE,d6		;that is received by getting the object
			add.w	d6,score		;score = level * multiplier
			move.w	#DELAY,delay	;place a delay to stop instant jump
.next								;we want to get the next object
.no_collision						;because the last one did not exist or we
									;didnt touch it.
		lea		OBJ_SIZE(a0),a0		;so move the pointer to the next object
	dbra	d7,.loop				;repeat until there are no more objects
	rts

********************************************************************************
_bad_move
	lea		_bad_guys,a0
	moveq.w	#MAX_BADDIES,d0
.loop
	move.w	BAD_ON(a0),d1
	beq.s	.next
		asl.w	#TWO,d1
		move.w	.jump_table(pc,d1.w),d1
		jmp		.jump_table(pc,d1.w)
.jump_table	dc.w	.spare-.jump_table
			dc.w	.bad_left-.jump_table
			dc.w	.bad_middle-.jump_table
			dc.w	.bad_middle-.jump_table
			dc.w	.bad_right-.jump_table

.bad_left
	jsr		_bad_left
	bra.s	.next
.bad_middle
	jsr		_bad_middle
	bra.s	.next
.bad_right
	jsr		_bad_right
;	bra.s	.next
.spare
.next
	lea		BAD_SIZE(a0),a0
	dbra	d0,.loop
	rts
********************************************************************************
_bad_left
	sub.w	#1,BAD_DELAY(a0)
	bne.s	.no_change
		move.w	#BAD_FRAME_DELAY,BAD_DELAY(a0)
		add.w	#1,BAD_FRAME(a0)
		cmp.w	#BAD_LEFT_END,BAD_FRAME(a0)
		ble.s	.changed
			move.w	#BAD_LEFT_START,BAD_FRAME(a0)
.changed
.no_change
	move.w	BAD_X(a0),d2
	sub.w	#1,d2
	blt.s	.off_side_of_screen
		move.w	d2,d3
		jsr		_still_on_floor
		tst.w	d3
		bne.s	.still_on_floor
.off_side_of_screen
			add.w	#1,d2
			move.w	#BAD_STATE_FROM_LEFT,BAD_STATE(a0)
			move.w	#BAD_MIDDLE,BAD_FRAME(a0)
			move.w	#BAD_FRAME_DELAY,BAD_DELAY(a0)
.still_on_floor
		move.w	d2,BAD_X(a0)
	rts
********************************************************************************
_bad_middle
	sub.w	#1,BAD_DELAY(a0)
	bne.s	.no_change
		move.w	#BAD_FRAME_DELAY,BAD_DELAY(a0)
		cmp.w	#BAD_STATE_FROM_LEFT,BAD_STATE(a0)
		beq.s	.came_from_left
.came_from_right
			move.w	#BAD_STATE_LEFT,BAD_STATE(a0)
			move.w	#BAD_LEFT_START,BAD_FRAME(a0)
			bra.s	.finished
.came_from_left
			move.w	#BAD_STATE_RIGHT,BAD_STATE(a0)
			move.w	#7,BAD_FRAME(a0)
;			bra.s	.finished
.finished
.no_change
	rts
********************************************************************************
_bad_right
	sub.w	#1,BAD_DELAY(a0)
	bne.s	.no_change
		move.w	#BAD_FRAME_DELAY,BAD_DELAY(a0)
		add.w	#1,BAD_FRAME(a0)
		cmp.w	#BAD_RIGHT_END,BAD_FRAME(a0)
		ble.s	.changed
			move.w	#BAD_RIGHT_START,BAD_FRAME(a0)
.changed
.no_change
	move.w	BAD_X(a0),d2
	add.w	#1,d2
	cmp.w	#304,BAD_X(a0)
	bgt.s	.off_side_of_screen
		move.w	d2,d3
		add.w	#16,d3
		jsr		_still_on_floor
		tst.w	d3
		bne.s	.still_on_floor
.off_side_of_screen
		sub.w	#1,d2
		move.w	#BAD_STATE_FROM_RIGH,BAD_STATE(a0)
		move.w	#BAD_MIDDLE,BAD_FRAME(a0)
		move.w	#BAD_FRAME_DELAY,BAD_DELAY(a0)
.still_on_floor
	move.w	d2,BAD_X(a0)
	rts
********************************************************************************
_still_on_floor
	move.l	map_pointer,a1
	moveq.l	#0,d4
	move.w	BAD_Y(a0),d4
	asr.w	#SIXTEEN,d4
	add.w	#1,d4
	mulu	#20,d4
	adda.l	d4,a1
	asr.w	#SIXTEEN,d3
	adda.l	d3,a1
	move.b	(a1),d3
	rts
********************************************************************************
*place the collision with the bad guys here.

_bad_collision

	tst.w	died					;our we in the middle of dying
	bne.s	.finished				;yes then we cant collide with anything
	cmp.w	#NO_LIVES,game_over		;is the game over
	bgt.s	.finished				;yes then again we cant collide with anything

	lea		_bad_guys,a0			;point at the bad guys structures
	move.w	#MAX_BADDIES-1,d0		;number of baddies to look at
.loop
	tst.w	BAD_ON(a0)				;is this guy turned on
	beq.s	.next					;no then move to the next one
		movem.w	BAD_XY(a0),d1/d2	,pick up x and y position of man
		movem.w	man_x,d5/d6			;pick up the heros x and y position
		asr.w	#FOUR,d5			;scale down the x
		asr.w	#FOUR,d6			;scale down the y
		move.w	d1,d3				;take a copy of bad x
		move.w	d2,d4				;take a copy of bad y
		add.w	#BAD_RIGHT_WIDTH,d3	;find the right hand side of the bad guy
		cmp.w	d3,d5				;and see if we are on the left hand edge
		bge.s	.no_collision		;no, then we cant collide
		add.w	#BAD_BOTTOM_HEIGHT,d4	;find the bottom side of the bad guy
		cmp.w	d4,d6				;are we on above this, ie smaller number
		bge.s	.no_collision		;no then we cant collide
		add.w	#MAN_WIDTH,d5		;increase the mans x position by his width
		add.w	#BAD_LEFT_WIDTH,d1	;and find the left hand side of the bad guy
		cmp.w	d1,d5				;are we to the right of this
		ble.s	.no_collision		;no then we cant collide with the man
		add.w	#MAN_HEIGHT,d6		;find the height of hero
		add.w	#BAD_TOP_HEIGHT,d2	;and the height of the bad guy
		cmp.w	d2,d6				;compare are we below the top of our bad guy
		ble.s	.no_collision		;no then we cant collide again
									;if we have got to here, the we have collided
			move.w	#0,man_vx		;so cancel the mans velocity
			move.w	#1,died			;set the died flag
			move.w	#MAN_CRUMBLE_START,man_frame	;and the animation frame
.no_collision
.next
	lea		BAD_SIZE(a0),a0			;move onto the next bad guy
	dbra	d0,.loop				;until there are no more to check
.finished

	rts								;finished so return
********************************************************************************

;;;