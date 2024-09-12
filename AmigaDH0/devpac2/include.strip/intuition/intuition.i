 IFND    INTUITION_INTUITION_I
INTUITION_INTUITION_I   SET     1
 IFND EXEC_TYPES_I
 INCLUDE "exec/types.i"
 ENDC
 IFND    GRAPHICS_GFX_I
 include 'graphics/gfx.i'
 ENDC
 IFND    GRAPHICS_CLIP_I
 include 'graphics/clip.i'
 ENDC
 IFND    GRAPHICS_VIEW_I
 include 'graphics/view.i'
 ENDC
 IFND    GRAPHICS_RASTPORT_I
 include 'graphics/rastport.i'
 ENDC
 IFND    GRAPHICS_LAYERS_I
 include 'graphics/layers.i'
 ENDC
 IFND    GRAPHICS_TEXT_I
 include 'graphics/text.i'
 ENDC
 IFND EXEC_PORTS_I
 include 'exec/ports.i'
 ENDC
 IFND    DEVICES_TIMER_I
 include 'devices/timer.i'
 ENDC
 IFND    DEVICES_INPUTEVENT_I
 include 'devices/inputevent.i'
 ENDC
 STRUCTURE Menu,0
    APTR  mu_NextMenu
    WORD mu_LeftEdge
    WORD mu_TopEdge
    WORD mu_Width
    WORD mu_Height
    WORD mu_Flags
    APTR mu_MenuName
    APTR  mu_FirstItem
    WORD mu_JazzX
    WORD mu_JazzY
    WORD mu_BeatX
    WORD mu_BeatY
    LABEL mu_SIZEOF
MENUENABLED EQU $0001
MIDRAWN EQU $0100
 STRUCTURE MenuItem,0
    APTR mi_NextItem
    WORD mi_LeftEdge
    WORD mi_TopEdge
    WORD mi_Width
    WORD mi_Height
    WORD mi_Flags
    LONG mi_MutualExclude
    APTR mi_ItemFill
    APTR mi_SelectFill
    BYTE mi_Command
    BYTE mi_KludgeFill00
    APTR mi_SubItem
    WORD mi_NextSelect
    LABEL  mi_SIZEOF
CHECKIT         EQU $0001
ITEMTEXT        EQU $0002
COMMSEQ         EQU $0004
MENUTOGGLE      EQU $0008
ITEMENABLED     EQU $0010
HIGHFLAGS       EQU $00C0
HIGHIMAGE       EQU $0000
HIGHCOMP        EQU $0040
HIGHBOX         EQU $0080
HIGHNONE        EQU $00C0
CHECKED         EQU $0100
ISDRAWN         EQU $1000
HIGHITEM        EQU $2000
MENUTOGGLED     EQU $4000
 STRUCTURE Requester,0
    APTR  rq_OlderRequest
    WORD rq_LeftEdge
    WORD rq_TopEdge
    WORD rq_Width
    WORD rq_Height
    WORD rq_RelLeft
    WORD rq_RelTop
    APTR  rq_ReqGadget
    APTR  rq_ReqBorder
    APTR  rq_ReqText
    WORD  rq_Flags
    UBYTE rq_BackFill
    BYTE rq_KludgeFill00
    APTR rq_ReqLayer
    STRUCT rq_ReqPad1,32
    APTR  rq_ImageBMap
    APTR  rq_RWindow
    STRUCT rq_ReqPad2,36
    LABEL rq_SIZEOF
POINTREL        EQU $0001
PREDRAWN        EQU $0002
NOISYREQ        EQU $0004
REQOFFWINDOW    EQU $1000
REQACTIVE       EQU $2000
SYSREQUEST      EQU $4000
DEFERREFRESH    EQU $8000
 STRUCTURE Gadget,0
    APTR gg_NextGadget
    WORD gg_LeftEdge
    WORD gg_TopEdge
    WORD gg_Width
    WORD gg_Height
    WORD gg_Flags
    WORD gg_Activation
    WORD gg_GadgetType
    APTR gg_GadgetRender
    APTR gg_SelectRender
    APTR gg_GadgetText
    LONG gg_MutualExclude
    APTR gg_SpecialInfo
    WORD gg_GadgetID
    APTR  gg_UserData
    LABEL gg_SIZEOF
