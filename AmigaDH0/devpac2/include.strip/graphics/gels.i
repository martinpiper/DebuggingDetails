    IFND    GRAPHICS_GELS_I
GRAPHICS_GELS_I SET 1
SUSERFLAGS  EQU $00FF
    BITDEF  VS,VSPRITE,0
    BITDEF  VS,SAVEBACK,1
    BITDEF  VS,OVERLAY,2
    BITDEF  VS,MUSTDRAW,3
    BITDEF  VS,BACKSAVED,8
    BITDEF  VS,BOBUPDATE,9
    BITDEF  VS,GELGONE,10
    BITDEF  VS,VSOVERFLOW,11
BUSERFLAGS  EQU $00FF
    BITDEF  B,SAVEBOB,0
    BITDEF  B,BOBISCOMP,1
    BITDEF  B,BWAITING,8
    BITDEF  B,BDRAWN,9
    BITDEF  B,BOBSAWAY,10
    BITDEF  B,BOBNIX,11
    BITDEF  B,SAVEPRESERVE,12
    BITDEF  B,OUTSTEP,13
ANFRACSIZE  EQU 6
ANIMHALF    EQU $0020
RINGTRIGGER EQU $0001
InitAnimate MACRO   *
       CLR.L   \1
       ENDM
RemBob      MACRO   *
       OR.W    #BF_BOBSAWAY,b_BobFlags+\1
       ENDM
 STRUCTURE  VS,0
    APTR    vs_NextVSprite
    APTR    vs_PrevVSprite
    APTR    vs_DrawPath
    APTR    vs_ClearPath
    WORD    vs_Oldy
    WORD    vs_Oldx
    WORD    vs_VSFlags
    WORD    vs_Y
    WORD    vs_X
    WORD    vs_Height
    WORD    vs_Width
    WORD    vs_Depth
    WORD    vs_MeMask
    WORD    vs_HitMask
    APTR    vs_ImageData
    APTR    vs_BorderLine
    APTR    vs_CollMask
    APTR    vs_SprColors
    APTR    vs_VSBob

    BYTE    vs_PlanePick
    BYTE    vs_PlaneOnOff
    LABEL   vs_SUserExt
    LABEL   vs_SIZEOF
 STRUCTURE  BOB,0
    WORD    bob_BobFlags
    APTR    bob_SaveBuffer
    APTR    bob_ImageShadow
    APTR    bob_Before
    APTR    bob_After
    APTR    bob_BobVSprite
    APTR    bob_BobComp
    APTR    bob_DBuffer
    LABEL   bob_BUserExt
    LABEL   bob_SIZEOF
 STRUCTURE  AC,0
    WORD    ac_CompFlags
    WORD    ac_Timer
    WORD    ac_TimeSet
    APTR    ac_NextComp
    APTR    ac_PrevComp
    APTR    ac_NextSeq
    APTR    ac_PrevSeq
    APTR    ac_AnimCRoutine
    WORD    ac_YTrans
    WORD    ac_XTrans
    APTR    ac_HeadOb
    APTR    ac_AnimBob
    LABEL   ac_SIZE
 STRUCTURE  AO,0
    APTR    ao_NextOb
    APTR    ao_PrevOb
    LONG    ao_Clock
    WORD    ao_AnOldY
    WORD    ao_AnOldX
    WORD    ao_AnY
    WORD    ao_AnX
    WORD    ao_YVel
    WORD    ao_XVel
    WORD    ao_XAccel
    WORD    ao_YAccel
    WORD    ao_RingYTrans
    WORD    ao_RingXTrans
    APTR    ao_AnimORoutine
    APTR    ao_HeadComp
    LABEL   ao_AUserExt
    LABEL   ao_SIZEOF
 STRUCTURE  DBP,0
    WORD    dbp_BufY
    WORD    dbp_BufX
    APTR    dbp_BufPath

    APTR    dbp_BufBuffer
    APTR    dbp_BufPlanes
    LABEL   dbp_SIZEOF
    ENDC
