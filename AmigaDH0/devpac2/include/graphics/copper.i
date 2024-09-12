	IFND	GRAPHICS_COPPER_I
GRAPHICS_COPPER_I	SET	1
COPPER_MOVE	equ	0
COPPER_WAIT	equ	1
CPRNXTBUF	equ	2
CPR_NT_LOF	equ	$8000
CPR_NT_SHT	equ	$4000
	rsreset
CopIns	rs.b	0
ci_OpCode	rs.w	1
ci_nxtlist	rs.b	0
ci_VWaitPos	rs.b	0
ci_DestAddr	rs.b	2
ci_HWaitPos	rs.b	0
ci_DestData	rs.b	2
ci_SIZEOF	rs.w	0
	rsreset
cprlist	rs.b	0
crl_Next	rs.l	1
crl_start	rs.l	1
crl_MaxCount	rs.w	1
crl_SIZEOF	rs.w	0
	rsreset
CopList	rs.b	0
cl_Next	rs.l	1
cl__CopList	rs.l	1
cl__ViewPort	rs.l	1
cl_CopIns	rs.l	1
cl_CopPtr	rs.l	1
cl_CopLStart	rs.l	1
cl_CopSStart	rs.l	1
cl_Count	rs.w	1
cl_MaxCount	rs.w	1
cl_DyOffset	rs.w	1
cl_SIZEOF	rs.w	0
	rsreset
UCopList	rs.b	0
ucl_Next	rs.l	1
ucl_FirstCopList	rs.l	1
ucl_CopList	rs.l	1
ucl_SIZEOF	rs.w	0
	rsreset
copinit	rs.b	0
copinit_diagstrt	rs.b	8
copinit_sprstrtup	rs.b	2*((2*8*2)+2+(2*2)+2)
copinit_sprstop	rs.b	4
copinit_SIZEOF	rs.w	0
	ENDC

