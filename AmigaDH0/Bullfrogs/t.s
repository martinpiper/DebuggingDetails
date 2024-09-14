	tst.w	0
	bne.s	not_zero
		move.w	#$f00,$dff180
not_zero
	rts
