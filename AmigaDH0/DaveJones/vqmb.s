	OPT	D+	* ,e+

****************************************
**                                    **
** Optimised (read: Very Fast)        **
**                                    **
** PJ's Mandelbrot set generator      **
**                                    **
**     St. Albans, England.           **
**                                    **
** Public Domain provided my credits  **
** are left intact.                   **
**                                    **
****************************************

	incdir	include:
	include	exec/funcdef.i
	INCLUDE	exec/exec_lib.i
	INCLUDE	:include/intuition/intuition_lib.i
	INCLUDE	:include/graphics/graphics_lib.i

	output	v

mlp	MACRO
	MOVE.W	D5,D1
	MOVE.W	D4,D0
	MOVEQ	#32,D7
mlp\1	MOVE.W	D0,D2
	MOVE.W	D1,D3
	MULS	D2,D2
	MULS	D3,D3
	MOVE.L	A4,D6
	ADD.L	D2,D6
	ADD.L	D3,D6
	BGE	emlp\1
	LSL.L	#4,D2
	LSL.L	#4,D3
	SWAP	D2
	SWAP	D3
	MOVE.W	D4,D6
	ADD.W	D2,D6
	SUB.W	D3,D6
	MULS	D0,D1
	LSL.L	#4,D1
	SWAP	D1
	ADD.W	D1,D1
	ADD.W	D5,D1
	MOVE.W	D6,D0
	DBRA	D7,mlp\1

	ADDQ.W	#1,D7
emlp\1	AND.W	#$F,D7
	BEQ	nntp\1
	BTST	#0,D7
	BEQ	pp1\1
	BSET	#(8-\1),(A0)
pp1\1	BTST	#1,D7
	BEQ	pp2\1
	BSET	#(8-\1),(A1)
pp2\1	BTST	#2,D7
	BEQ	pp3\1
	BSET	#(8-\1),(A2)
pp3\1	BTST	#3,D7
	BEQ	nntp\1
	BSET	#(8-\1),(A5)

nntp\1	ADD.W	A6,D4


	ENDM

	LEA	intname,A1		Open intuition library
	MOVEQ	#0,D0
	CALLEXEC	OpenLibrary
	MOVE.L	D0,_IntuitionBase

	LEA	grfname,A1		Open graphics library
	MOVEQ	#0,D0
	CALLEXEC	OpenLibrary
	MOVE.L	D0,_GfxBase

	LEA	nscreen,A0		Open new screen
	CALLINT	OpenScreen
	MOVE.L	D0,screen

	MOVEA.L	screen,A0
	MOVEQ	#0,D0
	CALLINT	ShowTitle
  
	MOVEA.L	screen,A0
	CALLINT	ScreenToBack

	LEA	screen,A0		Choose some nice colours
	MOVEA.L	(A0),A0
	LEA	44(A0),A0
	LEA	cmap,A1
	MOVEQ	#16,D0
	CALLGRAF	LoadRGB4

	LEA	screen,A0		Find out where the bitplanes are
	MOVEA.L	00(A0),A0
	LEA	84(A0),A0
	MOVEA.L	04(A0),A0
	MOVEA.L	12(A0),A1
	MOVEA.L	16(A0),A2
	MOVEA.L	20(A0),A5
	MOVEA.L	08(A0),A0

cls	MOVE.W	#20476,D0		Clear bitplanes
cls2	CLR.L	(A0,D0.W)
	CLR.L	(A1,D0.W)
	CLR.L	(A2,D0.W)
	CLR.L	(A5,D0.W)
	SUBQ.W	#4,D0
	BPL	cls2

	MOVE.W	size,D0			Setup registers
	MOVE.W	D0,D5
	ASR.W	#8,D0
	MOVE.W	D0,dy
	ASR.W	D0
	MOVE.W	D0,dx
	MOVE.L	A6,tempA6
	MOVEA.W	D0,A6
	MOVE.W	xpos,A3
	ADD.W	ypos,D5
	MOVE.L	#$FC000000,A4	

yloop	MOVE.W	A3,D4
	MOVE.W	#79,sx

xloop	mlp	1
	mlp	2
	mlp	3
	mlp	4
	mlp	5
	mlp	6
	mlp	7
	mlp	8

	LEA	1(A0),A0
	LEA	1(A1),A1
	LEA	1(A2),A2
	LEA	1(A5),A5
	
	SUB.W	#1,sx
	BPL	xloop

	SUB.W	dy,D5
	SUB.W	#1,sy
	BPL	yloop

end	MOVEA.L	tempA6,A6
	MOVEA.L	screen,A0
	CALLINT	ScreenToFront
	
	RTS

screen	DC.L	0

nscreen	DC.W	0,0
	DC.W	640,256
	DC.W	4
	DC.B	0,1
	DC.W	$8000
	DC.W	15
	DC.L	font
	DC.L	title
	DC.L	0
	DC.L	0

font	DC.L	fname
	DC.W	8
	DC.B	0,0

fname	DC.B	'topaz.font',0

title	DC.B	'Mandelbrot set generator',0

_IntuitionBase	DC.L	0
_GfxBase	DC.L	0

intname	INTNAME
grfname	GRAFNAME

cmap	DC.W	$000,$0F0,$0FC,$0BF
	DC.W	$08F,$00F,$70F,$A0F
	DC.W	$E0F,$F08,$F00,$F33
	DC.W	$F66,$F99,$FCC,$FFF

sx	DC.W	0
sy	DC.W	255
xpos	DC.W	$E000
ypos	DC.W	$EC00
size	DC.W	$2800
dx	DC.W	$0014
dy	DC.W	$0028
tempA6	DC.L	0


