MUSIC_ON_OR_OFF =	0
FUNC_MAIN		= 	1
TESTING			=	1
USE_JOYSTICK	=	1
USE_MOUSE		=	0

	IFD		USE_MOUSE
MSPRITE_HEIGHT	=	16
	ENDC

;	INCLUDE custom.i
;	INCLUDE myheader.i
;	INCLUDE what_key.s
;	INCLUDE	funcs.f

******************************************************************************
  	xdef	_main
_main
	move.w	INTENAR,old_ena
	move.w	DMACONR,old_dma
	IFND		OS_LEGAL
	move.w	#%0111111111011111,INTENA	; turn off all interuppts
	move.w	#%1100000000101000,INTENA	; sets vert blank
	move.w	#$7fff,INTREQ
	move.l	#$00fc0c8e,100
	move.l	#$00fc0ce2,104
	move.l	#$00fc0d14,108
	move.l	#$00fc0d6c,112
	move.l	#$00fc0dfa,116
	move.l	#$00fc0e40,120
	move.l	#$00fc0e86,124
	ENDC
	movem.l	d0-d7/a0-a6,-(sp)
	jsr		_setup_libs
	jsr		_setup_keyboard
	jsr	 	_setup_vbi
	jsr	 	_setup_screens
	jsr		_swap_screens
	IFD		MUSIC_ON_OR_OFF
	jsr		mt_init
	ENDC
	jsr		_display
	IFD		MUSIC_ON_OR_OFF
	jsr		mt_end
	ENDC
	jsr		_reset_system
	movem.l	(sp)+,d0-d7/a0-a6
	rts

	xdef	_reset_system
_reset_system
	movem.l	d0-d7/a0-a6,-(sp)
	move.w	#$7fff,INTENA				;reset the old interupt values
	move.w	#$7fff,DMACON				;reset dmacon old values
	jsr		_reset_keyboard
	jsr	 	_reset_vbi
	jsr	 	_reset_copper
	move.w	old_ena,d0
	or.w	#$8000,d0
	move.w	d0,INTENA
	move.w	old_dma,d0
	or.w	#$8000,d0
	move.w	d0,DMACON
	movem.l	(sp)+,d0-d7/a0-a6
	rts

******************************************************************************
old_ena	dc.w	0
old_dma	dc.w	0
******************************************************************************
	xdef	_copper_list
_copper_list
	dc.l	_copper_mem1
	dc.l	_copper_mem2
******************************************************************************
	xdef	_reset_copper
_reset_copper
	movem.l a0/d0,-(sp)
	move.l  _GFXBase,a0
	move.l  38(a0),d0
	move.l  d0,COP1LC
	move.w  COPJMP1,d0
	movem.l (sp)+,a0/d0
	rts

*************************************************************

	xdef	_reset_vbi
_reset_vbi
	move.l  20,d0
	move.l  _old2_int_vec,20
	move.l  d0,_old2_int_vec
	move.l  108,d0
	move.l  _old1_int_vec,108
	move.l  d0,_old1_int_vec
	rts

*************************************************************

	xdef	_setup_vbi
_setup_vbi
	move.l  a0,-(sp)
	IFD		OS_LEGAL
	move.w  #%0000000001110000,INTENA
	ENDC
	move.l  108,_old1_int_vec
	lea	 	_vbi_interupt,a0
	move.l  a0,108
	move.l  20,_old2_int_vec
	lea	 	_div_by_zero,a0
	move.l  a0,20
	IFD		OS_LEGAL
	move.w  #%1100000000110000,INTENA
	ELSEIF
	move.w  #%1000000000100000,INTENA
	move.w  #%0000000000100000,INTREQ
	ENDC
	move.l  (sp)+,a0
	rts

	xdef	_do_ints
	IFD		OS_LEGAL
_do_ints	dc.w	1
	ELSEIF
_do_ints	dc.w	0
	ENDC


**************************************************************************
_ijoy1
	dc.w	 0,-1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0,-1,-1
_ijoy2
	dc.w	 0, 1, 1, 1,-1, 0, 0, 0,-1, 0, 0, 0,-1, 0
