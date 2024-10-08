
   IFND  HARDWARE_CIA_I
HARDWARE_CIA_I SET   1
ciapra            EQU   $0000
ciaprb            EQU   $0100
ciaddra           EQU   $0200
ciaddrb           EQU   $0300
ciatalo           EQU   $0400
ciatahi           EQU   $0500
ciatblo           EQU   $0600
ciatbhi           EQU   $0700
ciatodlow         EQU   $0800
ciatodmid         EQU   $0900
ciatodhi          EQU   $0A00
ciasdr            EQU   $0C00
ciaicr            EQU   $0D00
ciacra            EQU   $0E00
ciacrb            EQU   $0F00
CIAICRB_TA        EQU   0
CIAICRB_TB        EQU   1
CIAICRB_ALRM      EQU   2
CIAICRB_SP        EQU   3
CIAICRB_FLG       EQU   4
CIAICRB_IR        EQU   7
CIAICRB_SETCLR    EQU   7
CIACRAB_START     EQU   0
CIACRAB_PBON      EQU   1
CIACRAB_OUTMODE   EQU   2
CIACRAB_RUNMODE   EQU   3
CIACRAB_LOAD      EQU   4
CIACRAB_INMODE    EQU   5
CIACRAB_SPMODE    EQU   6
CIACRAB_TODIN     EQU   7
CIACRBB_START     EQU   0
CIACRBB_PBON      EQU   1
CIACRBB_OUTMODE   EQU   2
CIACRBB_RUNMODE   EQU   3
CIACRBB_LOAD      EQU   4
CIACRBB_INMODE0   EQU   5
CIACRBB_INMODE1   EQU   6
CIACRBB_ALARM     EQU   7
CIAICRF_TA        EQU   (1<<0)
CIAICRF_TB        EQU   (1<<1)
CIAICRF_ALRM      EQU   (1<<2)
CIAICRF_SP        EQU   (1<<3)
CIAICRF_FLG       EQU   (1<<4)
CIAICRF_IR        EQU   (1<<7)
CIAICRF_SETCLR    EQU   (1<<7)
CIACRAF_START     EQU   (1<<0)
CIACRAF_PBON      EQU   (1<<1)
CIACRAF_OUTMODE   EQU   (1<<2)
CIACRAF_RUNMODE   EQU   (1<<3)
CIACRAF_LOAD      EQU   (1<<4)
CIACRAF_INMODE    EQU   (1<<5)
CIACRAF_SPMODE    EQU   (1<<6)
CIACRAF_TODIN     EQU   (1<<7)
CIACRBF_START     EQU   (1<<0)
CIACRBF_PBON      EQU   (1<<1)
CIACRBF_OUTMODE   EQU   (1<<2)
CIACRBF_RUNMODE   EQU   (1<<3)
CIACRBF_LOAD      EQU   (1<<4)
CIACRBF_INMODE0   EQU   (1<<5)
CIACRBF_INMODE1   EQU   (1<<6)
CIACRBF_ALARM     EQU   (1<<7)
CIACRBF_IN_PHI2   EQU   0
CIACRBF_IN_CNT    EQU   (CIACRBF_INMODE0)
CIACRBF_IN_TA     EQU   (CIACRBF_INMODE1)
CIACRBF_IN_CNT_TA EQU   (CIACRBF_INMODE0!CIACRBF_INMODE1)
CIAB_GAMEPORT1    EQU   (7)
CIAB_GAMEPORT0    EQU   (6)
CIAB_DSKRDY       EQU   (5)
CIAB_DSKTRACK0    EQU   (4)
CIAB_DSKPROT      EQU   (3)
CIAB_DSKCHANGE    EQU   (2)
CIAB_LED          EQU   (1)
CIAB_OVERLAY      EQU   (0)
CIAB_COMDTR       EQU   (7)
CIAB_COMRTS       EQU   (6)
CIAB_COMCD        EQU   (5)
CIAB_COMCTS       EQU   (4)
CIAB_COMDSR       EQU   (3)
CIAB_PRTRSEL      EQU   (2)
CIAB_PRTRPOUT     EQU   (1)
CIAB_PRTRBUSY     EQU   (0)
CIAB_DSKMOTOR     EQU   (7)
CIAB_DSKSEL3      EQU   (6)
CIAB_DSKSEL2      EQU   (5)
CIAB_DSKSEL1      EQU   (4)
CIAB_DSKSEL0      EQU   (3)
CIAB_DSKSIDE      EQU   (2)
CIAB_DSKDIREC     EQU   (1)
CIAB_DSKSTEP      EQU   (0)
CIAF_GAMEPORT1    EQU   (1<<7)
CIAF_GAMEPORT0    EQU   (1<<6)
CIAF_DSKRDY       EQU   (1<<5)
CIAF_DSKTRACK0    EQU   (1<<4)
CIAF_DSKPROT      EQU   (1<<3)
CIAF_DSKCHANGE    EQU   (1<<2)
CIAF_LED          EQU   (1<<1)
CIAF_OVERLAY      EQU   (1<<0)
CIAF_COMDTR       EQU   (1<<7)
CIAF_COMRTS       EQU   (1<<6)
CIAF_COMCD        EQU   (1<<5)
CIAF_COMCTS       EQU   (1<<4)
CIAF_COMDSR       EQU   (1<<3)
CIAF_PRTRSEL      EQU   (1<<2)
CIAF_PRTRPOUT     EQU   (1<<1)
CIAF_PRTRBUSY     EQU   (1<<0)
CIAF_DSKMOTOR     EQU   (1<<7)
CIAF_DSKSEL3      EQU   (1<<6)
CIAF_DSKSEL2      EQU   (1<<5)
CIAF_DSKSEL1      EQU   (1<<4)
CIAF_DSKSEL0      EQU   (1<<3)
CIAF_DSKSIDE      EQU   (1<<2)
CIAF_DSKDIREC     EQU   (1<<1)
CIAF_DSKSTEP      EQU   (1<<0)
   ENDC  !HARDWARE_CIA_I