GADGHIGHBITS    EQU $0003
GADGHCOMP       EQU $0000
GADGHBOX        EQU $0001
GADGHIMAGE      EQU $0002
GADGHNONE       EQU $0003
GADGIMAGE       EQU $0004
GRELBOTTOM      EQU $0008
GRELRIGHT       EQU $0010
GRELWIDTH       EQU $0020
GRELHEIGHT      EQU $0040
SELECTED        EQU $0080
GADGDISABLED    EQU $0100
RELVERIFY       EQU $0001
GADGIMMEDIATE   EQU $0002
ENDGADGET       EQU $0004
FOLLOWMOUSE     EQU $0008
RIGHTBORDER     EQU $0010
LEFTBORDER      EQU $0020
TOPBORDER       EQU $0040
BOTTOMBORDER    EQU $0080
TOGGLESELECT    EQU $0100
STRINGCENTER    EQU $0200
STRINGRIGHT     EQU $0400
LONGINT         EQU $0800
ALTKEYMAP       EQU $1000
BOOLEXTEND      EQU $2000
GADGETTYPE      EQU $FC00
SYSGADGET       EQU $8000
SCRGADGET       EQU $4000
GZZGADGET       EQU $2000
REQGADGET       EQU $1000
SIZING          EQU $0010
WDRAGGING       EQU $0020
SDRAGGING       EQU $0030
WUPFRONT        EQU $0040
SUPFRONT        EQU $0050
WDOWNBACK       EQU $0060
SDOWNBACK       EQU $0070
CLOSE           EQU $0080
BOOLGADGET      EQU $0001
GADGET0002      EQU $0002
PROPGADGET      EQU $0003
STRGADGET       EQU $0004
 STRUCTURE BoolInfo,0
    WORD    bi_Flags
    APTR    bi_Mask
    LONG    bi_Reserved
    LABEL   bi_SIZEOF
BOOLMASK        EQU     $0001
 STRUCTURE PropInfo,0
    WORD pi_Flags
    WORD pi_HorizPot
    WORD pi_VertPot
    WORD pi_HorizBody
    WORD pi_VertBody
    WORD pi_CWidth
    WORD pi_CHeight
    WORD pi_HPotRes
    WORD pi_VPotRes
    WORD pi_LeftBorder
    WORD pi_TopBorder
    LABEL  pi_SIZEOF
AUTOKNOB        EQU $0001
FREEHORIZ       EQU $0002
FREEVERT        EQU $0004
PROPBORDERLESS  EQU $0008
KNOBHIT         EQU $0100
KNOBHMIN        EQU 6
KNOBVMIN        EQU 4
MAXBODY         EQU $FFFF
MAXPOT          EQU $FFFF
 STRUCTURE StringInfo,0
    APTR  si_Buffer
    APTR  si_UndoBuffer
    WORD si_BufferPos
    WORD si_MaxChars
    WORD si_DispPos
    WORD si_UndoPos
    WORD si_NumChars
    WORD si_DispCount
    WORD si_CLeft
    WORD si_CTop
    APTR  si_LayerPtr
    LONG  si_LongInt
    APTR si_AltKeyMap
    LABEL si_SIZEOF
 STRUCTURE IntuiText,0
    BYTE it_FrontPen
    BYTE it_BackPen
    BYTE it_DrawMode
    BYTE it_KludgeFill00
    WORD it_LeftEdge
    WORD it_TopEdge
    APTR  it_ITextFont
    APTR it_IText
    APTR  it_NextText
    LABEL it_SIZEOF
 STRUCTURE Border,0
    WORD  bd_LeftEdge
    WORD  bd_TopEdge
    BYTE  bd_FrontPen
    BYTE  bd_BackPen
    BYTE  bd_DrawMode
    BYTE  bd_Count
    APTR  bd_XY
    APTR  bd_NextBorder
    LABEL bd_SIZEOF
 STRUCTURE Image,0
    WORD ig_LeftEdge
    WORD ig_TopEdge
    WORD ig_Width
    WORD ig_Height
    WORD ig_Depth
    APTR ig_ImageData
    BYTE ig_PlanePick
    BYTE ig_PlaneOnOff
    APTR ig_NextImage
    LABEL ig_SIZEOF
 STRUCTURE IntuiMessage,0
    STRUCT im_ExecMessage,MN_SIZE
    LONG im_Class
    WORD im_Code
    WORD im_Qualifier
    APTR im_IAddress
    WORD im_MouseX
    WORD im_MouseY
    LONG im_Seconds
    LONG im_Micros
    APTR im_IDCMPWindow
    APTR im_SpecialLink
    LABEL  im_SIZEOF
