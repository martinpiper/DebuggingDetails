    IFND EXEC_EXECNAME_I
EXEC_EXECNAME_I SET 1

EXECNAME        macro
                dc.b    'exec.library',0
                ds.w    0
                endm

    ENDC !EXEC_EXECNAME_I

