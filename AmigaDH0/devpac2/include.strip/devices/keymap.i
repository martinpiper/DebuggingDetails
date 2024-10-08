   IFND  DEVICES_KEYMAP_I
DEVICES_KEYMAP_I  SET   1
       IFND     EXEC_NODES_I
       INCLUDE  "exec/nodes.i"
       ENDC
       IFND     EXEC_LISTS_I
       INCLUDE  "exec/lists.i"
       ENDC
 STRUCTURE  KeyMap,0
   APTR  km_LoKeyMapTypes
   APTR  km_LoKeyMap
   APTR  km_LoCapsable
   APTR  km_LoRepeatable
   APTR  km_HiKeyMapTypes
   APTR  km_HiKeyMap
   APTR  km_HiCapsable
   APTR  km_HiRepeatable
   LABEL km_SIZEOF
 STRUCTURE      KeyMapNode,0
    STRUCT  kn_Node,LN_SIZE
    STRUCT  kn_KeyMap,km_SIZEOF
    LABEL   kn_SIZEOF
 STRUCTURE      KeyMapResource,0
    STRUCT  kr_Node,LN_SIZE
    STRUCT  kr_List,LH_SIZE
    LABEL   kr_SIZEOF
KCB_NOP     EQU   7
KCF_NOP     EQU   $80
KC_NOQUAL   EQU   0
KC_VANILLA  EQU   7
KCB_SHIFT   EQU   0
KCF_SHIFT   EQU   $01
KCB_ALT     EQU   1
KCF_ALT     EQU   $02
KCB_CONTROL EQU   2
KCF_CONTROL EQU   $04
KCB_DOWNUP  EQU   3
KCF_DOWNUP  EQU   $08
KCB_DEAD    EQU   5
KCF_DEAD    EQU   $20
KCB_STRING  EQU   6
KCF_STRING  EQU   $40
DPB_MOD         EQU     0
DPF_MOD         EQU     $01
DPB_DEAD        EQU     3
DPF_DEAD        EQU     $08
DP_2DINDEXMASK  EQU     $0F
DP_2DFACSHIFT   EQU     4
   ENDC
