********************************************************************************
*			   oo							          oo					   *
*			 \(  )/	   Bullfrog Programming Demo	\(  )/					   *
*			 ^ ^^ ^ 								^ ^^ ^					   *
********************************************************************************

_init
	tst.w	delay
	beq.s	.let_do_init
		sub.w	#1,delay
		bra		.not_init
.let_do_init
	cmp.w	#NO_LIVES,game_over
	bge.s	.not_alive

		tst.w	to_collect
		bne.s	.not_init
		move.w	#0,fallen
		bsr		_clear_objects
		bsr		_clear_bad_guys

		move.w	current_level,d0
		bge.s	.on_last_level
			move.w	#MAX_LEVELS-1,d0
.on_last_level
		asl.w	#TWO,d0
		add.w	#1,current_level
		add.w	#1,total_levels
		cmp.w	#MAX_LEVELS,current_level
		bne.s	.ok
			move.w	#0,current_level
.ok
		move.w	#0,man_vx
		move.w	#150*4,man_y
		move.w	#0,man_x
		move.w	.init_table(pc,d0.w),d0
		jmp		.init_table(pc,d0.w)
	even
.init_table	dc.w	lev0-.init_table
			dc.w	lev1-.init_table
			dc.w	lev2-.init_table
			dc.w	lev3-.init_table

*insert extra level labels into jump table here

			dc.w	.not_init-.init_table

.not_alive
	move.w	#1,died
.not_init
	rts

lev0
	lea		_map0,a0
	move.l	a0,map_pointer
	lea		_objects,a0
	move.w	#1,OBJ_ON(a0)
	lea		OBJ_SIZE(a0),a0
	move.w	#1,OBJ_ON(a0)
	move.w	#304,OBJ_X(a0)

	lea		OBJ_SIZE(a0),a0
	move.w	#1,OBJ_ON(a0)
	move.w	#96,OBJ_X(a0)

	lea		OBJ_SIZE(a0),a0
	move.w	#1,OBJ_ON(a0)
	move.w	#304,OBJ_X(a0)
	move.w	#50,OBJ_Y(a0)

	lea		OBJ_SIZE(a0),a0
	move.w	#1,OBJ_ON(a0)
	move.w	#192,OBJ_X(a0)
	move.w	#4,to_collect

	lea		_bad_guys,a0
	move.w	#BAD_STATE_LEFT,BAD_ON(a0)
	move.w	#160,BAD_X(a0)
	move.w	#160,BAD_Y(a0)
	move.w	#BAD_LEFT_START,BAD_FRAME(a0)

	lea		BAD_SIZE(a0),a0
	move.w	#BAD_STATE_RIGHT,BAD_ON(a0)
	move.w	#176,BAD_X(a0)
	move.w	#160,BAD_Y(a0)
	move.w	#BAD_RIGHT_START,BAD_FRAME(a0)

	lea		BAD_SIZE(a0),a0
	move.w	#BAD_STATE_RIGHT,BAD_ON(a0)
	move.w	#176,BAD_X(a0)
	move.w	#0,BAD_Y(a0)
	move.w	#BAD_RIGHT_START,BAD_FRAME(a0)
	rts

lev1
	lea		_map1,a0
	move.l	a0,map_pointer
	lea		_objects,a0
	move.w	#1,OBJ_ON(a0)
	move.w	#112,OBJ_X(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#128,OBJ_X(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#144,OBJ_X(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#160,OBJ_X(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#176,OBJ_X(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#192,OBJ_X(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#64,OBJ_X(a0)
	move.w	#48,OBJ_Y(a0)
	lea		OBJ_SIZE(a0),a0

	move.w	#1,OBJ_ON(a0)
	move.w	#240,OBJ_X(a0)
	move.w	#48,OBJ_Y(a0)
	move.w	#8,to_collect

	lea		_bad_guys,a0
	move.w	#1,BAD_ON(a0)
	move.w	#80,BAD_X(a0)
	move.w	#96,BAD_Y(a0)
	lea		BAD_SIZE(a0),a0

	move.w	#1,BAD_ON(a0)
	move.w	#112,BAD_X(a0)
	move.w	#16,BAD_Y(a0)
	rts

lev2
	lea		_map2,a0
	move.l	a0,map_pointer
	lea		_objects,a0
	move.w	#1,OBJ_ON(a0)
	lea		OBJ_SIZE(a0),a0
	move.w	#1,OBJ_ON(a0)
	move.w	#304,OBJ_X(a0)
	move.w	#2,to_collect

	lea		_bad_guys,a0
	move.w	#BAD_STATE_LEFT,BAD_ON(a0)
	move.w	#32,BAD_X(a0)
	move.w	#48,BAD_Y(a0)
	move.w	#BAD_LEFT_START,BAD_FRAME(a0)

	lea		BAD_SIZE(a0),a0
	move.w	#BAD_STATE_RIGHT,BAD_ON(a0)
	move.w	#160,BAD_X(a0)
	move.w	#80,BAD_Y(a0)
	move.w	#BAD_RIGHT_START,BAD_FRAME(a0)
	rts

lev3
	lea		_map3,a0
	move.l	a0,map_pointer
	lea		_objects,a0
	move.w	#1,OBJ_ON(a0)
	lea		OBJ_SIZE(a0),a0
	move.w	#1,OBJ_ON(a0)
	move.w	#304,OBJ_X(a0)
	move.w	#2,to_collect


	lea		_bad_guys,a0
	move.w	#BAD_STATE_LEFT,BAD_ON(a0)
	move.w	#160,BAD_X(a0)
	move.w	#160,BAD_Y(a0)
	move.w	#BAD_LEFT_START,BAD_FRAME(a0)

	lea		BAD_SIZE(a0),a0
	move.w	#BAD_STATE_RIGHT,BAD_ON(a0)
	move.w	#0,BAD_X(a0)
	move.w	#48,BAD_Y(a0)
	move.w	#BAD_RIGHT_START,BAD_FRAME(a0)
	rts

********************************************************************************

_clear_objects
	lea		_objects,a0
	move.w	#MAX_OBJECTS-1,d0
.loop
		move.w	#0,OBJ_ON(a0)
		move.w	#0,OBJ_X(a0)
		move.w	#0,OBJ_Y(a0)
		move.w	#0,OBJ_FRAME(a0)
		lea		OBJ_SIZE(a0),a0
	dbra	d0,.loop
	rts

********************************************************************************

_clear_bad_guys
	lea		_bad_guys,a0
	move.w	#MAX_BADDIES-1,d0
.loop
		move.w	#0,BAD_ON(a0)
		move.w	#0,BAD_X(a0)
		move.w	#0,BAD_Y(a0)
		move.w	#0,BAD_FRAME(a0)
		move.w	#BAD_FRAME_DELAY,BAD_DELAY(a0)
		lea		BAD_SIZE(a0),a0
	dbra	d0,.loop
	rts

********************************************************************************