**************************************************************************
_joy_table1
   dc.w    0
   dc.w    0
   dc.w    1
   dc.w    1
   dc.w    0
   dc.w    0                               ; not used
   dc.w    0                               ; not used
   dc.w    1
   dc.w    -1
   dc.w    0                               ; not used
   dc.w    0                               ; not used
   dc.w    0                               ; not used
   dc.w    -1
   dc.w    -1
**************************************************************************
_joy_table2
   dc.w    0
   dc.w    1
   dc.w    1
   dc.w    0
   dc.w    -1
   dc.w    0                               ; not used
   dc.w    0                               ; not used
   dc.w    -1
   dc.w    -1
   dc.w    0                               ; not used
   dc.w    0                               ; not used
   dc.w    0                               ; not used
   dc.w    0
   dc.w    1
*************************************************************

	xdef	_vbi_interupt
_vbi_interupt
	movem.l  d0-d7/a0-a6,-(sp)
	move.w  INTREQR,d0
	and.w   INTENAR,d0
	and.w   #%0100000000100000,d0
	beq	 	.not_this_time

	IFD		USE_JOYSTICK

    move.l  D0,-(sp)

    move.w  $dff00c,d0
    and.w   #$0303,d0
    bclr    #8,d0
    beq.s   .zero1
        bset    #2,d0
.zero1
    bclr    #9,d0
    beq.s   .zero2
        bset    #3,d0
.zero2
    add.w   d0,d0
    move.w  _joy_table1(PC,d0.w),_dx_joy
    move.w  _joy_table2(PC,d0.w),_dy_joy

.fire_test
    btst.b  #7,$bfe0ff
    bne.s   .no_fire
       add.w    #1,_fire
       bra.s    .fire1_done
.no_fire
    move.w  #0,_fire
.fire1_done
    move.w  #$c000,$dff034                   ; set potgo to correct status
    move.w  $dff016,d0
    btst.l  #14,d0                          ; check the button in potgo_read
    bne.s   .no_fire2
        add.w   #1,_fire2
        bra.s   .fire2_done
.no_fire2
    move.w  #0,_fire2
.fire2_done
    move.w  #$000,$dff034                   ; set potgo to correct status
    cmp.w	#255,_fire
	blt.s	.end
		move.w	#255,_fire
.end
    move.l  (sp)+,D0
	ENDC
	IFD		USE_MOUSE
	jsr	 _vbi_mouse
	ENDC
	IFD		MUSIC_ON_OR_OFF
	jsr		mt_music
	ENDC
;corrupts registers
*******************************
	move.w  #1,_vbi_done
	addq.w  #1,_vbi_timer
*******************************
.not_this_time
	tst.w   _do_ints
	beq.s   .not_dos
		movem.l  (sp)+,d0-d7/a0-a6
		move.l  _old1_int_vec,-(sp)
		rts
.not_dos
	move.w  #%0000000000100000,INTREQ
	movem.l  (sp)+,d0-d7/a0-a6
_div_by_zero
	rte
************************************************************
************************************************************
Copper  	equr	A0
CColour		equr	A1

Custom  	equr	D0
Display 	equr	D1
DWork1  	equr	D2
Sprite		equr	D3
StartCopper	equr	D4

	xdef	_setup_screens
_setup_screens

	movem.l d1/a0/a1/a2,-(sp)
	IFD		USE_MOUSE
	jsr	 	_setup_mouse
	ENDC
	lea	 	_screen_mem,a0
	move.l  a0,Display
	move.l  Display,_d_screen
	lea	 	_copper_mem1,Copper
	lea	 	_pallet,CColour
	lea	 	_copper_list,a2
	jsr	 	_make_copper
	add.l	#4,Copper
	move.l  Copper,(a2)+
	lea	 	_copper_mem2,Copper
	add.l   #SCREEN_WIDTH*SCREEN_HEIGHT*NO_PLANES,Display
	move.l  Display,_w_screen
	jsr	 	_make_copper
	add.l	#4,Copper
	move.l  Copper,(a2)
	movem.l (sp)+,d1/a0/a1/a2
	rts

_pallet
	incbin data/pal.dat
;	dc.w	$000,$111,$222,$333,$444,$555,$666,$777
;	dc.w	$888,$999,$aaa,$bbb,$ccc,$ddd,$eee,$fff
*************************************************************
	xdef	_make_copper
