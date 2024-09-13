******************************************************************************
BLIT_WIDTH  	= 	2
BLIT_HEIGHT 	= 	8
BLOCKS_HIGH		= 	25
LINES_HIGH		= 	BLOCKS_HIGH*8
BLOCKS_WIDE		=   21
******************************************************************************
NO_ROOMS        =	100
******************************************************************************
TWO				=	1
FOUR			=	2
EIGHT			=	3
SIXTEEN			=	4
THIRTYTWO		=	5
SIXTYFOUR		=	6
ONETWOEIGHT		=	7
TWOFIVESIX		=	8
******************************************************************************
*****************************************************************************
*	qmove				move a constant into a reg the quickest way (probbly)
*	qmove.w	123,d0		note: if word or byte, will still use moveq!!! if it can
qmove	macro
		ifge	\1
			ifle	\1-127
				moveq	#\1,\2
            	mexit
			endc
			ifle	\1-255
				moveq	#256-\1,\2
				neg.b	\2
				mexit
			endc
				move.\0	#\1,\2
				mexit
        elseif
            move.\0	#\1,\2
		endc
		endm
*****************************************************************************
BLIT_NASTY	macro
		    	move.w	#$8400,DMACON				blitter nasty on
			endm
*****************************************************************************
BLIT_NICE	macro
				move.w	#$0400,DMACON				blitter nasty off
			endm
*****************************************************************************
draw_block_line	macro
	move.w	(a1)+,(a4)						;plane 0
	move.w	(a1)+,PLANESIZE*1(a0)			;plane 1
	move.w	(a1)+,PLANESIZE*2(a0)			;plane 2
	move.w	(a1)+,PLANESIZE*3(a0)			;plane 3
	lea		SCREEN_WIDTH(a0),a0				;move to next line of screen
	endm
**********************************************************************
MAPWIDTH	=	8
MAPHEIGHT	=	8
**********************************************************************
NO_STARS	=	32
**********************************************************************
