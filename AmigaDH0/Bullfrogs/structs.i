
********************************************************************************
*				   oo					          oo						   *
*				 \(  )/      Bullfrog Demo      \(  )/						   *
*				 ^ ^^ ^ 	   Structures		^ ^^ ^						   *
********************************************************************************

*COLLECTABLE OBJECTS

OBJ_ON			equ	0			;does the object exist
OBJ_STATUS		equ	0			;what state is it in
OBJ_TO_DRAW		equ	2			;Where to get all the x y and frame in one move
OBJ_X			equ	2			;where on the screen is it
OBJ_Y			equ	4			;y version of above
OBJ_FRAME		equ	6			;what is the frame being displayed
OBJ_SIZE		equ	8			;how big is each object.

********************************************************************************

*Bad Guys

BAD_ON			equ	 0			;does the bad guy exist
BAD_STATE		equ	 0			;and if so what type of guy is he
BAD_TO_DRAW		equ	 2			;get x,y and frame is one easy go
BAD_XY			equ	 2			;so we can get x and y together
BAD_X			equ	 2			;bad guys x position
BAD_Y			equ	 4			;bad guys y position
BAD_FRAME		equ	 6			;current animation frame
BAD_DELAY		equ	 8			;delay between changes in animation
BAD_SIZE		equ	10			;how much memory each bad guy takes

********************************************************************************

*Scores

TEXT_SCORE			equ	0
TEXT				equ	2
TEXT_SIZE			equ	16

********************************************************************************