_make_copper

	movem.l Custom-StartCopper/Copper-CColour,-(sp)
* the first 4 bytes of the copper list is used for dummy sprites
	move.l	Copper,StartCopper
	clr.l	(Copper)+

* first set up all the defaults for the screen
	move.l	#$009c0010,(Copper)+	Set the INTREQ to tell me we are at the TVP
	move.l	#$01004200,(Copper)+	BPLCON0
;	move.l	#$01020044,(Copper)+	BPLCON1
	move.l	#$01020000,(Copper)+	BPLCON1
	move.l	#$01040024,(Copper)+	BPLCON2
	tst.w	   _pal
	beq.s	ntsc
	move.l  #$008e3681,(Copper)+	DIWSTRT
	move.l	#$0090fec1,(Copper)+	DIWSTOP
	bra.s	pal_continue
ntsc
	move.l	#$008e2c81,(Copper)+	DIWSTRT
	move.l  #$0090f4c1,(Copper)+	DIWSTOP
pal_continue
	move.l	#$00920038,(Copper)+	DFFSTRT
	move.l	#$009400d0,(Copper)+	DFFSTOP
	move.l  #$01080000,(Copper)+	BPL1MOD
	move.l  #$010a0000,(Copper)+	BPL2MOD

* set up the colour table
	IFD		USE_MOUSE
	move.w	#31,DWork1
	ELSEIF
	move.w	#(1<<NO_PLANES)-1,DWork1
	ENDC
	move.w	#$180,Custom
setup_colour_table
	move.w	Custom,(Copper)+
	move.w	(CColour)+,(Copper)+
	addq.w	#2,Custom
	dbra	DWork1,setup_colour_table

* D0 contions offset for bitplane pointers
	move.w	#$E0,Custom
	move.w	#NO_PLANES-1,DWork1
.make_copper_planes
	move.w	Custom,(Copper)+
	addq.w	#2,Custom
	swap	Display
	move.w	Display,(Copper)+
	move.w	Custom,(Copper)+
	addq.w	#2,Custom
	swap	Display
	move.w	Display,(Copper)+
	add.l	#SCREEN_WIDTH*SCREEN_HEIGHT,Display
	dbra	DWork1,.make_copper_planes

* D1 contains offset for sprite pointers
	move.w	#$120,Custom
	move.w	#7,DWork1
;if s\pinter data is defined then we must set up a sprite for this screen
	IFD		USE_MOUSE
	move.l	#_pointer_data,Sprite				;add sprite 0
	swap	Sprite
	move.w	Custom,(Copper)+
	move.w	Sprite,(Copper)+
	add.w	#2,Custom
	swap	Sprite
	move.w	Custom,(Copper)+
	move.w	Sprite,(Copper)+
	add.w	#2,Custom

	add.l	#18*4,Sprite						;adjust for size of pointer
	swap	Sprite
	move.w	Custom,(Copper)+
	move.w	Sprite,(Copper)+
	add.w	#2,Custom
	swap	Sprite
	move.w	Custom,(Copper)+
	move.w	Sprite,(Copper)+
	add.w	#2,Custom
	sub.w	#2,DWork1
	ENDC
.make_copper_sprites
	move.w	Custom,(Copper)+
	addq.w	#2,Custom
	swap	StartCopper
	move.w	StartCopper,(Copper)+
	move.w	Custom,(Copper)+
	addq.w	#2,Custom
	swap	StartCopper
	move.w	StartCopper,(Copper)+
	dbra	DWork1,.make_copper_sprites
* terminate the copper list
	move.l	#$0901ff00,(Copper)+	WAIT FOR BOTTOM OF DISPLAY
	IFD		OS_LEGAL
	move.l	#$009c8030,(Copper)+	Set the INTREQ to tell me we are at the BVP
	ELSEIF
	move.l	#$009c8030,(Copper)+	Set the INTREQ to tell me we are at the BVP
	ENDC
	move.l	#$fffffffe,(Copper)
	move.w	#$83c0,DMACON
	
	move.l	#0,$dff140				;newbit

	addq.l  #4,StartCopper
	move.l  StartCopper,COP1LC
	move.l	StartCopper,_showing
	movem.l (sp)+,Custom-StartCopper/Copper-CColour
	rts
