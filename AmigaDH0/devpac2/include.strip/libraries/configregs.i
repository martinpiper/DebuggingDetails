
 IFND    LIBRARIES_CONFIGREGS_I
LIBRARIES_CONFIGREGS_I  SET     1
 STRUCTURE ExpansionRom,0
    UBYTE       er_Type
    UBYTE       er_Product
    UBYTE       er_Flags
    UBYTE       er_Reserved03
    UWORD       er_Manufacturer
    ULONG       er_SerialNumber
    UWORD       er_InitDiagVec
    UBYTE       er_Reserved0c
    UBYTE       er_Reserved0d
    UBYTE       er_Reserved0e
    UBYTE       er_Reserved0f
    LABEL       ExpansionRom_SIZEOF
 STRUCTURE ExpansionControl,0
    UBYTE       ec_Interrupt
    UBYTE       ec_Reserved11
    UBYTE       ec_BaseAddress
    UBYTE       ec_Shutup
    UBYTE       ec_Reserved14
    UBYTE       ec_Reserved15
    UBYTE       ec_Reserved16
    UBYTE       ec_Reserved17
    UBYTE       ec_Reserved18
    UBYTE       ec_Reserved19
    UBYTE       ec_Reserved1a
    UBYTE       ec_Reserved1b
    UBYTE       ec_Reserved1c
    UBYTE       ec_Reserved1d
    UBYTE       ec_Reserved1e
    UBYTE       ec_Reserved1f
    LABEL       ExpansionControl_SIZEOF
E_SLOTSIZE              EQU     $10000
E_SLOTMASK              EQU     $ffff
E_SLOTSHIFT             EQU     16
E_EXPANSIONBASE         EQU     $e80000
E_EXPANSIONSIZE         EQU     $080000
E_EXPANSIONSLOTS        EQU     8
E_MEMORYBASE            EQU     $200000
E_MEMORYSIZE            EQU     $800000
E_MEMORYSLOTS           EQU     128
ERT_TYPEMASK            EQU     $c0
ERT_TYPEBIT             EQU     6
ERT_TYPESIZE            EQU     2
ERT_NEWBOARD            EQU     $c0
ERT_MEMMASK             EQU     $07
ERT_MEMBIT              EQU     0
ERT_MEMSIZE             EQU     3
 BITDEF  ERT,CHAINEDCONFIG,3
 BITDEF  ERT,DIAGVALID,4
 BITDEF  ERT,MEMLIST,5
 BITDEF  ERF,MEMSPACE,7
 BITDEF  ERF,NOSHUTUP,6

 BITDEF  ECI,INTENA,1
 BITDEF  ECI,RESET,3
 BITDEF  ECI,INT2PEND,4
 BITDEF  ECI,INT6PEND,5
 BITDEF  ECI,INT7PEND,6
 BITDEF  ECI,INTERRUPTING,7
 STRUCTURE DiagArea,0
    UBYTE       da_Config
    UBYTE       da_Flags
    UWORD       da_Size
    UWORD       da_DiagPoint
    UWORD       da_BootPoint
    UWORD       da_Name
    UWORD       da_Reserved01
    UWORD       da_Reserved02
    LABEL       DiagArea_SIZEOF
DAC_BUSWIDTH    EQU     $C0
DAC_NIBBLEWIDE  EQU     $00
DAC_BYTEWIDE    EQU     $40
DAC_WORDWIDE    EQU     $80
DAC_BOOTTIME    EQU     $30
DAC_NEVER       EQU     $00
DAC_CONFIGTIME  EQU     $10
DAC_BINDTIME    EQU     $20
 ENDC    !LIBRARIES_CONFIGREGS_I