SIZEVERIFY      EQU     $00000001
NEWSIZE         EQU     $00000002
REFRESHWINDOW   EQU     $00000004
MOUSEBUTTONS    EQU     $00000008
MOUSEMOVE       EQU     $00000010
GADGETDOWN      EQU     $00000020
GADGETUP        EQU     $00000040
REQSET          EQU     $00000080
MENUPICK        EQU     $00000100
CLOSEWINDOW     EQU     $00000200
RAWKEY          EQU     $00000400
REQVERIFY       EQU     $00000800
REQCLEAR        EQU     $00001000
MENUVERIFY      EQU     $00002000
NEWPREFS        EQU     $00004000
DISKINSERTED    EQU     $00008000
DISKREMOVED     EQU     $00010000
WBENCHMESSAGE   EQU     $00020000
ACTIVEWINDOW    EQU     $00040000
INACTIVEWINDOW  EQU     $00080000
DELTAMOVE       EQU     $00100000
VANILLAKEY      EQU     $00200000
INTUITICKS      EQU     $00400000
LONELYMESSAGE   EQU     $80000000
MENUHOT         EQU     $0001
MENUCANCEL      EQU     $0002
MENUWAITING     EQU     $0003
OKOK            EQU     MENUHOT
OKABORT         EQU     $0004
OKCANCEL        EQU     MENUCANCEL
WBENCHOPEN      EQU $0001
WBENCHCLOSE     EQU $0002
 STRUCTURE Window,0
    APTR wd_NextWindow
    WORD wd_LeftEdge
    WORD wd_TopEdge
    WORD wd_Width
    WORD wd_Height
    WORD wd_MouseY
    WORD wd_MouseX
    WORD wd_MinWidth
    WORD wd_MinHeight
    WORD wd_MaxWidth
    WORD wd_MaxHeight
    LONG wd_Flags
    APTR wd_MenuStrip
    APTR wd_Title
    APTR wd_FirstRequest
    APTR wd_DMRequest
    WORD wd_ReqCount
    APTR wd_WScreen
    APTR wd_RPort
    BYTE wd_BorderLeft
    BYTE wd_BorderTop
    BYTE wd_BorderRight
    BYTE wd_BorderBottom
    APTR wd_BorderRPort
    APTR wd_FirstGadget
    APTR wd_Parent
    APTR wd_Descendant
    APTR wd_Pointer
    BYTE wd_PtrHeight
    BYTE wd_PtrWidth
    BYTE wd_XOffset
    BYTE wd_YOffset
    ULONG wd_IDCMPFlags
    APTR wd_UserPort
    APTR wd_WindowPort
    APTR wd_MessageKey
    BYTE wd_DetailPen
    BYTE wd_BlockPen
    APTR wd_CheckMark
    APTR wd_ScreenTitle
    WORD wd_GZZMouseX
    WORD wd_GZZMouseY
    WORD wd_GZZWidth
    WORD wd_GZZHeight
    APTR wd_ExtData
    APTR wd_UserData
    APTR wd_WLayer
    APTR IFont
    LABEL wd_Size
WINDOWSIZING    EQU $0001
WINDOWDRAG      EQU $0002
WINDOWDEPTH     EQU $0004
WINDOWCLOSE     EQU $0008
SIZEBRIGHT      EQU $0010
SIZEBBOTTOM     EQU $0020
REFRESHBITS     EQU $00C0
SMART_REFRESH   EQU $0000
SIMPLE_REFRESH  EQU $0040
SUPER_BITMAP    EQU $0080
OTHER_REFRESH   EQU $00C0
BACKDROP        EQU $0100
REPORTMOUSE     EQU $0200
GIMMEZEROZERO   EQU $0400
BORDERLESS      EQU $0800
ACTIVATE        EQU $1000
WINDOWACTIVE    EQU $2000
INREQUEST       EQU $4000
MENUSTATE       EQU $8000
RMBTRAP         EQU $00010000
NOCAREREFRESH   EQU $00020000
WINDOWREFRESH   EQU $01000000
WBENCHWINDOW    EQU $02000000
WINDOWTICKED    EQU $04000000
SUPER_UNUSED    EQU $FCFC0000
 STRUCTURE NewWindow,0
    WORD nw_LeftEdge
    WORD nw_TopEdge
    WORD nw_Width
    WORD nw_Height
    BYTE nw_DetailPen
    BYTE nw_BlockPen
    LONG nw_IDCMPFlags
    LONG nw_Flags
    APTR        nw_FirstGadget
    APTR nw_CheckMark
    APTR nw_Title
    APTR nw_Screen
    APTR nw_BitMap
    WORD nw_MinWidth
    WORD nw_MinHeight
    WORD nw_MaxWidth
    WORD nw_MaxHeight
    WORD nw_Type
    LABEL nw_SIZE
 STRUCTURE Screen,0
    APTR sc_NextScreen
    APTR sc_FirstWindow
    WORD sc_LeftEdge
    WORD sc_TopEdge
    WORD sc_Width
    WORD sc_Height
    WORD sc_MouseY
    WORD sc_MouseX
    WORD sc_Flags
    APTR sc_Title
    APTR sc_DefaultTitle
    BYTE sc_BarHeight
    BYTE sc_BarVBorder
    BYTE sc_BarHBorder
    BYTE sc_MenuVBorder
    BYTE sc_MenuHBorder
    BYTE sc_WBorTop
    BYTE sc_WBorLeft
    BYTE sc_WBorRight
    BYTE sc_WBorBottom
    BYTE sc_KludgeFill00
    APTR sc_Font
    STRUCT sc_ViewPort,vp_SIZEOF
    STRUCT sc_RastPort,rp_SIZEOF
    STRUCT sc_BitMap,bm_SIZEOF
    STRUCT sc_LayerInfo,li_SIZEOF
    APTR sc_FirstGadget
    BYTE sc_DetailPen
    BYTE sc_BlockPen
    WORD sc_SaveColor0
    APTR sc_BarLayer
    APTR sc_ExtData
    APTR sc_UserData
    LABEL sc_SIZEOF