*************************************************************
   	xdef    _setup_keyboard
_setup_keyboard
    move.w  #%0000000000001000,INTENA
    move.l	$68,old_keyboard_int
    lea		keyboard_interupt,a0
    move.l  a0,$68
    move.w  #%1100000000001000,INTENA
    rts

    xdef    _reset_keyboard
_reset_keyboard
    move.w  #%0000000000001000,INTENA
    move.l  $68,d0
    move.l  old_keyboard_int,$68
    move.l  d0,old_keyboard_int
    move.w  #%1100000000001000,INTENA
    rts

	xdef	keyboard_interupt
keyboard_interupt
    movem.l	d0/a0,-(sp)						;save all registers
	move.b	$bfec01,d0						;load in the keyboard value no matter if we are in the system keyboard or not
	move.b	d0,_iinkey						;store the raw key into iinkey
	move.b	d0,_iiinkey
	tst.w	_da_flag						;are we using the system keyboard ?
;	beq.s	its_not_the_system
	cmp.b	#KF_10,d0
	bne.s	.not_system_escape
		btst	#0,_scr_system
		bne.s	.not_system
		bset	#0,_scr_system
		move.l  _GFXBase,a0
		move.l  38(a0),d0
		move.w	#1,_da_flag
		bra.s	.alter_copper
.not_system
		bclr	#0,_scr_system
		move.l	_showing,d0
		clr.w	_da_flag
.alter_copper
		move.l  d0,COP1LC
		move.b	_iinkey,d0
.not_system_escape
	and.w	#$ff,d0							;now set the keyon value
	lea		_key_on,a0
	btst	#0,d0
	beq.s	.key_up
		add.b	#1,(a0,d0.w)
.key_up
		move.b	#0,1(a0,d0.w)
    movem.l  (sp)+,d0/a0
	move.l  old_keyboard_int,-(sp)			;call system interupt
	rts
its_not_the_system
;	move.b	#%01110111,$bfee01
;	clr.b	_iinkey							;cleak the old keyboard valu
;	move.b	$bfed01,d0						;is this a keyboard interupt
;	and.b	#$8,d0							;is it a keyboard interupt
;	beq.s	.not_keyboard	
;	move.b	$bfec01,d0						;load in the keyboard value
;	move.b	#$0,$bfec01
;	or.b	#$40,$bfee01					;yes so do somthing strange
	cmp.b	#KF_10,d0						;is it an escape
	bne.s	.not_escape
		bset	#0,_scr_system				;yes so switch to system
		move.l  _GFXBase,a0
		move.l  38(a0),d0
		move.w	#1,_da_flag
		move.l  d0,COP1LC
		move.b	_iinkey,d0
.not_escape	
;	move.b	d0,_iinkey						;save iinkey
	lea		_key_on,a0
	and.w	#$ff,d0							;now set the keyon value
	btst	#0,d0
	bne.s	.down
		move.b	d0,(a0,d0.w)
		bra.s	.done
.down
		clr.b	1(a0,d0.w)
.done	
;	move.b	#$ff,$bfec01
;	andi.b	#$bf,$bfee01					;repole the stange one
.not_keyboard
;	move.b	#%10001000,$bfee01
	move.w   #$8,INTREQ
    movem.l  (sp)+,d0/a0					;restore the registers
	rte
	even
old_keyboard_int    dc.l    0


LIB_OPEN	EQU		-408 

	xdef	_setup_libs
_setup_libs	
	movem.l a1/a6/d0,-(sp)
;open the dos base	
	move.l  4,a6				; exec base
	lea	 	DOS_Name,a1	 		; library to open
	jsr	 	LIB_OPEN(a6)
	move.l  d0,_DosBase
;open the gfxbase
	move.l  4,a6				; exec base
	lea	 	GFX_Name,a1	 		; library to open
	jsr	 	LIB_OPEN(a6)
	move.l  d0,_GFXBase
	move.l	d0,a1
	move.w	$ce(a1),d0			;GfxBase->DisplayFlags
	and.w	#4,d0
	move.w	d0,_pal
	IFD	OS_LEGAL
