   IFND  GRAPHICS_COPPER_I
GRAPHICS_COPPER_I SET   1
COPPER_MOVE equ 0
COPPER_WAIT equ 1
CPRNXTBUF   equ 2
CPR_NT_LOF  equ $8000
CPR_NT_SHT  equ $4000
   STRUCTURE   CopIns,0
      WORD  ci_OpCode
      STRUCT   ci_nxtlist,0
      STRUCT   ci_VWaitPos,0
      STRUCT   ci_DestAddr,2
      STRUCT   ci_HWaitPos,0
      STRUCT   ci_DestData,2
   LABEL ci_SIZEOF
   STRUCTURE   cprlist,0
      APTR  crl_Next
      APTR  crl_start
      WORD  crl_MaxCount
   LABEL crl_SIZEOF
   STRUCTURE   CopList,0
      APTR  cl_Next
      APTR  cl__CopList
      APTR  cl__ViewPort
      APTR  cl_CopIns
      APTR  cl_CopPtr
      APTR  cl_CopLStart
      APTR  cl_CopSStart
      WORD  cl_Count
      WORD  cl_MaxCount
      WORD  cl_DyOffset
   LABEL cl_SIZEOF
   STRUCTURE   UCopList,0
      APTR     ucl_Next
      APTR     ucl_FirstCopList
      APTR     ucl_CopList
   LABEL ucl_SIZEOF
   STRUCTURE   copinit,0
      STRUCT   copinit_diagstrt,8
      STRUCT   copinit_sprstrtup,2*((2*8*2)+2+(2*2)+2)
      STRUCT   copinit_sprstop,4
   LABEL copinit_SIZEOF
   ENDC