SCREENTYPE      EQU     $000F
WBENCHSCREEN    EQU     $0001
CUSTOMSCREEN    EQU     $000F
SHOWTITLE       EQU     $0010
BEEPING         EQU     $0020
CUSTOMBITMAP    EQU     $0040
SCREENBEHIND    EQU     $0080
SCREENQUIET     EQU     $0100
STDSCREENHEIGHT EQU     -1
 STRUCTURE NewScreen,0
    WORD ns_LeftEdge
    WORD ns_TopEdge
    WORD ns_Width
    WORD ns_Height
    WORD ns_Depth
    BYTE ns_DetailPen
    BYTE ns_BlockPen
    WORD ns_ViewModes
    WORD ns_Type
    APTR ns_Font
    APTR ns_DefaultTitle
    APTR ns_Gadgets
    APTR ns_CustomBitMap
 LABEL    ns_SIZEOF
FILENAME_SIZE EQU       30
POINTERSIZE     EQU     (1+16+1)*2
TOPAZ_EIGHTY    EQU     8
TOPAZ_SIXTY     EQU     9
 STRUCTURE Preferences,0
    BYTE pf_FontHeight
    BYTE pf_PrinterPort
    WORD pf_BaudRate
    STRUCT pf_KeyRptSpeed,TV_SIZE
    STRUCT pf_KeyRptDelay,TV_SIZE
    STRUCT pf_DoubleClick,TV_SIZE
    STRUCT pf_PointerMatrix,POINTERSIZE*2
    BYTE pf_XOffset
    BYTE pf_YOffset
    WORD pf_color17
    WORD pf_color18
    WORD pf_color19
    WORD pf_PointerTicks
    WORD pf_color0
    WORD pf_color1
    WORD pf_color2
    WORD pf_color3
    BYTE pf_ViewXOffset
    BYTE pf_ViewYOffset
    WORD pf_ViewInitX
    WORD pf_ViewInitY
    BOOL EnableCLI
    WORD pf_PrinterType
    STRUCT pf_PrinterFilename,FILENAME_SIZE
    WORD pf_PrintPitch
    WORD pf_PrintQuality
    WORD pf_PrintSpacing
    WORD pf_PrintLeftMargin
    WORD pf_PrintRightMargin
    WORD pf_PrintImage
    WORD pf_PrintAspect
    WORD pf_PrintShade
    WORD pf_PrintThreshold
    WORD pf_PaperSize
    WORD pf_PaperLength
    WORD pf_PaperType
    BYTE pf_SerRWBits
    BYTE pf_SerStopBuf
    BYTE pf_SerParShk
    BYTE pf_LaceWB
    STRUCT pf_WorkName,FILENAME_SIZE
    BYTE pf_RowSizeChange
    BYTE pf_ColumnSizeChange
    STRUCT pf_padding,14
    LABEL pf_SIZEOF