;make sure no requesters come up
	move.l	4,a6				;exec base
	sub.l	a1,a1				;set name to null for out task
	jsr		-294(a6)
	move.l	d0,a1				;task structure	
	move.l	#-1,184(a1)			;set window ptr to -1
	ENDC
	movem.l	(sp)+,a1/a6/d0
	rts

	xdef	_DosBase,_GFXBase
_DosBase	dc.l	0
_GFXBase	dc.l	0
GFX_Name	dc.b	"graphics.library",0
	EVEN
DOS_Name	dc.b	"dos.library",0
	EVEN

**************************************************************

	xdef	_swap_screens
_swap_screens
	movem.l d0/a0,-(sp)
	move.l  _d_screen,a0
	move.l  _w_screen,_d_screen
	move.l  a0,_w_screen
	eor.l   #4,_toggle
	lea	 	_copper_list,a0
	add.l   _toggle,a0
	move.l	(a0),_showing
	move.l  (a0),COP1LC
	clr.w	_vbi_done
	add.l	#1,_time
	movem.l (sp)+,d0/a0
	rts


	xdef	_showing
	xdef	_scr_system
	xdef	_toggle
_toggle 	dc.l	0
_showing	dc.l	0
_scr_system	dc.l	0
**************************************************************

	xdef	_wait_vbi
_wait_vbi
	
.loop
	tst.w   _vbi_done
	beq.s   .loop
	
	rts
**************************************************************
	IFD	USE_MOUSE
MSprite	equr    A0

Scratch equr    D0
VStart  equr    D1
HStart  equr    D2
VStop   equr    D3

  xdef  _vbi_mouse
_vbi_mouse:
    move.w	JOY0DAT,D0
    and.w	#$00ff,D0
    move.w	_old_mousex,D1
    move.w	D0,_old_mousex
    sub.w	D1,D0
    cmp.w	#127,D0
    ble.s	.NO_X_SUB
        sub.w	#256,D0
.NO_X_SUB
    cmp.w	#-127,D0
    bge.s	.NO_X_ADD
        add.w	#256,D0
.NO_X_ADD    
    add.w	_big_mousex,D0
    bpl.s	.X_IS_PLUS
        move.w      #0,D0
.X_IS_PLUS    
    cmp.w	#639,D0
    ble.s	.X_IN_BOUNDS
    	move.w	#639,D0
.X_IN_BOUNDS    
    move.w	D0,_big_mousex
    lsr.w	#1,D0
* push the mouse x on to the stack for the sprite interupt    
    move.w	D0,_mmousex         removed for now
    add.w	#64,D0
    move.w	D0,-(sp)
    move.w	JOY0DAT,D0
    move.w	#8,D1
    lsr.w	D1,D0
    move.w	_old_mousey,D1
    move.w	D0,_old_mousey
    sub.w	D1,D0
    cmp.w	#127,D0
    ble.s	.NO_Y_SUB
        sub.w	#256,D0
.NO_Y_SUB
    cmp.w	#-127,D0
    bge.s	.NO_Y_ADD
        add.w	#256,D0
.NO_Y_ADD
    add.w	_big_mousey,D0
    bpl.s	.Y_IS_PLUS
		move.w	#0,D0
.Y_IS_PLUS    
    cmp.w	_mouse_limit,D0
    ble		.Y_IN_BOUNDS
    	move.w	_mouse_limit,D0
.Y_IN_BOUNDS
    move.w	D0,_big_mousey
    lsr.w	#1,D0
* push the mousey on to the stack for the sprite    
    move.w	D0,_mmousey    
    move.w	D0,-(sp) 
;do the left and right buttons   
    move.b	$bfe0ff,d0
    and.w	#$40,D0
	bne.s	.left_is_up
		move.w	#1,d0
		tst.w	_mleft_button
		bne.s	.left_done
		tst.w	_left_button
		bne.s	.left_done
			move.w	d0,_left_button				;set right button to 1 (on)
			move.l	_mmousex,_mousex
			bra.s	.left_done
.left_is_up
		move.w	#0,d0
