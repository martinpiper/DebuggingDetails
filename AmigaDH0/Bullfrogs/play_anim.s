;	include	nfa.i
*****************************************************************************
_play_anim ; a4-> animation buffer ,a5->loop back point, d0 = 'INIT' to start anim
	cmp.l	#'INIT',d0
	bne.s	.not_init
		move.l	(a4)+,a5        frames, noloop
		bsr.s	_first_frame
		move.l	#'FRM2',d0
		rts
.not_init
	cmp.l	#'FRM2',d0
	bne.s	.not_frame2
		bsr		_d2w
		bsr		_next_frame
		move.l	a5,d0
		tst.w	d0
		beq.s	.loop
.noloop
			sub.l	a5,a5
			clr.w	d0
			swap	d0
			rts
.loop
			move.l	a4,a5       loop back point
			move.l	d0,d1
			swap	d1
			move.w	d1,d0		loop count in d0 twice
			rts
.not_frame2
	cmp.l	#'STOP',d0
	bne.s	.normal_frame
		rts
.normal_frame
	move.l	d0,-(sp)			i have actually got to use the stack!
	bsr     _next_frame
	move.l	(sp)+,d0
	subq.w	#1,d0
	cmp.w	#1,d0
	bne.s	.end
		swap	d0
		tst.w	d0				does it loop?
		bne.s	.isloop
			move.l	#'STOP',d0
;			bsr		_d2w
			rts
.isloop
		move.w	d0,d1
		swap	d0
		move.w	d1,d0
		move.l	a5,a4
.end
	rts
*****************************************************************************
_first_frame
	bsr		_use_anim_pal
	move.l	_w_screen,a0
	moveq	#256-(A_SCREEN_HEIGHT-1),d7
	neg.b	d7
.lineloop
		moveq	#A_PLANES-1,d5
.planeloop
			moveq	#A_SCREEN_WIDTH,d6
.another_groinal_overlay
			moveq	#0,d0
			move.b	(a4)+,d0
			bmi.s	.byte_run
.normal_data
				sub.w	d0,d6				count down
				subq.w	#1,d6
.ndloop
					move.b	(a4)+,(a0)+
					dbra	d0,.ndloop
				tst.w	d6
				beq.s	.plane_done
				bra.s	.another_groinal_overlay
.byte_run
				neg.b	d0
				sub.w	d0,d6
				subq.w	#1,d6
				move.b	(a4)+,d1
.brloop
					move.b	d1,(a0)+
					dbra	d0,.brloop
				tst.w	d6
				bne.s	.another_groinal_overlay
.plane_done
			lea		A_SCREEN_WIDTH*(A_SCREEN_HEIGHT-1)(a0),a0
			dbra	d5,.planeloop
		adda.l	#A_SCREEN_WIDTH-A_PLANES*A_SCREEN_WIDTH*A_SCREEN_HEIGHT,a0
		dbra	d7,.lineloop
	rts
*****************************************************************************
_d2w
	move.w	#A_SCREEN_WIDTH*A_SCREEN_HEIGHT*A_PLANES/4-1,d1
	move.l	_d_screen,a0
	move.l	_w_screen,a1

.cloop
		move.l	(a0)+,(a1)+
		dbra	d1,.cloop
	rts
*****************************************************************************
_use_anim_pal ; a4-> palette
	move.l  _copper_list,a1
	move.l  _copper_list+4,a2
	move.w	#$180,d0
.a1loop
		cmp.w   (a1)+,d0
		bne.s	.a1loop
.a2loop
		cmp.w   (a2)+,d0
		bne.s	.a2loop
	moveq	#1<<A_PLANES-1,d1
.loop
		move.w	(a4)+,d0
    	move.w  d0,(a1)
    	move.w  d0,(a2)
		addq.l	#4,a1
		addq.l	#4,a2
		dbra	d1,.loop
	rts
*****************************************************************************
_next_frame

    move.l	_w_screen,a0
	moveq	#A_SCREEN_WIDTH,d2		for moving down a line
	moveq	#A_PLANES-1,d7
.ploop
		cmpi.b	#-1,(A4)
		bne.s	.this_plane_used
			addq.l	#1,a4
			bra.s	.no_plane
.this_plane_used
		moveq	#A_SCREEN_WIDTH-1,d6
.xloop
			move.l	a0,a3			screen pointer for this column
			moveq	#0,d5
			move.b	(a4)+,d5
			beq.s	.next_column
			subq.w	#1,d5
.yloop
				moveq	#0,d0
				move.b	(a4)+,d0
				bgt.s	.skip_ops
				beq.s	.same_ops
.unique_ops
                andi.w	#%1111111,d0
				subq.w	#1,d0
.unique_loop
					move.b	(a4)+,(a3)
					adda.w	d2,a3
					dbra	d0,.unique_loop
				dbra	d5,.yloop
				bra.s	.next_column
.same_ops
				moveq	#0,d4
				move.b	(a4)+,d4
				subq.w	#1,d4
				move.b	(a4)+,d3
.sameloop
					move.b	d3,(a3)
					adda.w	d2,a3					move down a line
                    dbra	d4,.sameloop
				dbra	d5,.yloop
				bra.s	.next_column
.skip_ops
                add.w	d0,d0						for lookup
				adda.w	.offsets(pc,d0.w),a3        skip
				dbra    d5,.yloop

.next_column
			addq.l	#1,a0
			dbra	d6,.xloop
.next_plane
		lea		A_SCREEN_WIDTH*(A_SCREEN_HEIGHT-1)(a0),a0
		dbra	d7,.ploop
	rts
.no_plane
		lea		A_SCREEN_WIDTH*A_SCREEN_HEIGHT(a0),a0
		dbra	d7,.ploop
	rts
.offsets
dct	set	0
	rept	A_SCREEN_HEIGHT
	dc.w	dct
dct	set		dct+A_SCREEN_WIDTH
	endr
*****************************************************************************