LACEWB          EQU     $01
PARALLEL_PRINTER EQU    $00
SERIAL_PRINTER  EQU     $01
BAUD_110        EQU     $00
BAUD_300        EQU     $01
BAUD_1200       EQU     $02
BAUD_2400       EQU     $03
BAUD_4800       EQU     $04
BAUD_9600       EQU     $05
BAUD_19200      EQU     $06
BAUD_MIDI       EQU     $07
FANFOLD         EQU     $00
SINGLE          EQU     $80
PICA            EQU     $000
ELITE           EQU     $400
FINE            EQU     $800
DRAFT           EQU     $000
LETTER          EQU     $100
SIX_LPI         EQU     $000
EIGHT_LPI       EQU     $200
IMAGE_POSITIVE  EQU     $00
IMAGE_NEGATIVE  EQU     $01
ASPECT_HORIZ    EQU     $00
ASPECT_VERT     EQU     $01
SHADE_BW        EQU     $00
SHADE_GREYSCALE EQU     $01
SHADE_COLOR     EQU     $02
US_LETTER       EQU     $00
US_LEGAL        EQU     $10
N_TRACTOR       EQU     $20
W_TRACTOR       EQU     $30
CUSTOM          EQU     $40
CUSTOM_NAME     EQU     $00
ALPHA_P_101     EQU     $01
BROTHER_15XL    EQU     $02
CBM_MPS1000     EQU     $03
DIAB_630        EQU     $04
DIAB_ADV_D25    EQU     $05
DIAB_C_150      EQU     $06
EPSON           EQU     $07
EPSON_JX_80     EQU     $08
OKIMATE_20      EQU     $09
QUME_LP_20      EQU     $0A
HP_LASERJET     EQU     $0B
HP_LASERJET_PLUS EQU    $0C
SBUF_512        EQU     $00
SBUF_1024       EQU     $01
SBUF_2048       EQU     $02
SBUF_4096       EQU     $03
SBUF_8000       EQU     $04
SBUF_16000      EQU     $05
SREAD_BITS      EQU     $F0
SWRITE_BITS     EQU     $0F
SSTOP_BITS      EQU     $F0
SBUFSIZE_BITS   EQU     $0F
SPARITY_BITS    EQU     $F0
SHSHAKE_BITS    EQU     $0F
SPARITY_NONE    EQU     $00
SPARITY_EVEN    EQU     $01
SPARITY_ODD     EQU     $02
SHSHAKE_XON     EQU     $00
SHSHAKE_RTS     EQU     $01
SHSHAKE_NONE    EQU     $02
 STRUCTURE Remember,0
    APTR rm_NextRemember
    LONG rm_RememberSize
    APTR rm_Memory
 LABEL    rm_SIZEOF
NOMENU EQU      $001F
NOITEM EQU      $003F
NOSUB  EQU      $001F
MENUNULL EQU    $FFFF
CHECKWIDTH      EQU     19
COMMWIDTH       EQU     27
LOWCHECKWIDTH   EQU     13
LOWCOMMWIDTH    EQU     16
ALERT_TYPE      EQU     $80000000
RECOVERY_ALERT  EQU     $00000000
DEADEND_ALERT   EQU     $80000000
AUTOFRONTPEN    EQU     0
AUTOBACKPEN     EQU     1
AUTODRAWMODE    EQU     RP_JAM2
AUTOLEFTEDGE    EQU     6
AUTOTOPEDGE     EQU     3
AUTOITEXTFONT   EQU     0
AUTONEXTTEXT    EQU     0
SELECTUP        EQU     (IECODE_LBUTTON+IECODE_UP_PREFIX)
SELECTDOWN      EQU     (IECODE_LBUTTON)
MENUUP          EQU     (IECODE_RBUTTON+IECODE_UP_PREFIX)
MENUDOWN        EQU     (IECODE_RBUTTON)
ALTLEFT         EQU     (IEQUALIFIER_LALT)
ALTRIGHT        EQU     (IEQUALIFIER_RALT)
AMIGALEFT       EQU     (IEQUALIFIER_LCOMMAND)
AMIGARIGHT      EQU     (IEQUALIFIER_RCOMMAND)
AMIGAKEYS       EQU     (AMIGALEFT+AMIGARIGHT)
CURSORUP        EQU     $4C
CURSORLEFT      EQU     $4F
CURSORRIGHT     EQU     $4E
CURSORDOWN      EQU     $4D
KEYCODE_Q       EQU     $10
KEYCODE_X       EQU     $32
KEYCODE_N       EQU     $36
KEYCODE_M       EQU     $37
KEYCODE_V       EQU     $34
KEYCODE_B       EQU     $35
 IFND    INTUITION_INTUITIONBASE_I
 include 'intuition/intuitionbase.i'
 ENDC
 ENDC