.left_done
	move.w	d0,_mleft_button					;reftect actual state

    move.w	#$0c00,$dff034
    move.w	$dff016,D0
    and.w	#$0400,D0
	bne.s	.right_is_up
		move.w	#1,d0
		tst.w	_mright_button
		bne.s	.right_done
		tst.w	_right_button
		bne.s	.right_done
	        move.w	d0,_right_button			;set right button to 1 (on)
    	    move.l	_mmousex,_mousex
			bra.s	.right_done
.right_is_up
		move.w	#0,d0
.right_done
	move.w	d0,_mright_button					;reftect actual state
    clr.w	-(sp)								;move the pointer
    bsr.s	_move_pointer
    add.l	#6,sp
	rts    
    
    xdef        _setup_mouse
_setup_mouse:
    movem.l d0-d1,-(sp)
    
    move.w  JOY0DAT,D0
    and.w   #$00ff,D0
    move.w  D0,_old_mousex
    move.w  JOY0DAT,D0
    move.w  #8,D1
    lsr.w   D1,D0
    move.w  D0,_old_mousey
    movem.l (sp)+,d0-d1
    rts
   
    xdef    _move_pointer
_move_pointer:
	movem.l	Scratch-VStop/MSprite,-(sp)
	move.w	4+4*5(sp),Scratch
	move.w	6+4*5(sp),VStart
	move.w	8+4*5(sp),HStart
; get the address of the sprite
	lea		_pointer_data,MSprite        
	move.b	3+18*4(MSprite),VStop
	and.b	#$80,VStop
; calculate HSTART must add on the left of the screen
	add.w	#64,HStart
;	add.w	#64+8,HStart
	lsr.w	#1,HStart
	bcc.s	.hstart_bit_is_0
		bset	#0,VStop
.hstart_bit_is_0
	move.b	HStart,1(MSprite)
	move.b	HStart,1+18*4(MSprite)
; must add on the top of screen border
;	add.w	#44,VStart
;	add.w	#46,VStart
	add.w	#54,VStart
	tst.w	_pal
	bne.s	.ntsc
		sub.w	#10,VStart
.ntsc
	btst	#8,VStart
	beq.s	.vstart_bit_is_0
		bset	#2,VStop
.vstart_bit_is_0
	move.b	VStart,0(MSprite)
	move.b	VStart,18*4(MSprite)
* calculate VSTOP by addin in the height and subtracting 1
	add.w	#MSPRITE_HEIGHT,VStart
	btst	#8,VStart
	beq.s	.vstop_bit_is_0
	bset	#1,VStop
.vstop_bit_is_0        
	move.b	VStart,2(MSprite)
	move.b	VStart,2+18*4(MSprite)
* move the stop bit in sprite word
	move.b	VStop,3(MSprite)
	move.b	VStop,3+18*4(MSprite)    
	movem.l	(sp)+,Scratch-VStop/MSprite
	rts
	
_old_mousex     dc.w    0
_old_mousey     dc.w    0
_big_mousex     dc.w    0
_big_mousey     dc.w    0
_mouse_limit    dc.w    399 
	ENDC

	IFD		USE_SERIAL
************************ EQUATES ********************************
*
*
************************ REGISTER EQUATES ************************
*							A0	A1	A2	A3	A4	A5	A6	A7
Address			equr	a0
Serial			equr	a1
*							D0	D1	D2	D3	D4	D5	D6	D7
Math			equr	d1		!
Length			equr	d1		!
Mode			equr	d2 
************************** setserial ****************************
* set baud_rate of serial port
*
*
*****************************************************************
	xdef	_setup_serial
_setup_serial
	move.w	#$0801,INTENA
	move.l	$64,old_level_1
	move.l	$74,old_level_5
	jsr		_set_serial
	move.l	#_w_ser_buff,$64
	move.l	#_r_ser_buff,$74
	move.w	#$8801,INTENA
	rts
_reset_serial
	move.w	#$0801,INTENA
	move.l	old_level_1,d0
	move.l	$64,old_level_1
	move.l	d0,$64
	move.l	old_level_5,d0
	move.l	$74,old_level_5
	move.l	d0,$74
	move.w	#$8801,INTENA
	rts

	xdef	_set_serial
