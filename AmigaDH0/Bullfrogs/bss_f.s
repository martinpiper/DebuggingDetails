FUNC_BSS_F	=	1
;	INCLUDE	myheader.i
;	INCLUDE	funcs.f
;	INCLUDE	custom.i

	SECTION	BSS,BSS_C
******************************************************************************
	xdef	_copper_mem1
_copper_mem1				ds.w	300
	xdef	_copper_mem2
_copper_mem2				ds.w	300
	xdef	_screen_mem
_screen_mem					ds.b	SCREEN_WIDTH*SCREEN_HEIGHT*NO_PLANES*2
	xdef	_copper_shift1
	xdef	_copper_shift2
	xdef	_copper_screenptr1
	xdef	_copper_screenptr2
	xdef	_copper_screen1
	xdef	_copper_screen2
_copper_shift1				ds.l	1
_copper_shift2				ds.l	1
_copper_screenptr1			ds.l	1
_copper_screenptr2			ds.l	1
_copper_screen1				ds.l	1
_copper_screen2				ds.l	1
******************************************************************************
	xdef	_seed
_seed                       ds.l	1
******************************************************************************
	xdef	_time
_time					ds.l	1
	xdef	_vbi_done
_vbi_done				ds.w	1
	xdef	_d_screen
_d_screen				ds.l	1
	xdef	_w_screen
_w_screen				ds.l	1
	xdef	_b_screen
_b_screen				ds.l	1
	xdef	_xposition
_xposition				ds.w	1
	xdef	_yposition
_yposition				ds.w	1
	xdef	_old1_int_vec
_old1_int_vec			ds.l	1
	xdef	_old2_int_vec
_old2_int_vec			ds.l	1
	xdef	_da_flag
_da_flag				ds.w	1
	xdef	_iinkey
_iinkey					ds.w	1
	xdef	_key_on
_key_on					ds.b	256
	xdef	_pal
_pal					ds.w	1
	xdef	_vbi_timer
_vbi_timer				ds.w	1
	xdef	_iiinkey
_iiinkey				ds.b	1
	xdef	_joy1
_joy1					ds.b	1
	xdef	_dx_joy
_dx_joy					ds.w	1
	xdef	_dy_joy
_dy_joy					ds.w	1
	xdef	_fire
_fire					ds.w	1
	xdef	_bullet_fire
_bullet_fire			ds.w	1
	xdef	_fire2
_fire2					ds.w	1
	xdef	_mousex
_mousex					ds.w	1
	xdef	_mousey
_mousey					ds.w	1
	xdef	_mmousex
_mmousex				ds.w	1
	xdef	_mmousey
_mmousey				ds.w	1
	xdef	_right_button
_right_button			ds.w	1
	xdef	_left_button
_left_button			ds.w	1
	xdef	_mright_button
_mright_button			ds.w	1
	xdef	_mleft_button
_mleft_button			ds.w	1
	xdef	_tog
_tog					ds.w	1
	xdef	_controler
_controler				ds.l	1
