******************************************************************************
;	include	dos_lib.i
;LIB_OPEN	=	-408
	xdef	_set_up_disc
_set_up_disc
	move.l  4,a6						exec base
	lea	 	DOS_Name,a1	 				library to open
	jsr	 	LIB_OPEN(a6)
	move.l  d0,_mydosbase

	move.l	_mydosbase,a6                 get standard output handle
	jsr		_LVOOutput(a6)
	move.l	d0,_clihandle
	rts
*****************************************************************************
	xdef	_myload_file
_myload_file
	movem.l	d1-d7/a0-a6,-(sp)
	lea     filestuff,a6
	mulu	#12,d0
	adda.w	d0,a6
	move.l	0(a6),d5		read  screenfile
	move.l	4(a6),d6
	move.l	8(a6),d7
	move.l	_mydosbase,a6
	move.l	d5,d1  				  		read map_file
    move.l  #1005,d2        		    mode oldfile
	jsr     _LVOOpen(a6)				open
	move.l	d0,d5						is now the file handle
	beq.s	.fail

    move.l  d5,d1               		handle
    move.l  d6,d2            			buffer
    move.l  d7,d3             			length
    jsr     _LVORead(a6)   		        read the file

	move.l	d5,d1						handle
	jsr		_LVOClose(a6)				close the file
	bra.s	.end
.fail
	move.l	#'FAIL',d0
.end
	movem.l	(sp)+,d1-d7/a0-a6
	rts
*****************************************************************************
	xdef	_mysave_file
_mysave_file
	movem.l	d1-d7/a0-a6,-(sp)
	lea     filestuff,a6
	mulu	#12,d0
	adda.w	d0,a6
	move.l	0(a6),d5		write screenfile
	move.l	4(a6),d6
	move.l	8(a6),d7
	move.l	_mydosbase,a6
	move.l	d5,d1  				  		read map_file
    move.l  #1006,d2        		    mode newfile
	jsr     _LVOOpen(a6)				open
	move.l	d0,d5						is now the file handle
	beq.s	.fail

    move.l  d5,d1               		handle
    move.l  d6,d2            			buffer
    move.l  d7,d3             			length
    jsr     _LVOWrite(a6)  		        read the file

	move.l	d5,d1						handle
	jsr		_LVOClose(a6)				close the file
	bra.s	.end
.fail
	move.l	#'FAIL',d0
.end
	movem.l	(sp)+,d1-d7/a0-a6
	rts
*****************************************************************************
;DOS_Name	dc.b	'dos.library',0
	even
_mydosbase	dc.l	0
_clihandle	dc.l	1
******************************************************************************
filestuff

	dc.l	_backscreen
	dc.l    backscreen
	dc.l	32000
	
_backscreen
	dc.b	"DATA/QAZ.DAT",0
	even
******************************************************************************
*              convert long to alpha Tue Mar 27 10:36:17 1990                *
******************************************************************************
; a0-> destination string d0.l = number to convert, d1.l = no digits
	xdef	_to_alpha
_to_alpha
	move.w	d1,d2
	add.w	d2,d2						;*2
	add.w	d2,d2						;*4
	neg.w	d2
	lea		decsize(pc,d2.w),a1			;a1-> list of neggers
	subq.w	#1,d1						;for dbra
;	move.w	#1,d4
.loop
	move.l	(a1)+,d2					;get negger
	moveq	#'0',d3						;this digit
.iloop
	sub.l	d2,d0
	bmi.s	.digdun
	addq.b	#1,d3						;build digit
    bra.s	.iloop
.digdun
		add.l	d2,d0

	tst.w	d4						;leading spaces. or not
	beq.s	.not_leading
	cmp.b	#'0',d3
	beq.s	.still_leading
		moveq	#0,d4
		bra.s	.not_leading
.still_leading
	moveq	#' ',d3
.not_leading

	move.b	d3,(a0)+
	dbra	d1,.loop
;	clr.b	(a0)
	rts

	dc.l	10000000
	dc.l	 1000000
	dc.l	  100000
	dc.l	   10000
	dc.l		1000
	dc.l		 100
	dc.l		  10
	dc.l		   1
decsize 								;label at end of table
******************************************************************************
