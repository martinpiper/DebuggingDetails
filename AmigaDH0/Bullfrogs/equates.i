********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 		Equates 	    ^ ^^ ^						   *
********************************************************************************

DELAY				equ	10		;Delay between changing levels
SCORE				equ	50		;How much the score goes up when something collected
MAX_LEVELS			equ	4		;Number of levels in game.
GRAVITY				equ	2		;Speed at which gravity affects man
MAX_SPEED			equ	16		;maximum speed of man
JUMP				equ	20		;how high can you jump. Can you fly bobby?
ACEL				equ	3		;speed of accleration for man
NO_LIVES			equ	3		;number of lives.
SLOW_DOWN			equ	2		;Speed of decrease
MAX_FALL			equ	16		;how long can you fall before you die

MAN_LEFT_START		equ	4*4		;start frame number for man running left
MAN_LEFT_FINISH		equ	1*4		;end frame number for man running left
MAN_STATIONARY		equ	5*4		;frame for man standing still
MAN_RIGHT_START		equ	6*4		;start frame number for man running right
MAN_RIGHT_FINISH	equ	9*4		;end frame number for man running right
MAN_BOUNCE			equ	10*4	;high jump
MAN_CRUMBLE_START	equ	11*4	;man has fallen to far
MAN_CRUMBLE_FINISH	equ	19*4	;has has to die.

LEFT_FOOT			equ	3		;mans left foot
RIGHT_FOOT			equ	10		;mans right foot
MAN_WIDTH			equ	16		;mans width for collision
MAN_HEIGHT			equ	24		;mans hight for collision

MAX_OBJECTS			equ	16		;maximum no of objects on screen 
ANKH_HEIGHT			equ	16		;height of Ankhs
ANKH_WIDTH			equ	8		;width of Ankhs

MAX_BADDIES			equ	8		;maximum number of bad guys on screen
BAD_FRAME_DELAY		equ	4		;delay between change of frames
BAD_LEFT_START		equ	0		;start of animation going left
BAD_LEFT_END		equ	5		;end of animation going left
BAD_MIDDLE			equ	6		;bad guy faces the screen
BAD_RIGHT_START		equ	7		;start of animation for right movement
BAD_RIGHT_END		equ	12		;end of animation for going right
BAD_STATE_LEFT		equ	1		;state going left
BAD_STATE_FROM_LEFT	equ	2		;state man not moving came from left
BAD_STATE_FROM_RIGH equ	3		;man not moving came from right
BAD_STATE_RIGHT		equ	4		;state going right

BAD_LEFT_WIDTH		equ	2		;width of bad guy
BAD_RIGHT_WIDTH		equ	14		;width of bad guy
BAD_TOP_HEIGHT		equ	2		;height of bad guy
BAD_BOTTOM_HEIGHT	equ	14		;height of bad guy
MAX_SCORES			equ	5