_set_serial
	movem.l	Serial/Math,-(sp)
	lea		_serial,Serial
	clr.l	Scratch
	move.w	SE_BAUD_RATE(Serial),Scratch
	lsl.w	#3,Scratch
	sub.w	SE_BAUD_RATE(Serial),Scratch
	move.l	#3579098,Math
	divu	SE_BAUD_RATE(Serial),Math
	sub.w	#1,Math
	move.w	Math,SERPER
	move.w	#$8801,INTENA
	move.w	#$0801,INTREQ
	move.b	$bfd000,Math
	and.b	#%00111111,Math
	move.b	Math,$bfd000
	movem.l	(a7)+,Serial/Math
	rts

	xdef	_clear_serial
_clear_serial
	movem.l	a0,-(sp)
	lea		_serial,a0
	clr.w	SE_READ_POS(a0)
	clr.w	SE_WRITE_POS(a0)
	movem.l	(sp)+,a0
	rts
	
	xdef	_r_ser_buff
_r_ser_buff
	movem.l	d0/a0,-(sp)
	move.w	$dff01c,d0
	and.w	$dff01e,d0
	btst	#11,d0
	beq.s	.not_mine
	lea		_serial,a0
	move.w	SE_WRITE_POS(a0),d0
	move.b	SERDATR+1,SE_BUFFER(a0,d0.w)
	add.w	#1,d0
	cmp.w	#SE_BUFFER_LEN,d0
	bne.s	.buffer_not_full
		move.w	#0,d0
.buffer_not_full
	move.w	d0,SE_WRITE_POS(a0)
	move.w	#$0800,INTREQ
	movem.l	(sp)+,d0/a0
	rte
.not_mine
	IFD	OS_LEGAL
		movem.l  (sp)+,d0/a0
		move.l  old_level_5,-(sp)
		rts
	ELSEIF
	and.w	#$18,d0
	move.w	d0,INTREQ
	movem.l	(sp)+,d0/a0
	ENDC
	rte
	xdef	_w_ser_buff
_w_ser_buff
	movem.l	d0/a0,-(sp)
	move.w	INTREQR,d0
	and.w	INTENAR,d0
	beq.s	.no_call
	or.b	d0,_hello
	btst	#0,d0
	beq.s	.not_mine
	move.w	#$0001,INTENA
	lea		_serial,a0
	move.w	#0,SE_WRITE_READY(a0)
	move.w	#$0001,INTREQ
	move.w	#$8001,INTENA
	and.w	#%110,d0
	bne.s	.not_mine
	movem.l	(sp)+,d0/a0
	rte
.not_mine
	IFD	OS_LEGAL
		movem.l  (sp)+,d0/a0
		move.l  old_level_1,-(sp)
		rts
	ELSEIF
	and.w	#$7,d0
	move.w	d0,INTREQ
	movem.l	(sp)+,d0/a0
	ENDC
.no_call
	rte
	
	xdef	_ww_ser_buff
_ww_ser_buff
	movem.l	d0/a0,-(sp)
	move.w	$dff01c,d0
	and.w	$dff01e,d0
	add.w	#1,_hello
	btst	#0,d0
	beq.s	.not_mine
	lea		_serial,a0
	move.w	#0,SE_WRITE_READY(a0)
	move.w	#$1,INTREQ
	movem.l	(sp)+,d0/a0
	rte
.not_mine
	IFD	OS_LEGAL
		movem.l  (sp)+,d0/a0
		move.l  old_level_1,-(sp)
		rts
	ELSEIF
	and.w	#$7,d0
	move.w	d0,INTREQ
	movem.l	(sp)+,d0/a0
	ENDC
	rte
************************** read_serial **************************
* read serial port
*
*	buffer					a0	(long)
*	Length					d0	(word)
*	Mode					d1	(word)
*
*****************************************************************
	xdef	_read_serial
_read_serial
	movem.l	a0/a1/d1/d2,-(sp)
	move.w	d0,Length					
	move.w	d1,Mode
	lea		_serial,Serial
read_next_char
	tst.w	Mode
	bra		dont_break_read
	beq		dont_break_read
		tst.w	_shift
		beq		dont_break_read
			cmp.w	_iinkey,Scratch
			bne		dont_break_read
			bra		abort_read
