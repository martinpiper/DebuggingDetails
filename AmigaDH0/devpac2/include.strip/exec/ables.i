    IFND EXEC_ABLES_I
EXEC_ABLES_I  SET 1
    IFND EXEC_TYPES_I
    INCLUDE "exec/types.i"
    ENDC !EXEC_TYPES_I
    IFND EXEC_EXECBASE_I
    INCLUDE "exec/execbase.i"
    ENDC !EXEC_EXECBASE_I
INT_ABLES   MACRO                       *
     XREF    _intena
     ENDM
DISABLE     MACRO   *
     IFC     '\1',''
     MOVE.W  #$04000,_intena
     ADDQ.B  #1,IDNestCnt(A6)
     ENDC
     IFNC    '\1',''
     MOVE.L  4,\1
     MOVE.W  #$04000,_intena
     ADDQ.B  #1,IDNestCnt(\1)
     ENDC
     ENDM
ENABLE      MACRO   *
     IFC     '\1',''
     SUBQ.B  #1,IDNestCnt(A6)
     BGE.S   ENABLE\@
     MOVE.W  #$0C000,_intena
ENABLE\@:
     ENDC
     IFNC    '\1',''
     MOVE.L  4,\1
     SUBQ.B  #1,IDNestCnt(\1)
     BGE.S   ENABLE\@
     MOVE.W  #$0C000,_intena
ENABLE\@:
     ENDC
     ENDM
TASK_ABLES  MACRO
     XREF    _LVOPermit
     ENDM
FORBID      MACRO
     IFC     '\1',''
     ADDQ.B  #1,TDNestCnt(A6)
     ENDC
     IFNC    '\1',''
     MOVE.L  4,\1
     ADDQ.B  #1,TDNestCnt(\1)
     ENDC
     ENDM
PERMIT      MACRO
     IFC     '\1',''
     JSR     _LVOPermit(A6)
     ENDC
     IFNC    '\1',''
     MOVE.L  A6,-(SP)
     MOVE.L  4,A6
     JSR     _LVOPermit(A6)
     MOVE.L  (SP)+,A6
     ENDC
     ENDM
    ENDC !EXEC_ABLES_I