dont_break_read
	move.w	SE_READ_POS(Serial),Scratch
	cmp.w	SE_WRITE_POS(Serial),Scratch
	beq.s	read_next_char
	move.b	SE_BUFFER(Serial,Scratch.w),(Address)
	add.w	#1,Scratch
	cmp.w	#SE_BUFFER_LEN,Scratch
	bne.s	buffer_not_at_end
		move.w	#0,Scratch
buffer_not_at_end
	move.w	Scratch,SE_READ_POS(Serial)
	tst.w	Length
	bne.s	read_till_length
		tst.b	(Address)+
		bne		read_next_char
			move.b	#0,(Address)
			bra.s	end_of_read
read_till_length
	add.l	#1,Address
	sub.w	#1,Length
	bne		read_next_char
end_of_read
	move.l	#0,Scratch
abort_read
	tst.w	Scratch
	movem.l	(sp)+,a0/a1/d1/d2
	rts

************************** write_serial **************************
* write to serial port
*
*	buffer					a0	(long)	Address
*	Length					d0	(word)	Length
*	Mode					d1	(word)	Mode
*
*****************************************************************
	xdef	_write_serial
_write_serial
	movem.l	a0/a1/d1/d2,-(sp)
	move.w	d0,Length
	move.w	d1,Mode
	sub.w	#1,Length
	lea		_serial,Serial
write_buffer_not_empty
	tst.w	Mode
	bra		dont_break_write
	beq			dont_break_write
		tst.w	_shift
		beq		dont_break_write
		jsr		_keyboard
		cmp.w	Mode,Scratch
		bne		dont_break_write
		bra		abort_write
dont_break_write
	tst.w	SE_WRITE_READY(Serial)
	bne.s	write_buffer_not_empty
	moveq	#0,Scratch
	move.b	(Address)+,Scratch
	or.w	#$0100,Scratch
	move.w	#1,SE_WRITE_READY(Serial)
	move.w	Scratch,SERDAT
	dbra	Length,write_buffer_not_empty
	move.l	#0,Scratch
abort_write
	movem.l	(sp)+,a0/a1/d1/d2
	rts
	ENDC
	
	IFD	OS_LEGAL
**************************************************************************
*             all oslegal dos stuff Sun Apr  1 11:42:37 1990
**************************************************************************

	xdef	_Open
_Open
	movem.l	a0/d1-d2,-(sp)
	moveq	#0,d0
	move.l	3*4+4(sp),d1
	move.l	3*4+8(sp),d2
	move.l	_DosBase,a0
	jsr		-30(a0)
	movem.l	(sp)+,a0/d1-d2
	rts

	xdef	_Close	
_Close
	movem.l	a0/d1,-(sp)
	move.l	2*4+4(sp),d1
	move.l	_DosBase,a0
	jsr		-36(a0)	
	movem.l	(sp)+,a0/d1
	rts

	xdef	_Read
_Read
	movem.l	a0/d1-d3,-(sp)
	moveq	#0,d0
	move.l	4*4+4(sp),d1
	beq.s	.the_end
	move.l	4*4+8(sp),d2
	beq.s	.the_end
	move.l	4*4+12(sp),d3
	beq.s	.the_end
	move.l	_DosBase,a0
	jsr		-42(a0)
.the_end
	movem.l	(sp)+,a0/d1-d3
	rts

	xdef	_Write
_Write
	movem.l	a0/d1-d3,-(sp)
	moveq	#0,d0
	move.l	4*4+4(sp),d1
	beq.s	.the_end
	move.l	4*4+8(sp),d2
	beq.s	.the_end
	move.l	4*4+12(sp),d3
	beq.s	.the_end
	move.l	_DosBase,a0
	jsr		-48(a0)	
.the_end
	movem.l	(sp)+,a0/d1-d3
	rts
	
	xdef	_Seek
_Seek
	movem.l	a0/d1-d3,-(sp)
	moveq	#0,d0
	move.l	4*4+4(sp),d1
	beq.s	.the_end
	move.l	4*4+8(sp),d2
	move.l	4*4+12(sp),d3
	move.l	_DosBase,a0
	jsr		-66(a0)	
.the_end
	movem.l	(sp)+,a0/d1-d3
	rts
	ENDC
***********************************************************
_pointer_data
	incbin	data/pointer.dat
	dc.l	0
;;;;;