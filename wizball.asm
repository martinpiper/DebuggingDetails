 ;     ----------- "Wizball" Audio Source File (SID/65xx system) -----------

 ;   --------- Design, code, music & arrangements by Martin Galway -----------

 ;   -------------------- Work started 10th February 1987. -------------------

 ;     ----- (C) OCEAN SOFTWARE LTD 16:31  Thursday 23rd    April 1987. ----

 ;======================*===CODE ENTRY INFORMATION===*==========================

 ;  ROUTINE       INSIDE INTERRUPTS?
 ;  -------       ------------------
 ;
 ;  InitSound     OUT
 ;  Sound0        IN
 ;  Sound1        IN
 ;  Sound2        IN
 ;  Music0        IN
 ;  Music1        IN
 ;  Music2        IN
 ;  MusicTest     IN
 ;  RefFilter     IN
 ;  Effect        OUT
 ;  Tune          OUT

 ;  LETTER TUNE VALUE SPEED ITEM
 ;  ------ ---------- ----- ----
 ;  B      1*7-2 *     50Hz Filth Raid
 ;  C      2*7-2 *    100Hz Bonus (music selected)
 ;  D      3*7-2 *     50Hz End Of Level jingle
 ;  E      4*7-2      200Hz Title screen music
 ;  F      5*7-2      200Hz Bonus (music not selected) - single-channel bass
 ;  G      6*7-2 *    200Hz Get ready jingle
 ;  H      7*7-2 *    200Hz Input Name screen
 ;  I      8*7-2 *     50Hz Game Over
 ;  J      9*7-2 *    200Hz Laboratory background sound
 ;  K     10*7-2 *     50Hz End Of Bonus Level

 ;Recommended screen Y-coordinates for the 4-refreshes-per-raster on P.A.L.:
 ;          32         110        188         10(+256) gap=78
 ;Recommended screen Y-coordinates for the 4-refreshes-per-raster on N.T.S.C.:
 ;          47         107        172           237    gap=65

 ;===========================*===SYSTEM VARIABLES===*===========================

ZERO0          EQU $0004
ZERO1          EQU $0029
ZERO2          EQU $0087
DEPTHOFSTACKS  EQU 5

               ORG ZERO0
PC0            DFS 2
PC1            DFS 2
PC2            DFS 2
CLOCK0         DFS 1
CLOCK1         DFS 1
CLOCK2         DFS 1
SP0            DFS 1
SP1            DFS 1
SP2            DFS 1
TR0            DFS 1
TR1            DFS 1
TR2            DFS 1
IN             DFS 2
S1FCURR        DFS 2
S2FCURR        DFS 2
OUT            DFS 2 ;this z.p. word to be used OUTSIDE INTERRUPTS ONLY!!!
Z8             DFS 1
ZPSIZE         EQU .-PC0

               ORG ZERO1
S0PCURR        DFS 2
S1PCURR        DFS 2
S2PCURR        DFS 2
S0FCURR        DFS 2
CUTST          DFS 16
CUT            DFS 22
FilterChannel  DFS 1
FilterByte     DFS 1
MFL0           DFS 1
MFL1           DFS 1
MFL2           DFS 1
channel        DFS 1
offset         DFS 1
EOZP1

               ORG ZERO2
D0             DFS 29
D2             DFS 29
S2             DFS 35
ST0L           DFS DEPTHOFSTACKS ;                    stack (low bytes only)
ST0H           DFS DEPTHOFSTACKS ;                   stack (high bytes only)
ST0C           DFS DEPTHOFSTACKS ;                  stack(for/next counters)
ST1L           DFS DEPTHOFSTACKS
ST1H           DFS DEPTHOFSTACKS
EOZP2

COM            EQU $C0
Rest           EQU $5F
R              EQU $60
RestR          EQU Rest+R
Ret            EQU COM+0
Call           EQU COM+2
Jmp            EQU COM+4
CT             EQU COM+6
JT             EQU COM+8
Moke           EQU COM+10
For            EQU COM+12
Next           EQU COM+14
FLoad          EQU COM+16
Vlm            EQU COM+18
Soke           EQU COM+20
Code           EQU COM+22
Transp         EQU COM+24
DMoke          EQU COM+26
DSoke          EQU COM+28
Master         EQU COM+30
Filter         EQU COM+32
Disown         EQU COM+34
MBendOff       EQU COM+36
MBendOn        EQU COM+38
Freq           EQU COM+40
Time           EQU COM+42

FMG0           EQU 0
FMG1           EQU 2
FMG2           EQU 4
FMG3           EQU 6
FMD0           EQU 8
FMD1           EQU 9
CHS            EQU 9
FMD2           EQU 10
FMD3           EQU 11
FMDLY          EQU 12
FMC            EQU 13
CFINIT         EQU 14
PMD0           EQU 14
PMD1           EQU 15
PMDLY          EQU 16
PMC            EQU 17
PMG0           EQU 18
PMG1           EQU 20
PINIT          EQU 22
VWF            EQU 24
VADV           EQU 25
VSRV           EQU 26
VADSD          EQU 27
VRD            EQU 28

FOLDC          EQU 4 ; F.O.M. Duration Counter (new feature)
FBG            EQU 6
FOLOD          EQU 6 ; F.O.M. Offset Duration (new feature)
CFMD0          EQU 8
FOLA           EQU 8 ; F.O.M. Offset List Address (new feature)
CFMD1          EQU 9
CFMD2          EQU 10
FOLB           EQU 10
CFMD3          EQU 11
FOLII          EQU 11
FBD            EQU 12
FOLCI          EQU 12
CPMD0          EQU 14
CPMD1          EQU 15
FINIT          EQU 24
VWFG           EQU 26
VADSC          EQU 27
VRC            EQU 28
FMD0C          EQU 29
FMD1C          EQU 30
FMD2C          EQU 31
FMD3C          EQU 32
PMD0C          EQU 33
PMD1C          EQU 34

 ;***** "OFFSET LIST" FM DATA STRUCTURE ***
 ;0&1 RESERVED - MUST BE 0
 ;2&3 RESERVED - MUST BE 0
 ;4&5 INITIAL SINGLE OFFSET DURATION COUNTER VALUE - USUALLY 1
 ;6&7 MAXIMUM-EVER SINGLE OFFSET DURATION - 1-255
 ;8&9 ADDRESS OF OFFSET LIST (LIST IS READ THROUGH END-FIRST, GOING BACKWARDS)
 ;10  RESERVED - MUST BE 0
 ;11  MAXIMUM OFFSET LIST INDEX 0-255
 ;12  RESERVED - MUST BE 0
 ;13  FM CONTROL - ANY VALUE THAT HAS BIT 3 SET (E.G. 8)

 ;=== P.A.L. FREQUENCY TABLE (NOT TO BE USED ON N.T.S.C.) : 1.019 MHz CLOCK ===

 ;BASE "A" VALUE FOR THIS OCTAVE IS 235. (EQUIVALENT TO N-03)

N00            EQU 279
N01            EQU 296
N02            EQU 314
N03            EQU 332
N04            EQU 352
N05            EQU 373
N06            EQU 395
N07            EQU 419
N08            EQU 444
N09            EQU 470
N10            EQU 498
N11            EQU 528
N12            EQU 559
N13            EQU 592
N14            EQU 627
N15            EQU 665
N16            EQU 704
N17            EQU 746
N18            EQU 790
N19            EQU 837
N20            EQU 887
N21            EQU 940
N22            EQU 996
N23            EQU 1055
N24            EQU 1118
N25            EQU 1184
N26            EQU 1255
N27            EQU 1330
N28            EQU 1408
N29            EQU 1492
N30            EQU 1581
N31            EQU 1675
N32            EQU 1774
N33            EQU 1880
N34            EQU 1992
N35            EQU 2110
N36            EQU 2236
N37            EQU 2369
N38            EQU 2509
N39            EQU 2659
N40            EQU 2817
N41            EQU 2984
N42            EQU 3162
N43            EQU 3350
N44            EQU 3549
N45            EQU 3760
N46            EQU 3984
N47            EQU 4220
N48            EQU 4471
N49            EQU 4737
N50            EQU 5019
N51            EQU 5317
N52            EQU 5634
N53            EQU 5969
N54            EQU 6324
N55            EQU 6700
N56            EQU 7098
N57            EQU 7520
N58            EQU 7967
N59            EQU 8441
N60            EQU 8943
N61            EQU 9475
N62            EQU 10038
N63            EQU 10635
N64            EQU 11267
N65            EQU 11937
N66            EQU 12647
N67            EQU 13399
N68            EQU 14195
N69            EQU 15040
N70            EQU 15934
N71            EQU 16881
N72            EQU 17886
N73            EQU 18949
N74            EQU 20076
N75            EQU 21270
N76            EQU 22534
N77            EQU 23875
N78            EQU 25294
N79            EQU 26798
N80            EQU 28391
N81            EQU 30080
N82            EQU 31869
N83            EQU 33764
N84            EQU 35771
N85            EQU 37898
N86            EQU 40151
N87            EQU 42540
N88            EQU 45069
N89            EQU 47749
N90            EQU 50588
N91            EQU 53596
N92            EQU 56783
N93            EQU 60160

 ;=== N.T.S.C. FREQUENCY TABLE (NOT TO BE USED ON P.A.L.) : 1 MHz CLOCK RATE ===

 ;BASE "A" VALUE FOR THIS OCTAVE IS 231. (EQUIVALENT TO N-03)

 ;N00           EQU 274
 ;N01           EQU 291
 ;N02           EQU 308
 ;N03           EQU 326
 ;N04           EQU 346
 ;N05           EQU 366
 ;N06           EQU 388
 ;N07           EQU 411
 ;N08           EQU 435
 ;N09           EQU 461
 ;N10           EQU 489
 ;N11           EQU 518
 ;N12           EQU 548
 ;N13           EQU 581
 ;N14           EQU 616
 ;N15           EQU 652
 ;N16           EQU 691
 ;N17           EQU 732
 ;N18           EQU 776
 ;N19           EQU 822
 ;N20           EQU 871
 ;N21           EQU 923
 ;N22           EQU 978
 ;N23           EQU 1036
 ;N24           EQU 1097
 ;N25           EQU 1163
 ;N26           EQU 1232
 ;N27           EQU 1305
 ;N28           EQU 1383
 ;N29           EQU 1465
 ;N30           EQU 1552
 ;N31           EQU 1644
 ;N32           EQU 1742
 ;N33           EQU 1845
 ;N34           EQU 1966
 ;N35           EQU 2071
 ;N36           EQU 2195
 ;N37           EQU 2325
 ;N38           EQU 2463
 ;N39           EQU 2620
 ;N40           EQU 2765
 ;N41           EQU 2930
 ;N42           EQU 3104
 ;N43           EQU 3288
 ;N44           EQU 3484
 ;N45           EQU 3691
 ;N46           EQU 3910
 ;N47           EQU 4143
 ;N48           EQU 4389
 ;N49           EQU 4650
 ;N50           EQU 4927
 ;N51           EQU 5220
 ;N52           EQU 5530
 ;N53           EQU 5859
 ;N54           EQU 6207
 ;N55           EQU 6577
 ;N56           EQU 6968
 ;N57           EQU 7382
 ;N58           EQU 7821
 ;N59           EQU 8286
 ;N60           EQU 8779
 ;N61           EQU 9301
 ;N62           EQU 9854
 ;N63           EQU 10440
 ;N64           EQU 11060
 ;N65           EQU 11718
 ;N66           EQU 12415
 ;N67           EQU 13153
 ;N68           EQU 13935
 ;N69           EQU 14764
 ;N70           EQU 15742
 ;N71           EQU 16572
 ;N72           EQU 17557
 ;N73           EQU 18601
 ;N74           EQU 19708
 ;N75           EQU 20897
 ;N76           EQU 22121
 ;N77           EQU 23436
 ;N78           EQU 24730
 ;N79           EQU 26306
 ;N80           EQU 27871
 ;N81           EQU 29528
 ;N82           EQU 31284
 ;N83           EQU 33144
 ;N84           EQU 35115
 ;N85           EQU 37203
 ;N86           EQU 39145
 ;N87           EQU 41759
 ;N88           EQU 44242
 ;N89           EQU 46873
 ;N90           EQU 49660
 ;N91           EQU 52613
 ;N92           EQU 55741
 ;N93           EQU 59056

NSil           EQU 00000 ;                Silence (the same at both clock speeds)

SCREEN         EQU $0400
ROW0           EQU SCREEN+0*40
SPEED          EQU ROW0+33
YYY            EQU ROW0+37
ROW1           EQU SCREEN+1*40
TIMER          EQU ROW1+08
FASTER         EQU ROW1+39
ROW2           EQU SCREEN+2*40
ROW3           EQU SCREEN+3*40
ROW4           EQU SCREEN+4*40
ROW5           EQU SCREEN+5*40
ROW6           EQU SCREEN+6*40
ROW7           EQU SCREEN+7*40
ROW8           EQU SCREEN+8*40
ROW9           EQU SCREEN+9*40
ROW10          EQU SCREEN+10*40
ROW11          EQU SCREEN+11*40
ROW12          EQU SCREEN+12*40
ROW13          EQU SCREEN+13*40
ROW14          EQU SCREEN+14*40
ROW15          EQU SCREEN+15*40
ROW16          EQU SCREEN+16*40
ROW17          EQU SCREEN+17*40
ROW18          EQU SCREEN+18*40
ROW19          EQU SCREEN+19*40
ROW20          EQU SCREEN+20*40
ROW21          EQU SCREEN+21*40
ROW22          EQU SCREEN+22*40
ROW23          EQU SCREEN+23*40
ROW24          EQU SCREEN+24*40
BDR            EQU $D020
MREFCOLOUR     EQU 1 ;                                 White, for music refreshes
DREFCOLOUR     EQU 15 ;                       Desired colour for display refreshes

 ;======================************************================================
 ;======================*=== DRIVER PROGRAM ===*================================
 ;======================************************================================

               ORG $1000 ; was $0800 (BOZ)
               ENT  ;\

Start          SEI 
               JSR InitScreen
               JSR InitKeyScan
               JSR INITSOUND
               LDX #$1F
               STX $D418
;               JSR Title
			   JSR FilthRaid
               JSR FastForward
               LDA #Q
               BNE DLoop
               LDY #10
               JSR Delay

DLoop          JSR DREFRESH
               JSR KeyScan
               BEQ nk
               STA BDR
cf0            CMP #13
               BNE cf1
               INC RF
               JMP nk
cf1            CMP #&+
               BNE cf2
               JSR IncRefsp
               JMP nk
cf2            CMP #&-
               BNE cf3
               JSR DecRefsp
               JMP nk
cf3            CMP #&@
               BNE cf4
               LDX #1
               STX Refsp+1
               DEX 
               STX Refsp
               JMP nk
cf4            CMP #&*
               BNE cf5
               LDX #0
               STX Refsp+1
               INX 
               STX Refsp
               JMP nk
cf5            CMP #&Z+1
               BCS nk
               CMP #&A
               BCC nk
               ASL 
               TAY 
lowbyte        LDA DVTABL-&A*2,Y 
               STA DVEC+1
highbyte       LDA DVTABL-&A*2+1,Y 
               STA DVEC+2
DVEC           JSR $DDDD
nk             JMP DLoop

DVTABL         DFW INITSOUND,FilthRaid,BonusMusic,EndOfLevel,Title,BonusBass ;AF
               DFW GetReady,InputName,GameOver,Laboratory,EndOfBonus,FaFo,FaFo ;GM
               DFW FaFo,FaFo,FaFo,FaFo,FaFo,FaFo,FaFo ;NS
               DFW FaFo,FaFo,FaFo,FaFo,FaFo,FaFo,FaFo ;TZ

FilthRaid      JSR ResetCl
               JSR StartCl
               LDY #1*7-2
               JMP TUNE
BonusMusic     JSR ResetCl
               JSR StartCl
               LDY #2*7-2
               JMP TUNE
EndOfLevel     JSR ResetCl
               JSR StartCl
               LDY #3*7-2
               JMP TUNE
Title          JSR ResetCl
               JSR StartCl
               LDY #4*7-2
               JMP TUNE
BonusBass      JSR ResetCl
               JSR StartCl
               LDY #5*7-2
               JMP TUNE
GetReady       JSR ResetCl
               JSR StartCl
               LDY #6*7-2
               JMP TUNE
InputName      JSR ResetCl
               JSR StartCl
               LDY #7*7-2
               JMP TUNE
GameOver       JSR ResetCl
               JSR StartCl
               LDY #8*7-2
               JMP TUNE
Laboratory     JSR ResetCl
               JSR StartCl
               LDY #9*7-2
               JMP TUNE
EndOfBonus     JSR ResetCl
               JSR StartCl
			   LDY #10*7-2
			   JMP TUNE

HANG           INC BDR
               JMP HANG

HANG0          LDX #0
               DFB $2C
HANG1          LDX #1
               DFB $2C
HANG2          LDX #2
               SEI 
               LDA #3
HANGLOOP       STA BDR
               STX BDR
               JMP HANGLOOP

WAITCLOCK00    LDX $D011
               BMI WAITCLOCK00
               BPL WAITCLOCKa
WAITCLOCK80    LDX $D011
               BPL WAITCLOCK80
WAITCLOCKa     CMP $D012
               BNE WAITCLOCKa
 ;              INC BDR:JSR SOUND2:JSR FILTER;JSR SOUND0:JSR SOUND1
 ;              DEC BDR
WAITCLOCKb     LDA Refsp
               ADC CREFSP
               STA CREFSP
               LDA CREFSP+1
               PHA 
               ADC Refsp+1
               STA CREFSP+1
               PLA 
               CMP CREFSP+1
               RTS 

FaFo           JSR f2
f2             JSR f3
f3             JSR f4
f4             JSR f5
f5             JSR f6
f6             JSR f7
f7             JSR f8
f8             JSR f9
f9             JSR f10
f10            JSR UpdateCl
               INC BDR
               JSR WAITCLOCKb
REFRESH        PHP 
               INC ClkAdd
               PLP 
               BEQ xit
               INC BDR
               JSR FILTER
               LDX #CH0VALUE
               BEQ R1x
               JSR MUSIC0
               JSR SOUND0
R1x            LDX #CH1VALUE
               BEQ R1y
               JSR MUSIC1
               JSR SOUND1
R1y            LDX #CH2VALUE
               BEQ xit
               JSR MUSIC2
               JSR SOUND2
xit            DEC BDR
               RTS 

ResetCl        LDA #&0
               LDX #5
RCLoop         STA CD5,X 
               DEX 
               BPL RCLoop
StopCl         LDA #0
               DFL $2C
StartCl        LDA #1
               STA ClkAdd
sc2            RTS 

DREFRESH       LDA #32
               JSR WAITCLOCK00
               JSR REFRESH
               JSR RefScreen1
REF2           LDA #110
               JSR WAITCLOCK00
               JSR REFRESH
               JSR RefScreen2
REF3           LDA #188
               JSR WAITCLOCK00
               JSR REFRESH
               JSR RefScreen3
REF4           LDA #10
               JSR WAITCLOCK80
               JSR REFRESH
               JSR RefScreen4
               JMP UpdateCl

UpdateCl       LDA #0
               LDX #CH0VALUE
               BEQ u1
               ORA MFL0
               ORA S0+VRC
u1             LDX #CH1VALUE
               BEQ u2
               ORA MFL1
               ORA S1+VRC
u2             LDX #CH2VALUE
               BEQ ua
               ORA MFL2
               ORA S2+VRC
ua             TAX 
               BEQ StopCl
               LDA ClkAdd
               CMP #4
               BCC sc2
               LSR 
               LDX #0
               STX ClkAdd
               ADC CD0
               CMP #&9+1
               BCC ncu0
               LDA #&0
ncu0           STA CD0
               BCC PrintCl
               LDA CD1
               ADC #0
               CMP #&9+1
               BCC ncu1
               LDA #&0
ncu1           STA CD1
               BCC PrintCl
               LDA CD2
               ADC #0
               CMP #&9+1
               BCC ncu2
               LDA #&0
ncu2           STA CD2
               BCC PrintCl
               LDA CD3
               ADC #0
               CMP #&5+1
               BCC ncu3
               LDA #&0
ncu3           STA CD3
               BCC PrintCl
               LDA CD4
               ADC #0
               CMP #&9+1
               BCC ncu4
               LDA #&0
ncu4           STA CD4
               BCC PrintCl
               LDA CD5
               ADC #0
               CMP #&5+1
               BCC ncu5
               LDA #&0
ncu5           STA CD5
PrintCl        LDX #1
PCL            LDA CD5,X 
               STA TIMER,X 
               LDA CD3,X 
               STA TIMER+3,X 
               LDA CD1,X 
               STA TIMER+6,X 
               DEX 
               BPL PCL
               LDA #&-
               STA TIMER+2
               STA TIMER+5
udc2           RTS 

CD5            DFS 1
CD4            DFS 1
CD3            DFS 1
CD2            DFS 1
CD1            DFS 1
CD0            DFS 1
CG             DFS 1
ClkAdd         DFS 1
CREFSP         DFS 2
Refsp          DFS 2
xcstr          DFM "0123456789ABCDEF"

IncRefsp       LDX Refsp
               BEQ DR2
               INX 
               BNE DR1
               INC Refsp+1
               BNE DR1
DecRefsp       LDX Refsp
               DEX 
               BEQ DR2
               LDA #0
               STA Refsp+1
DR1            STX Refsp
DR2            RTS 

FastForward    LDA #0
               STA RF
               LDA #Q
               STA FASTER
Fast1          LDA FASTER
               BEQ Fast2
               JSR FaFo
               DEC FASTER
               JMP Fast1
Fast2          LDX #CH0VALUE*1+CH1VALUE*2+CH2VALUE*4
               STX RF
               RTS 

Delay          LDA #100
               LDX #101
delayloop1     CMP $D012
               BNE delayloop1
delayloop2     CPX $D012
               BNE delayloop2
               DEY 
               BNE delayloop1
Fz             RTS 

InitScreen     LDA #$97
               STA $DD00
               LDX #256
               LDY #15
               STX CREFSP
               STX CREFSP+1
is1            LDA #32
               STA $400,X 
               STA $500,X 
               STA $600,X 
               STA $700,X 
               TYA 
               STA $D800,X 
               STA $D900,X 
               STA $DA00,X 
               STA $DB00,X 
               DEX 
               BNE is1
               LDX #$0002
               LDA #$DD
is2            STA $0000,X 
               INX 
               BNE is2
               LDX #refsp
               STX Refsp
               LDY ^refsp
               STY Refsp+1
               JSR PrintCl
               LDA #0
               STA BDR
               RTS 

RefScreen1     LDA #DREFCOLOUR
               STA BDR
               LDX #32-1
sh3            LDA IDRT,X 
               STA ROW24,X 
               DEX 
               BPL sh3
               LDX #2
               DFB $A9
RF             DFB $DF
sh5            LSR A
               PHA 
               BCC sh6
               LDA #&Y
               DFL $2C
sh6            LDA #&N
               STA YYY,X 
               PLA 
               DEX 
               BPL sh5
               LDX #&0
               LDA Refsp+1
               BEQ sh10
               INX 
sh10           STX SPEED
               LDA Refsp
               TAY 
               LSR 
               LSR 
               LSR 
               LSR 
               TAX 
               LDA xcstr,X 
               STA SPEED+1
               TYA 
               AND #15
               TAX 
               LDA xcstr,X 
               STA SPEED+2
               LDX #ZPSIZE
sh1            LDA ZERO0,X 
               STA ROW0,X 
               DEX 
               BPL sh1
               LDA #0
               STA BDR
               RTS 

RefScreen2     LDA #DREFCOLOUR
               STA BDR
               LDX #D2-D1-1
sh2            LDA D0,X 
               STA ROW3,X 
               LDA D1,X 
               STA ROW6,X 
               LDA D2,X 
               STA ROW9,X 
               DEX 
               BPL sh2
               LDA #0
               STA BDR
               RTS 

RefScreen3     LDA #DREFCOLOUR
               STA BDR
               LDX #S1-S0-1
sh4            LDA S0,X 
               STA ROW15,X 
               LDA S1,X 
               STA ROW17,X 
               LDA S2,X 
               STA ROW19,X 
               DEX 
               BPL sh4
               LDA #0
               STA BDR
               RTS 

RefScreen4     LDA #DREFCOLOUR
               STA BDR
               LDA FilterChannel
               STA ROW24+33
               LDX #5
sh7            LDA MFL0,X 
               STA ROW24+34,X 
               DEX 
               BPL sh7
               LDX #21
sh8            LDA CUT,X 
               STA ROW21,X 
               DEX 
               BPL sh8
               LDX #15
sh9            LDA CUTST,X 
               STA ROW12,X 
               DEX 
               BPL sh9
               LDA #0
               STA BDR
               RTS 

 ;    Keyscan Routines (this whole bit is by Chrix on 21/4/87)

kswk0          DFS 1
kswk1          DFS 1
kswk2          DFS 1
ksboing        DFS 1
kslastk        DFS 1
ksdcount       DFS 1
ksscount       DFS 1

InitKeyScan    LDA #0
               STA ksboing
               RTS 

KeyScan        LDX #255
               STX $DC02
               INX 
               STX $DC03
               STX kswk0
               INX 
               LDA #127
               STA kswk2
               LDA #8
               STA kswk1
ks0            LDA kswk2
               STA $DC00
               LDA $DC01
               LDY #8
ks1            ASL 
               BCS ks2
               STX kswk0
ks2            INX 
               DEY 
               BNE ks1
               SEC 
               ROR kswk2
               DEC kswk1
               BNE ks0
               LDY kswk0
               LDA kstable,Y 
               CMP ksboing
               BEQ ks4
               STA ksboing
               LDY #ksdelay
               STY ksdcount
               LDY #ksspeed
               STY ksscount
               BNE ks6
ks3            DEC ksscount
               BNE ks5
               LDY #ksspeed
               STY ksscount
               BNE ks6
ks4            LDY ksdcount
               BEQ ks3
               DEC ksdcount
ks5            LDA #0
ks6            STA kslastk
               RTS  ;A=Ascii value, 0 if no key pressed (& Z=1)

ksdelay        EQU 10
ksspeed        EQU 1

kstable        DFB 0
               DFB 3,81,0,32,50,0,95,49,47,94,61,0,19,59,42,92
               DFB 44,64,58,46,45,76,80,43,78,79,75,77,48,74,73,57
               DFB 86,85,72,66,56,71,89,55,88,84,70,67,54,68,82,53
               DFB 0,69,83,90,52,65,87,51,17,135,134,133,136,29,13,20

 ;=======================*******************************========================
 ;=======================*=== END OF DRIVER PROGRAM ===*========================
 ;=======================*******************************========================
























SP ;=====================********************************=======================
 ;=======================*=== START OF MUSIC PROGRAM ===*=======================
 ;=======================********************************=======================


               ORG $4600

JUMPS ;         JMP INITSOUND:JMP SOUNDTEST:JMP TUNE:JMP MUSICTEST:JMP FILTER
 ;             JMP SOUND0:JMP SOUND1:JMP SOUND2:JMP MUSIC0:JMP MUSIC1:JMP MUSIC2

vt0            DFW retsubrut0
               DFW call0
               DFW goto0
               DFW callt0
               DFW gotot0
               DFW mpoke0
               DFW for0
               DFW next0
               DFW fload0
               DFW volume0
               DFW spoke0
               DFW code0
               DFW transp0
               DFW dmpoke0
               DFW dspoke0
               DFW master0
               DFW filter0
               DFW disown0
               DFW mbendoff0
               DFW mbendon0
               DFW freq0

vt1            DFW retsubrut1
               DFW call1
               DFW goto1
               DFW callt1
               DFW gotot1
               DFW mpoke1
               DFW for1
               DFW next1
               DFW fload1
               DFW volume1
               DFW spoke1
               DFW code1
               DFW transp1
               DFW dmpoke1
               DFW dspoke1
               DFW HANG1 ;master1
               DFW HANG1 ;filter1
               DFW HANG1 ;disown1
               DFW mbendoff1
               DFW HANG1 ;mbendon1
               DFW freq1

vt2            DFW retsubrut2
               DFW call2
               DFW goto2
               DFW callt2
               DFW HANG2 ;gotot2
               DFW mpoke2
               DFW for2
               DFW next2
               DFW fload2
               DFW volume2
               DFW spoke2
               DFW code2
               DFW transp2
               DFW dmpoke2
               DFW dspoke2
               DFW master2
               DFW filter2
               DFW disown2
               DFW HANG2 ;mbendoff2
               DFW HANG2 ;mbendon2
               DFW freq2
               DFW time2

ST ;============================================================================

D1             DFS 29
S0             DFS 35
S1             DFS 35
IDRT           DFS 32
ST1C           DFS DEPTHOFSTACKS
ST2L           DFS DEPTHOFSTACKS
ST2H           DFS DEPTHOFSTACKS
ST2C           DFS DEPTHOFSTACKS
DTAB           DFL D0-D0,D1-D0,D2-D0
LoFrq          DFL N00,N01,N02,N03,N04,N05,N06,N07,N08,N09
               DFL N10,N11,N12,N13,N14,N15,N16,N17,N18,N19
               DFL N20,N21,N22,N23,N24,N25,N26,N27,N28,N29
               DFL N30,N31,N32,N33,N34,N35,N36,N37,N38,N39
               DFL N40,N41,N42,N43,N44,N45,N46,N47,N48,N49
               DFL N50,N51,N52,N53,N54,N55,N56,N57,N58,N59
               DFL N60,N61,N62,N63,N64,N65,N66,N67,N68,N69
               DFL N70,N71,N72,N73,N74,N75,N76,N77,N78,N79
               DFL N80,N81,N82,N83,N84,N85,N86,N87,N88,N89
;               DFL N90,N91,N92,N93
               DFL NSil
HiFrq          DFH N00,N01,N02,N03,N04,N05,N06,N07,N08,N09
               DFH N10,N11,N12,N13,N14,N15,N16,N17,N18,N19
               DFH N20,N21,N22,N23,N24,N25,N26,N27,N28,N29
               DFH N30,N31,N32,N33,N34,N35,N36,N37,N38,N39
               DFH N40,N41,N42,N43,N44,N45,N46,N47,N48,N49
               DFH N50,N51,N52,N53,N54,N55,N56,N57,N58,N59
               DFH N60,N61,N62,N63,N64,N65,N66,N67,N68,N69
               DFH N70,N71,N72,N73,N74,N75,N76,N77,N78,N79
               DFH N80,N81,N82,N83,N84,N85,N86,N87,N88,N89
;               DFH N90,N91,N92,N93
               DFL NSil

 ;==============================================================================

INITSOUND      JSR ResetCl ;\
               LDX #$17
ResetLoop      LDA #8
               STA $D400,X 
               LDA #0
               STA $D400,X 
               DEX 
               BPL ResetLoop
               STA S0+VRC
               STA S1+VRC
               STA S2+VRC
               STA CUT+FMC
               STA MFL0
               STA MFL1
               STA MFL2
               STX FilterChannel
               RTS 

TUNE           LDA TUNETABLE+1,Y 
               STA CalcDurations+1
               LDX #2
               STX channel
               LDX #4
               STX offset
               DEY 
get.tune.data  LDX offset
               LDA TUNETABLE,Y 
               STA PC0,X 
               LDA TUNETABLE+1,Y 
               STA PC0+1,X 
               STY OUT
               LDX channel
               LDY DTAB,X 
               LDA #0
               STA TR0,X 
               STA D0+FMC,Y 
               STA D0+PMC,Y 
               LDA #DEPTHOFSTACKS-1
               STA SP0,X 
               LDA #1
               STA CLOCK0,X 
               STA MFL0,X 
               LDY OUT
               DEY 
               DEY 
               DEC offset
               DEC offset
               DEC channel
               BPL get.tune.data
NewDurations   CLC 
               LDA #0
CalcDurations  ADC #$DD
               STA IDRT,X 
               INX 
               CPX #32
               BCC CalcDurations
               RTS 

transferpm0    LDX S0+PINIT
               LDY S0+PINIT+1
transferpm0a   STX S0PCURR
               STY S0PCURR+1
               LDA S0+CPMD0
               STA S0+PMD0C
               LDA S0+CPMD1
               STA S0+PMD1C
               RTS 
transferpm1    LDX S1+PINIT
               LDY S1+PINIT+1
transferpm1a   STX S1PCURR
               STY S1PCURR+1
               LDA S1+CPMD0
               STA S1+PMD0C
               LDA S1+CPMD1
               STA S1+PMD1C
               RTS 
transferpm2    LDX S2+PINIT
               LDY S2+PINIT+1
transferpm2a   STX S2PCURR
               STY S2PCURR+1
               LDA S2+CPMD0
               STA S2+PMD0C
               LDA S2+CPMD1
               STA S2+PMD1C
               RTS 
transfercf     LDX CUT+14
               LDY CUT+15
               STX CUT+16
               STY CUT+17
transfercfa    LDA CUT+8
               STA CUT+18
               LDA CUT+9
               STA CUT+19
               LDA CUT+10
               STA CUT+20
               LDA CUT+11
               STA CUT+21
               RTS 

transferf0     LDX S0+FINIT
               LDY S0+FINIT+1
               STX S0FCURR
               STY S0FCURR+1
transferf0a    LDA S0+CFMD3
               STA S0+FMD3C
               LDA S0+CFMD2
               STA S0+FMD2C
               LDA S0+CFMD1
               STA S0+FMD1C
               LDA S0+CFMD0
               STA S0+FMD0C
               RTS 
transferf1     LDX S1+FINIT
               LDY S1+FINIT+1
               STX S1FCURR
               STY S1FCURR+1
transferf1a    LDA S1+CFMD3
               STA S1+FMD3C
               LDA S1+CFMD2
               STA S1+FMD2C
               LDA S1+CFMD1
               STA S1+FMD1C
               LDA S1+CFMD0
               STA S1+FMD0C
               RTS 
transferf2     LDX S2+FINIT
               LDY S2+FINIT+1
               STX S2FCURR
               STY S2FCURR+1
transferf2a    LDA S2+CFMD3
               STA S2+FMD3C
               LDA S2+CFMD2
               STA S2+FMD2C
               LDA S2+CFMD1
               STA S2+FMD1C
               LDA S2+CFMD0
               STA S2+FMD0C
               RTS 

 ;=========================*=== MUSIC CONTROL ===*==============================

MC0
callt0         STA TR0
               INY 
               LDA #4
               DFB $2C
call0          LDA #3
               LDX SP0
               ADC PC0
               STA ST0L,X 
               LDA #0
               ADC PC0+1
               STA ST0H,X 
               DEC SP0
               LDA (PC0),Y 
               TAX 
               INY 
               LDA (PC0),Y 
               STX PC0
               STA PC0+1
               JMP read.byte0
code0          LDA ^add3c0-1
               PHA 
               LDA #add3c0-1
               PHA 
               LDA (PC0),Y 
               STA IN
               INY 
               LDA (PC0),Y 
               STA IN+1
               JMP (IN)
dmpoke0        TAX 
               INY 
               LDA (PC0),Y 
               STA D0,X 
               INY 
               LDA (PC0),Y 
               STA D0+1,X 
               LDA #4
               JMP addc0
dspoke0        TAX 
               INY 
               LDA (PC0),Y 
               STA S0,X 
               INY 
               LDA (PC0),Y 
               STA S0+1,X 
               LDA #4
               JMP addc0
filter0        STA filt0loop+1
               INY 
               LDA (PC0),Y 
               STA filt0loop+2
               LDX #15
filt0loop      LDA $DDDD,X 
               STA CUTST,X 
               DEX 
               BPL filt0loop
               JMP add3c0
fload0         TAX 
               INY 
               LDA (PC0),Y 
               STA fload0loop+1
               INY 
               LDA (PC0),Y 
               STA fload0loop+2
fload0loop     LDA $DDDD,X 
               STA D0,X 
               DEX 
               BPL fload0loop
               LDA #4
               JMP addc0
for0           LDX SP0
               LDA #2
               ADC PC0
               STA ST0L,X 
               LDA #0
               ADC PC0+1
               STA ST0H,X 
               LDA (PC0),Y 
               STA ST0C,X 
               DEC SP0
               LDA #2
               JMP addc0
freq0          STA frqpoke0+1
               INY 
               LDA (PC0),Y 
               STA frqpoke0+2
               LDX #13
frqpoke0       LDA $DDDD,X 
               STA D0,X 
               DEX 
               BPL frqpoke0
               JMP add3c0
gotot0         STA TR0
               INY 
goto0          LDA (PC0),Y 
               TAX 
               INY 
               LDA (PC0),Y 
               STX PC0
               STA PC0+1
               JMP read.byte0
disown0        DEY 
               STY CUT+FMC
               LDX #3
               LDY #%11110000
               DFB $2C
master0a       LDY #%11110001
               STY $D417
master0b       STX FilterChannel
               LDA #$1F
               STA $D418
               LDA #1
               JMP addc0
 ;own0          LDX #0:BNE master0b
master0        LDX #0
               BEQ master0a
mbendon0       LDA #7
               DFB $2C
mbendoff0      LDA #5
               STA D0+FMC
               TYA 
               JMP addc0
mpoke0         TAX 
               INY 
               LDA (PC0),Y 
               STA D0,X 
               JMP add3c0
next0          LDX SP0
               DEC ST0C+1,X 
               BEQ n0a
               LDY ST0L+1,X 
               LDA ST0H+1,X 
               STY PC0
               STA PC0+1
               JMP read.byte0
n0a            INC SP0
               TYA 
               JMP addc0
retsubrut0     LDY SP0
               CPY #DEPTHOFSTACKS-1
               BEQ rc0
               INC SP0
               LDX ST0L+1,Y 
               LDA ST0H+1,Y 
               STX PC0
               STA PC0+1
               JMP read.byte0
rc0            DEC MFL0
               RTS 
spoke0         TAX 
               INY 
               LDA (PC0),Y 
               STA S0,X 
               JMP add3c0
transp0        STA TR0
               LDA #2
               JMP addc0
volume0        STA IN
               INY 
               LDA (PC0),Y 
               STA IN+1
               LDY #4
vo0            LDA (IN),Y 
               STA D0+VWF,Y 
               DEY 
               BPL vo0
               JMP add3c0

MC1
callt1         STA TR1
               INY 
               LDA #4
               DFB $2C
call1          LDA #3
               LDX SP1
               ADC PC1
               STA ST1L,X 
               LDA #0
               ADC PC1+1
               STA ST1H,X 
               DEC SP1
               LDA (PC1),Y 
               TAX 
               INY 
               LDA (PC1),Y 
               STX PC1
               STA PC1+1
               JMP read.byte1
code1          LDA ^add3c1-1
               PHA 
               LDA #add3c1-1
               PHA 
               LDA (PC1),Y 
               STA IN
               INY 
               LDA (PC1),Y 
               STA IN+1
               JMP (IN)
dmpoke1        TAX 
               INY 
               LDA (PC1),Y 
               STA D1,X 
               INY 
               LDA (PC1),Y 
               STA D1+1,X 
               LDA #4
               JMP addc1
dspoke1        TAX 
               INY 
               LDA (PC1),Y 
               STA S1,X 
               INY 
               LDA (PC1),Y 
               STA S1+1,X 
               LDA #4
               JMP addc1
 ;filter1       LDA (PC1),Y:STA filt1loop+1:INY:LDA (PC1),Y:STA filt1loop+2
 ;              LDX #15
 ;filt1loop     LDA $DDDD,X:STA CUTST,X:DEX:BPL filt1loop:JMP add3c1
fload1         TAX 
               INY 
               LDA (PC1),Y 
               STA fload1loop+1
               INY 
               LDA (PC1),Y 
               STA fload1loop+2
fload1loop     LDA $DDDD,X 
               STA D1,X 
               DEX 
               BPL fload1loop
               LDA #4
               JMP addc1
for1           LDX SP1
               LDA #2
               ADC PC1
               STA ST1L,X 
               LDA #0
               ADC PC1+1
               STA ST1H,X 
               LDA (PC1),Y 
               STA ST1C,X 
               DEC SP1
               LDA #2
               JMP addc1
freq1          STA frqpoke1+1
               INY 
               LDA (PC1),Y 
               STA frqpoke1+2
               LDX #13
frqpoke1       LDA $DDDD,X 
               STA D1,X 
               DEX 
               BPL frqpoke1
               JMP add3c1
gotot1         STA TR1
               INY 
goto1          LDA (PC1),Y 
               TAX 
               INY 
               LDA (PC1),Y 
               STX PC1
               STA PC1+1
               JMP read.byte1
 ;disown1       DEY:STY CUT+FMC:LDX #3:LDY #%11110000:DFB $2C
 ;master1a      LDY #%11110010:STY $D417
 ;master1b      STX FilterChannel:LDA #1:JMP addc1
 ;own1          LDX #1:BNE master1b
 ;master1       LDX #1:BNE master1a
mbendoff1      LDA #5
               DFB $2C
mbendon1       LDA #7
               STA D1+FMC
               TYA 
               JMP addc1
mpoke1         TAX 
               INY 
               LDA (PC1),Y 
               STA D1,X 
               JMP add3c1
next1          LDX SP1
               DEC ST1C+1,X 
               BEQ n1a
               LDY ST1L+1,X 
               LDA ST1H+1,X 
               STY PC1
               STA PC1+1
               JMP read.byte1
n1a            INC SP1
               TYA 
               JMP addc1
retsubrut1     LDY SP1
               CPY #DEPTHOFSTACKS-1
               BEQ rc1
               INC SP1
               LDX ST1L+1,Y 
               LDA ST1H+1,Y 
               STX PC1
               STA PC1+1
               JMP read.byte1
rc1            DEC MFL1
               RTS 
transp1        STA TR1
               LDA #2
               JMP addc1
spoke1         TAX 
               INY 
               LDA (PC1),Y 
               STA S1,X 
               JMP add3c1
volume1        STA IN
               INY 
               LDA (PC1),Y 
               STA IN+1
               LDY #4
vo1            LDA (IN),Y 
               STA D1+VWF,Y 
               DEY 
               BPL vo1
               JMP add3c1

MC2
callt2         STA TR2
               INY 
               LDA #4
               DFB $2C
call2          LDA #3
               LDX SP2
               ADC PC2
               STA ST2L,X 
               LDA #0
               ADC PC2+1
               STA ST2H,X 
               DEC SP2
               LDA (PC2),Y 
               TAX 
               INY 
               LDA (PC2),Y 
               STX PC2
               STA PC2+1
               JMP read.byte2
code2          LDA ^add3c2-1
               PHA 
               LDA #add3c2-1
               PHA 
               LDA (PC2),Y 
               STA IN
               INY 
               LDA (PC2),Y 
               STA IN+1
               JMP (IN)
dmpoke2        TAX 
               INY 
               LDA (PC2),Y 
               STA D2,X 
               INY 
               LDA (PC2),Y 
               STA D2+1,X 
               LDA #4
               JMP addc2
dspoke2        TAX 
               INY 
               LDA (PC2),Y 
               STA S2,X 
               INY 
               LDA (PC2),Y 
               STA S2+1,X 
               LDA #4
               JMP addc2
filter2        STA filt2loop+1
               INY 
               LDA (PC2),Y 
               STA filt2loop+2
               LDX #15
filt2loop      LDA $DDDD,X 
               STA CUTST,X 
               DEX 
               BPL filt2loop
               JMP add3c2
fload2         TAX 
               INY 
               LDA (PC2),Y 
               STA fload2loop+1
               INY 
               LDA (PC2),Y 
               STA fload2loop+2
fload2loop     LDA $DDDD,X 
               STA D2,X 
               DEX 
               BPL fload2loop
               LDA #4
               JMP addc2
for2           LDX SP2
               LDA #2
               ADC PC2
               STA ST2L,X 
               LDA #0
               ADC PC2+1
               STA ST2H,X 
               LDA (PC2),Y 
               STA ST2C,X 
               DEC SP2
               LDA #2
               JMP addc2
freq2          STA frqpoke2+1
               INY 
               LDA (PC2),Y 
               STA frqpoke2+2
               LDX #13
frqpoke2       LDA $DDDD,X 
               STA D2,X 
               DEX 
               BPL frqpoke2
               JMP add3c2
 ;gotot2        LDA (PC2),Y:STA TR2:INY
goto2          LDA (PC2),Y 
               TAX 
               INY 
               LDA (PC2),Y 
               STX PC2
               STA PC2+1
               JMP read.byte2
disown2        DEY 
               STY CUT+FMC
               LDX #3
               LDY #%11110000
               DFB $2C
master2a       LDY #%11110100
               STY $D417
master2b       STX FilterChannel
               LDA #1
               JMP addc2
 ;own2          LDX #2:BNE master2b
master2        LDA #$1F
               STA $D418
               LDX #2
               BNE master2a
 ;mbendoff2     LDA #5:DFB $2C
 ;mbendon2      LDA #7:STA D2+FMC:TYA:JMP addc2
mpoke2         TAX 
               INY 
               LDA (PC2),Y 
               STA D2,X 
               JMP add3c2
next2          LDX SP2
               DEC ST2C+1,X 
               BEQ n2a
               LDY ST2L+1,X 
               LDA ST2H+1,X 
               STY PC2
               STA PC2+1
               JMP read.byte2
n2a            INC SP2
               TYA 
               JMP addc2
retsubrut2     LDY SP2
               CPY #DEPTHOFSTACKS-1
               BEQ rc2
               INC SP2
               LDX ST2L+1,Y 
               LDA ST2H+1,Y 
               STX PC2
               STA PC2+1
               JMP read.byte2
rc2            DEC MFL2
               RTS 
spoke2         TAX 
               INY 
               LDA (PC2),Y 
               STA S2,X 
               JMP add3c2
time2          STA CalcDurations+1
               LDX #0
               JSR NewDurations
               LDA #2
               JMP addc2
transp2        STA TR2
               LDA #2
               JMP addc2
volume2        STA IN
               INY 
               LDA (PC2),Y 
               STA IN+1
               LDY #4
vo2            LDA (IN),Y 
               STA D2+VWF,Y 
               DEY 
               BPL vo2
               JMP add3c2

 ;=====================*=== MUSIC & SOUND REFRESH ===*==========================

FILTER         LDA CUT+FMC
               BEQ cxit
               LDX CUT+16
               LDY CUT+17
               CLC 
               LDA CUT+FMDLY
               BEQ cms0a
               DEC CUT+FMDLY
               LDA CUT+FMC
               AND #2
               BNE cms3a
cxit           RTS 
cms0           CLC 
cms0a          LDA CUT+18
               BEQ cms1
               DEC CUT+18
               TXA 
               ADC CUT+FMG0
               TAX 
               TYA 
               ADC CUT+FMG0+1
               JMP stcTAY
cms1           LDA CUT+19
               BEQ cms2
               DEC CUT+19
               TXA 
               ADC CUT+FMG1
               TAX 
               TYA 
               ADC CUT+FMG1+1
               JMP stcTAY
cms2           LDA CUT+20
               BEQ cms3
               DEC CUT+20
               TXA 
               ADC CUT+FMG2
               TAX 
               TYA 
               ADC CUT+FMG2+1
               JMP stcTAY
cms3           LDA CUT+21
               BEQ cmrep
               DEC CUT+21
cms3a          TXA 
               ADC CUT+FMG3
               TAX 
               TYA 
               ADC CUT+FMG3+1
stcTAY         TAY 
stc            STX CUT+16
               STY CUT+17
pokecutofffrq  TXA 
               AND #7
               STA $D415
               TYA 
               STX FilterByte
               LSR 
               ROR FilterByte
               LSR 
               ROR FilterByte
               LSR 
               LDA FilterByte
               ROR 
               STA $D416
               RTS 
cmrep          LDA CUT+FMC
               AND #%10000001
               BEQ stc
               BPL nocfcopy
               JSR transfercf
               JMP cms0
nocfcopy       JSR transfercfa
               JMP cms0

StartFilter    LDX #7
SFL            LDA CUTST+0,X 
               STA CUT+0,X 
               LDA CUTST+8,X 
               STA CUT+8,X 
               DEX 
               BPL SFL
               JSR transfercf
               JMP pokecutofffrq

MUSIC0         LDA MFL0
               BEQ mx0
               DEC CLOCK0
               BEQ read.byte0
mx0            RTS 
crossedover0a  INC PC0+1
               BNE read.byte0
add3c0         LDA #3
addc0          ADC PC0
               STA PC0
               BCS crossedover0a
read.byte0     LDY #0
               LDA (PC0),Y 
               CMP #COM
               BCC not.control0
               INY 
               ADC #vt0-COM-1
               STA v0+1
               LDA (PC0),Y 
v0             JMP (vt0)
js0            JMP st0
not.control0   STA Z8
               CMP #R
               BCC in.du.re.0
               SBC #R
in.du.re.0     CMP #Rest
               BEQ js0
               ADC TR0
got.note0      TAX 
               LDA RF
               AND #1
               BEQ js0 ;\
NOTE0
 ;              LDA #8:STA $D404
               LDA FilterChannel
               BNE nf0
               STX IN
               JSR StartFilter
               LDX IN
nf0            LDY HiFrq,X 
               LDA LoFrq,X 
               STA S0+FINIT
               STY S0+FINIT+1
               STA $D400
               STY $D401
               LDX D0+PINIT
               LDY D0+PINIT+1
               STX $D402
               STY $D403
               LDA D0+VADV
               STA $D405
               LDA D0+VSRV
               STA $D406
               LDA D0+VWF
               STA S0+VWFG
               AND #%11110111
               STA $D404

               JSR transferpm0a ;LDX #PINIT+1
dll0 ;          LDA D0,X:STA S0,X:DEX:BPL dll0:LDA S0+FMC

dlpw0          LDA D0+PMC
               STA S0+PMC
               BEQ dlfrq0
               STX S0+PINIT
               STY S0+PINIT+1
               STX S0PCURR
               STY S0PCURR+1
               LDA D0+PMG1+1
               STA S0+PMG1+1
               LDA D0+PMG1
               STA S0+PMG1
               LDA D0+PMG0+1
               STA S0+PMG0+1
               LDA D0+PMG0
               STA S0+PMG0
               LDA D0+PMDLY
               STA S0+PMDLY
               LDX D0+PMD0
               LDY D0+PMD1
               STX S0+CPMD0
               STX S0+PMD0C
               STY S0+PMD1C
               STY S0+CPMD1

dlfrq0         LDA D0+FMC
               STA S0+FMC
               BEQ dldur0
               LDX D0+12
               STX S0+12
               LDX D0+11
               STX S0+11
               LDX D0+10
               STX S0+10
               LDX D0+9
               STX S0+9
               LDX D0+8
               STX S0+8
               LDX D0+7
               STX S0+7
               LDX D0+6
               STX S0+6
               LDX D0+5
               STX S0+5
               LDX D0+4
               STX S0+4
               LDX D0+3
               STX S0+3
               LDX D0+2
               STX S0+2
               LDX D0+1
               STX S0+1
               LDX D0+0
               STX S0+0

               AND #8
               BEQ no.of.li.mo0
               LDA Z8
               CMP #R
               BCC in.du.re0a
               SBC #R-1
in.du.re0a     ADC TR0
               STA S0+FOLB
               BNE dldur0
no.of.li.mo0   JSR transferf0
dldur0         LDX D0+VADSD
               LDY D0+VRD
               STX S0+VADSC
               STY S0+VRC
st0            LDY #1
               LDA (PC0),Y 
               LDX Z8
               CPX #R
               BCS di.du.re0
               TAX 
               LDA IDRT-1,X 
di.du.re0      STA CLOCK0
               LDA #2
addn0          ADC PC0
               STA PC0
               BCS crossedover0b
               RTS 
crossedover0b  INC PC0+1
               RTS 

MUSIC1         LDA MFL1
               BEQ mx1
               DEC CLOCK1
               BEQ read.byte1
mx1            RTS 
crossedover1a  INC PC1+1
               BNE read.byte1
add3c1         LDA #3
addc1          ADC PC1
               STA PC1
               BCS crossedover1a
read.byte1     LDY #0
               LDA (PC1),Y 
               CMP #COM
               BCC not.ctrl1
               INY 
               ADC #vt1-COM-1
               STA v1+1
               LDA (PC1),Y 
v1             JMP (vt1)
js1            JMP st1
not.ctrl1      STA Z8
               CMP #R
               BCC in.du.re1
               SBC #R
in.du.re1      CMP #Rest
               BEQ js1
               ADC TR1
got.note1      TAX 
               LDA RF
               AND #2
               BEQ js1 ;\
NOTE1
               LDA #8
               STA $D40B
nf1            LDY HiFrq,X 
               LDA LoFrq,X 
               STA S1+FINIT
               STY S1+FINIT+1
               STA $D407
               STY $D408
               LDX D1+PINIT
               LDY D1+PINIT+1
               STX $D409
               STY $D40A
               LDA D1+VADV
               STA $D40C
               LDA D1+VSRV
               STA $D40D
               LDA D1+VWF
               STA S1+VWFG
               AND #%11110111
               STA $D40B

               JSR transferpm1a ;LDX #PINIT+1
dll1 ;          LDA D1,X:STA S1,X:DEX:BPL dll1:LDA S1+FMC

dlpw1          LDA D1+PMC
               STA S1+PMC
               BEQ dlfrq1
               STX S1+PINIT
               STY S1+PINIT+1
               STX S1PCURR
               STY S1PCURR+1
               LDA D1+PMG1+1
               STA S1+PMG1+1
               LDX D1+PMG1
               STX S1+PMG1
               LDA D1+PMG0+1
               STA S1+PMG0+1
               LDA D1+PMG0
               STA S1+PMG0
               LDA D1+PMDLY
               STA S1+PMDLY
               LDX D1+PMD0
               LDY D1+PMD1
               STX S1+CPMD0
               STX S1+PMD0C
               STY S1+CPMD1
               STY S1+PMD1C

dlfrq1         LDA D1+FMC
               STA S1+FMC
               BEQ dldur1
               LDX D1+12
               STX S1+12
               LDX D1+11
               STX S1+11
               LDX D1+10
               STX S1+10
               LDX D1+9
               STX S1+9
               LDX D1+8
               STX S1+8
               LDX D1+7
               STX S1+7
               LDX D1+6
               STX S1+6
               LDX D1+5
               STX S1+5
               LDX D1+4
               STX S1+4
               LDX D1+3
               STX S1+3
               LDX D1+2
               STX S1+2
               LDX D1+1
               STX S1+1
               LDX D1+0
               STX S1+0

               AND #8
               BEQ no.of.li.mo1
               LDA Z8
               CMP #R
               BCC in.du.re1a
               SBC #R-1
in.du.re1a     ADC TR1
               STA S1+FOLB
               BNE dldur1
no.of.li.mo1   JSR transferf1
dldur1         LDX D1+VADSD
               LDY D1+VRD
               STX S1+VADSC
               STY S1+VRC
st1            LDY #1
               LDA (PC1),Y 
               LDX Z8
               CPX #R
               BCS di.du.re1
               TAX 
               LDA IDRT-1,X 
di.du.re1      STA CLOCK1
               LDA #2
addn1          ADC PC1
               STA PC1
               BCS crossedover1b
               RTS 
crossedover1b  INC PC1+1
               RTS 

MUSIC2         LDA MFL2
               BEQ mx2
               DEC CLOCK2
               BEQ read.byte2
mx2            RTS 
crossedover2a  INC PC2+1
               BNE read.byte2
add3c2         LDA #3
addc2          ADC PC2
               STA PC2
               BCS crossedover2a
read.byte2     LDY #0
               LDA (PC2),Y 
               CMP #COM
               BCC not.ctrl2
               INY 
               ADC #vt2-COM-1
               STA v2+1
               LDA (PC2),Y 
v2             JMP (vt2)
js2            JMP st2
not.ctrl2      STA Z8
               CMP #R
               BCC in.du.re2
               SBC #R
in.du.re2      CMP #Rest
               BEQ js2
               ADC TR2
got.note2      TAX 
               LDA RF
               AND #4
               BEQ js2 ;\
NOTE2
               LDA #8
               STA $D412
ntb2           LDA FilterChannel
               CMP #2
               BNE nf2
               STX IN
               JSR StartFilter
               LDX IN
nf2            LDY HiFrq,X 
               LDA LoFrq,X 
               STA S2+FINIT
               STY S2+FINIT+1
               STA $D40E
               STY $D40F
               LDX D2+PINIT
               LDY D2+PINIT+1
               STX $D410
               STY $D411
               LDA D2+VADV
               STA $D413
               LDA D2+VSRV
               STA $D414
               LDA D2+VWF
               STA S2+VWFG
               AND #%11110111
               STA $D412

               JSR transferpm2a ;LDX #PINIT+1
dll2 ;          LDA D2,X:STA S2,X:DEX:BPL dll2:LDA S2+FMC

dlpw2          LDA D2+PMC
               STA S2+PMC
               BEQ dlfrq2
               STX S2+PINIT
               STY S2+PINIT+1
               STX S2PCURR
               STY S2PCURR+1
               LDA D2+PMG1+1
               STA S2+PMG1+1
               LDA D2+PMG1
               STA S2+PMG1
               LDA D2+PMG0+1
               STA S2+PMG0+1
               LDA D2+PMG0
               STA S2+PMG0
               LDA D2+PMDLY
               STA S2+PMDLY
               LDX D2+PMD0
               LDY D2+PMD1
               STX S2+CPMD0
               STX S2+PMD0C
               STY S2+CPMD1
               STY S2+PMD1C

dlfrq2         LDA D2+FMC
               STA S2+FMC
               BEQ dldur2
               LDX D2+12
               STX S2+12
               LDX D2+11
               STX S2+11
               LDX D2+10
               STX S2+10
               LDX D2+9
               STX S2+9
               LDX D2+8
               STX S2+8
               LDX D2+7
               STX S2+7
               LDX D2+6
               STX S2+6
               LDX D2+5
               STX S2+5
               LDX D2+4
               STX S2+4
               LDX D2+3
               STX S2+3
               LDX D2+2
               STX S2+2
               LDX D2+1
               STX S2+1
               LDX D2+0
               STX S2+0

               AND #8
               BEQ no.of.li.mo2
               LDA Z8
               CMP #R
               BCC in.du.re2a
               SBC #R-1
in.du.re2a     ADC TR2
               STA S2+FOLB
               BNE dldur2
no.of.li.mo2   JSR transferf2
dldur2         LDX D2+VADSD
               LDY D2+VRD
               STX S2+VADSC
               STY S2+VRC
st2            LDY #1
               LDA (PC2),Y 
               LDX Z8
               CPX #R
               BCS di.du.re2
               TAX 
               LDA IDRT-1,X 
di.du.re2      STA CLOCK2
               LDA #2
addn2          ADC PC2
               STA PC2
               BCS crossedover2b
               RTS 
crossedover2b  INC PC2+1
nosound0       RTS 

SOUND0         LDX S0+VRC
               BEQ nosound0
               LDA S0+VWFG
               AND #8
               BEQ adsr0
               LDA CLOCK0
               CMP S0+VADSC
               BCS PM0
               LDA #0
               STA S0+VADSC
               LDA S0+VWFG
               AND #%11110110
               STA S0+VWFG
               BNE trigrel0
adsr0          LDA S0+VADSC
               BNE ad0
               LDY S0+VRC
               INY 
               BEQ PM0
               DEC S0+VRC
               BNE PM0
               LDX #6
cc0            STA $D400,X 
               DEX 
               BPL cc0
CheckFilter    CMP FilterChannel
               BNE nosound0
               INX 
               STX CUT+FMC
               RTS 
ad0            LDY S0+VADSC
               INY 
               BEQ PM0
               DEC S0+VADSC
               BNE PM0
               LDA S0+VWFG
               AND #246
trigrel0       STA $D404
PM0            LDA S0+PMC
               BEQ FM0
               LDA S0+PMDLY
               BEQ pmdel0
               DEC S0+PMDLY
               JMP FM0
pmdel0         CLC 
               LDX S0PCURR
               LDY S0PCURR+1
pms00          LDA S0+PMD0C
               BEQ pms10
               DEC S0+PMD0C
               TXA 
               ADC S0+PMG0
               TAX 
               TYA 
               ADC S0+PMG0+1
               TAY 
               JMP stpm0
pms10          LDA S0+PMD1C
               BEQ pmrep0
               DEC S0+PMD1C
               TXA 
               ADC S0+PMG1
               TAX 
               TYA 
               ADC S0+PMG1+1
               TAY 
               JMP stpm0
pmrep0         LDA S0+PMC
               AND #$81
               BEQ stpm0
               BPL nopmcopy0
               JSR transferpm0
               JMP pmdel0
nopmcopy0      JSR transferpm0a
               JMP pmdel0
stpm0          STX S0PCURR
               STY S0PCURR+1
               STX $D402
               STY $D403
FM0            LDA S0+FMC
               BEQ xit0
               AND #8
               BNE olm0 ;]
               LDX S0FCURR
               LDY S0FCURR+1
               CLC 
               LDA S0+FMDLY
               BEQ fcs10+1
               DEC S0+FMDLY
               LDA S0+FMC
               AND #2
               BNE fcs40l1
xit0           RTS 
olm0           DEC S0+FOLDC
               BNE xit0
               LDY S0+FOLOD
               STY S0+FOLDC
               LDY S0+FOLCI ;]
               BPL no0
               LDY S0+FOLII
no0            LDX S0+FOLA
               STX IN
               LDX S0+FOLA+1
               STX IN+1
               LDA S0+FOLB
               ADC (IN),Y 
               DEY 
               STY S0+FOLCI
               TAY 
POKEFRQ0       LDX LoFrq,Y 
               LDA HiFrq,Y 
               STX $D400
               STA $D401
               RTS 
fcs10          CLC 
               LDA S0+FMD0C
               BEQ fcs20
               DEC S0+FMD0C
               TXA 
               ADC S0+FMG0
               TAX 
               TYA 
               ADC S0+FMG0+1
               JMP stf0TAY
fcs20          LDA S0+FMD1C
               BEQ fcs30
               DEC S0+FMD1C
               TXA 
               ADC S0+FMG1
               TAX 
               TYA 
               ADC S0+FMG1+1
               JMP stf0TAY
fcs30          LDA S0+FMD2C
               BEQ fcs40
               DEC S0+FMD2C
               TXA 
               ADC S0+FMG2
               TAX 
               TYA 
               ADC S0+FMG2+1
               JMP stf0TAY
fcs40          LDA S0+FMD3C
               BEQ fcrep0
               DEC S0+FMD3C
fcs40l1        TXA 
               ADC S0+FMG3
               TAX 
               TYA 
               ADC S0+FMG3+1
stf0TAY        TAY 
stf0           STX $D400
               STY $D401
               STX S0FCURR
               STY S0FCURR+1
nosound1       RTS 
fcrep0         LDA S0+FMC
               AND #$81
               BEQ stf0
               BPL nofrqcopy0
               JSR transferf0
               JMP fcs10
nofrqcopy0     JSR transferf0a
               JMP fcs10

SOUND1         LDX S1+VRC
               BEQ nosound1
               LDA S1+VWFG
               AND #8
               BEQ adsr1
               LDA CLOCK1
               CMP S1+VADSC
               BCS PM1
               LDA #0
               STA S1+VADSC
               LDA S1+VWFG
               AND #%11110110
               STA S1+VWFG
               BNE trigrel1
adsr1          LDA S1+VADSC
               BNE ad1
               LDY S1+VRC
               INY 
               BEQ PM1
               DEC S1+VRC
               BNE PM1
               LDX #6
cc1            STA $D407,X 
               DEX 
               BPL cc1
               RTS 
ad1            LDY S1+VADSC
               INY 
               BEQ PM1
               DEC S1+VADSC
               BNE PM1
               LDA S1+VWFG
               AND #246
trigrel1       STA $D40B
PM1            LDA S1+PMC
               BEQ FM1
               LDA S1+PMDLY
               BEQ pmdel1
               DEC S1+PMDLY
               JMP FM1
pmdel1         CLC 
               LDX S1PCURR
               LDY S1PCURR+1
pms01          LDA S1+PMD0C
               BEQ pms11
               TXA 
               ADC S1+PMG0
               TAX 
               TYA 
               ADC S1+PMG0+1
               TAY 
               DEC S1+PMD0C
               JMP stpm1
pms11          LDA S1+PMD1C
               BEQ pmrep1
               TXA 
               ADC S1+PMG1
               TAX 
               TYA 
               ADC S1+PMG1+1
               TAY 
               DEC S1+PMD1C
               JMP stpm1
pmrep1         LDA S1+PMC
               AND #$81
               BEQ stpm1
               BPL nopmcopy1
               JSR transferpm1
               JMP pmdel1
nopmcopy1      JSR transferpm1a
               JMP pmdel1
stpm1          STX S1PCURR
               STY S1PCURR+1
               STX $D409
               STY $D40A
FM1            LDA S1+FMC
               BEQ xit1
               AND #8
               BNE olm1 ;]
               LDX S1FCURR
               LDY S1FCURR+1
               CLC 
               LDA S1+FMDLY
               BEQ fcs11+1
               DEC S1+FMDLY
               LDA S1+FMC
               AND #2
               BNE fcs41l1
xit1           RTS 
olm1           DEC S1+FOLDC
               BNE xit1
               LDY S1+FOLOD
               STY S1+FOLDC
               LDY S1+FOLCI ;]
               BPL no1
               LDY S1+FOLII
no1            LDX S1+FOLA
               STX IN
               LDX S1+FOLA+1
               STX IN+1
               LDA S1+FOLB
               ADC (IN),Y 
               DEY 
               STY S1+FOLCI
               TAY 
POKEFRQ1       LDX LoFrq,Y 
               LDA HiFrq,Y 
               STX $D407
               STA $D408
               RTS 
fcs11          CLC 
               LDA S1+FMD0C
               BEQ fcs21
               DEC S1+FMD0C
               TXA 
               ADC S1+FMG0
               TAX 
               TYA 
               ADC S1+FMG0+1
               JMP stf1TAY
fcs21          LDA S1+FMD1C
               BEQ fcs31
               DEC S1+FMD1C
               TXA 
               ADC S1+FMG1
               TAX 
               TYA 
               ADC S1+FMG1+1
               JMP stf1TAY
fcs31          LDA S1+FMD2C
               BEQ fcs41
               DEC S1+FMD2C
               TXA 
               ADC S1+FMG2
               TAX 
               TYA 
               ADC S1+FMG2+1
               JMP stf1TAY
fcs41          LDA S1+FMD3C
               BEQ fcrep1
               DEC S1+FMD3C
fcs41l1        TXA 
               ADC S1+FMG3
               TAX 
               TYA 
               ADC S1+FMG3+1
stf1TAY        TAY 
stf1           STX $D407
               STY $D408
               STX S1FCURR
               STY S1FCURR+1
nosound2       RTS 
fcrep1         LDA S1+FMC
               AND #$81
               BEQ stf1
               BPL nofrqcopy1
               JSR transferf1
               JMP fcs11
nofrqcopy1     JSR transferf1a
               JMP fcs11

SOUND2         LDX S2+VRC
               BEQ nosound2
               LDA S2+VWFG
               AND #8
               BEQ adsr2
               LDA CLOCK2
               CMP S2+VADSC
               BCS PM2
               LDA #0
               STA S2+VADSC
               LDA S2+VWFG
               AND #%11110110
               STA S2+VWFG
               BNE trigrel2
adsr2          LDA S2+VADSC
               BNE ad2
               LDY S2+VRC
               INY 
               BEQ PM2
               DEC S2+VRC
               BNE PM2
               LDX #6
cc2            STA $D40E,X 
               DEX 
               BPL cc2
               LDA #2
               JMP CheckFilter
ad2            LDY S2+VADSC
               INY 
               BEQ PM2
               DEC S2+VADSC
               BNE PM2
               LDA S2+VWFG
               AND #246
trigrel2       STA $D412
PM2            LDA S2+PMC
               BEQ FM2
               LDA S2+PMDLY
               BEQ pmdel2
               DEC S2+PMDLY
               JMP FM2
pmdel2         CLC 
               LDX S2PCURR
               LDY S2PCURR+1
pms02          LDA S2+PMD0C
               BEQ pms12
               DEC S2+PMD0C
               TXA 
               ADC S2+PMG0
               TAX 
               TYA 
               ADC S2+PMG0+1
               TAY 
               JMP stpm2
pms12          LDA S2+PMD1C
               BEQ pmrep2
               DEC S2+PMD1C
               TXA 
               ADC S2+PMG1
               TAX 
               TYA 
               ADC S2+PMG1+1
               TAY 
               JMP stpm2
pmrep2         LDA S2+PMC
               AND #$81
               BEQ stpm2
               BPL nopmcopy2
               JSR transferpm2
               JMP pmdel2
nopmcopy2      JSR transferpm2a
               JMP pmdel2
stpm2          STX S2PCURR
               STY S2PCURR+1
               STX $D410
               STY $D411
FM2            LDA S2+FMC
               BEQ xit2
               AND #8
               BNE olm2 ;]
               LDX S2FCURR
               LDY S2FCURR+1
               CLC 
               LDA S2+FMDLY
               BEQ fcs12+1
               DEC S2+FMDLY
               LDA S2+FMC
               AND #2
               BNE fcs42l1
xit2           RTS 
olm2           DEC S2+FOLDC
               BNE xit2
               LDY S2+FOLOD
               STY S2+FOLDC
               LDY S2+FOLCI ;]
               BPL no2
               LDY S2+FOLII
no2            LDX S2+FOLA
               STX IN
               LDX S2+FOLA+1
               STX IN+1
               LDA S2+FOLB
               ADC (IN),Y 
               DEY 
               STY S2+FOLCI
               TAY 
POKEFRQ2       LDX LoFrq,Y 
               LDA HiFrq,Y 
               STX $D40E
               STA $D40F
               RTS 
fcs12          CLC 
               LDA S2+FMD0C
               BEQ fcs22
               DEC S2+FMD0C
               TXA 
               ADC S2+FMG0
               TAX 
               TYA 
               ADC S2+FMG0+1
               JMP stf2TAY
fcs22          LDA S2+FMD1C
               BEQ fcs32
               DEC S2+FMD1C
               TXA 
               ADC S2+FMG1
               TAX 
               TYA 
               ADC S2+FMG1+1
               JMP stf2TAY
fcs32          LDA S2+FMD2C
               BEQ fcs42
               DEC S2+FMD2C
               TXA 
               ADC S2+FMG2
               TAX 
               TYA 
               ADC S2+FMG2+1
               JMP stf2TAY
fcs42          LDA S2+FMD3C
               BEQ fcrep2
               DEC S2+FMD3C
fcs42l1        TXA 
               ADC S2+FMG3
               TAX 
               TYA 
               ADC S2+FMG3+1
stf2TAY        TAY 
stf2           STX $D40E
               STY $D40F
               STX S2FCURR
               STY S2FCURR+1
               RTS 
fcrep2         LDA S2+FMC
               AND #$81
               BEQ stf2
               BPL nofrqcopy2
               JSR transferf2
               JMP fcs12
nofrqcopy2     JSR transferf2a
               JMP fcs12

SOUNDTEST      LDA MFL0
               ORA MFL1
               ORA MFL2
               ORA S0+VRC
               ORA S1+VRC
               ORA S2+VRC
               RTS 

MUSICTEST      LDA MFL2
               RTS 

EP ;======================******************************========================
 ;========================*=== END OF MUSIC PROGRAM ===*========================
 ;========================******************************========================
























SD ;=======================********************=================================
 ;=========================*=== MUSIC DATA ===*=================================
 ;=========================********************=================================

TUNETABLE      DFW Texit,Texit,FILTH
               DFL 4
               DFW BONUS0,BONUS1,BONUS2
               DFL 6
               DFW ENDOFLEVEL0,ENDOFLEVEL1,ENDOFLEVEL2
               DFL 7
               DFW TITLE0,TITLE1,TITLE2
               DFL 5
               DFW Texit,Texit,BBASS2
               DFL 2
               DFW GETREADY0,GETREADY1,GETREADY2
               DFL 5
               DFW INPUTNAME1,INPUTNAME0,INPUTNAME2
               DFL 9
               DFW OVER0,OVER1,OVER2
               DFL 2
               DFW LABORATORY0,LABORATORY1,LABORATORY2
               DFL 8
               DFW Texit,Texit,ENDOFBONUS2
			   DFL 5

 ;========================== INPUT NAME MUSIC DATA =============================

eD00           DFW +12,-12,+12,0
               DFL 10,20,10,0,50,5
               DFS 8,0
               DFW $0800
               DFL 73,$19,$89,20,255
eD01           DFW +17,-17,+17,0
               DFL 10,20,10,0,100,5
               DFL 70,1,0,0
               DFW +22,-1540,$0500
eV01           DFL %00100001,$CD,$0F,255,200
eF02           DFW -10,0,0,0
               DFL 255,0,0,0,90,4
eV02           DFL %00101001,$5A,$CB,20,200
eF03           DFW +12,-12,+12,+13
               DFL 10,20,10,0,40,7
eV03           DFL 33,$16,$87,20,10
eD04           DFS 14,0
               DFS 10,0
               DFL 137,$03,$27,25,10
eS00           DFL FLoad,VRC
               DFW eD01
               DFL 57,24,Rest,24,Rest,16,55,24,Rest,24,Rest,16,54,24,Rest,24
               DFL Vlm
               DFW eV02
               DFL 58,5,59,5,61,6
               DFL Vlm
               DFW eV01
               DFL 62,16,For,3,Rest,16,Next
               DFL 62,16,65,16,64,16,69,5,65,5,62,6
               DFL Moke,VADV,$BD
               DFL 64,16,Rest,8,62,8
               DFL Moke,VADV,$CD
               DFL 61,16,Freq
               DFW eF02
               DFL 59,16
               DFL Freq
               DFW eD01
               DFL 56,24,54,8,52,16,54,7
               DFL Soke,FMC,7
               DFL DSoke,FBG
               DFW +21
               DFL Rest,4
               DFL DSoke,FBG
               DFW +0
               DFL Rest,5
               DFL 54,16,Ret
eS02           DFL 0,4,0,4,0,8,0,8,0,4,0,8,0,8,0,4,0,16,Ret

W              EQU 60 ;                                pitch of lower wood block

INPUTNAME0     DFL FLoad,VRC
               DFW eD11
               DFL For,2,Rest,8,80,8,80,16,80,12,80,12,80,8,Next
               DFL For,9,Rest,4,W,2,W,2,86,8,86,8,W,4,W,4,86,4,W,4,W,4,86,8,W,4
               DFL 86,8,Next
               DFL Call
               DFW eS00
               DFL For,2
               DFL For,7,Rest,16,Next
               DFL FLoad,VRC
               DFW eD00
               DFL Rest,12
               DFL 52,4,57,4,59,8,61,8,62,8,61,8,59,4,57,8,59,4
               DFL Moke,VSRV,$8D,55,24,Rest,24,Moke,VSRV,$89
               DFL Rest,24
               DFL 54,4,58,4,59,8,61,8,62,8,64,8,62,4,61,4
               DFL Moke,VSRV,$8D,62,24,Rest,24,Moke,VSRV,$89
               DFL FLoad,FMC
               DFW eD20
               DFL Rest,16,Rest,16
               DFL 50,4,53,4,57,8,62,8,64,8,65,8,64,4,62,8,61,4,57,8
               DFL Moke,VSRV,$8D,52,16,Rest,24,Moke,VSRV,$89,Rest,4
               DFL 52,4,54,4,56,8,57,4,59,8,61,8,62,8,64,8
               DFL Freq
               DFW eF03
               DFL 60,8
               DFL Freq
               DFW eD00
               DFL 59,12
               DFL Moke,VSRV,$8D,57,16
               DFL Next
               DFL FLoad,PINIT+1
               DFW eD10
               DFL Vlm
               DFW eV03
               DFL For,15,Rest,8,Next
               DFL CT,+45
               DFW eS02
               DFL DMoke,FOLA
               DFW eL11
               DFL CT,+43
               DFW eS02
               DFL DMoke,FOLA
               DFW eL12
               DFL CT,+42
               DFW eS02
               DFL DMoke,FOLA
               DFW eL13
               DFL CT,+47
               DFW eS02
               DFL CT,+38
               DFW eS02
               DFL DMoke,FOLA
               DFW eL10
               DFL 7,12,7,12
               DFL DMoke,FOLA
               DFW eL13
               DFL 4,12,4,12,4,12
               DFL DMoke,FOLA
               DFW eL12
               DFL CT,+40
               DFW eS02
               DFL DMoke,FOLA
               DFW eL14
               DFL CT,+45
               DFW eS02
               DFL 0,4,0,4,0,8,0,8,0,4,0,8,0,8,0,4,0,12
               DFL JT,+0
               DFW INPUTNAME0

eD10           DFW 0,0,1,4,eL10
               DFL 0,5,0,8
               DFS 10,0
               DFL 33,$18,$6A,30,150
eD11           DFW +1200,0,0,0
               DFL 255,0,0,0,0,4
               DFS 10,0
               DFL 17,$00,$F2,5,6
eL10           DFL 0,4,7,12,24,12 ;                 major root
eL11           DFL 0,4,9,12,24,12
eL12           DFL 0,4,10,12,24,12 ;                7th root
eL13           DFL 0,3,7,12,24,12 ;                 minor root
eL14           DFL 0,4,7,9,24,12 ;                  6th root
eS10           DFL DMoke,FOLA
               DFW eL12
               DFL Rest,4
               DFL For,5,42,12,Next,Ret

INPUTNAME1     DFL Rest,4
INPUTNAME1Loo  DFL FLoad,VRC
               DFW eD04
               DFL 89,4,89,4,89,4
               DFL For,7,89,8,89,4,89,4,Next
               DFL FLoad,VRC
               DFW eD10
               DFL Rest,4
               DFL For,5
               DFL Rest,4
               DFL For,5,45,12,Next
               DFL DMoke,FOLA
               DFW eL11
               DFL Rest,4
               DFL For,5,43,12,Next
               DFL Call
               DFW eS10
               DFL DMoke,FOLA
               DFW eL13
               DFL Rest,4
               DFL For,5,47,12,Next
               DFL Rest,4
               DFL For,5,38,12,Next
               DFL DMoke,FOLA
               DFW eL10
               DFL Rest,4
               DFL 45,12,45,12
               DFL DMoke,FOLA
               DFW eL13
               DFL 42,12,42,12,42,12
               DFL CT,-2
               DFW eS10
               DFL DMoke,FOLA
               DFW eL14
               DFL Transp,+0
               DFL For,2,Rest,4
               DFL For,5,45,12,Next,Next
               DFL DMoke,FOLA
               DFW eL10
               DFL Next
               DFL Jmp
               DFW INPUTNAME1Loo

eC20           DFW +10,-10,+10,-10
               DFL 8,16,8,0,50,7
               DFW 900
eD20           DFW +7,-7,+7,0
               DFL 10,20,10,0,40,5
               DFL 120,120,10,5
               DFW +3,-3,$0900
               DFL 73,$18,$6B,15,254
eF20           DFW +6,0,0,0
               DFL 255,0,0,0,40,4
eD21           DFW -10,0,0,0
               DFL 255,0,0,0,25,4
               DFS 8,0
               DFW $0800
               DFL 65,$07,$68,40,40
eS20           DFL 33,12,40,4,40,12,33,4,33,12,40,4,40,8
               DFL Freq
               DFW eF20
               DFL 28,8
               DFL Freq
               DFW eD20
               DFL Ret
eS21           DFL Call
               DFW eS20
               DFL 31,12,40,4,40,12,31,4,31,12,40,4,40,8
               DFL Freq
               DFW eF20
               DFL 28,8
               DFL Freq
               DFW eD20
               DFL 30,12,40,4,40,12,30,4,30,12,40,4,40,8
               DFL Freq
               DFW eF20
               DFL 34,8
               DFL Freq
               DFW eD20
               DFL 35,12,42,4,42,12,35,4,35,12,42,4,42,8,23,4,25,4
               DFL 26,12,33,4,33,12,26,4,26,12,33,4,33,8
               DFL Freq
               DFW eF20
               DFL 28,8
               DFL Freq
               DFW eD20
               DFL 33,12,40,4,40,12,33,4,30,12,37,4,37,8,28,4,30,4
               DFL 28,12,35,4,35,12,28,4,28,12,35,4,35,8,23,4,25,4
               DFL CT,-12
               DFW eS20
               DFL Call
               DFW eS20
               DFL Transp,+0,Ret

INPUTNAME2     DFL FLoad,VRC
               DFW eD21
               DFL Master,Filter
               DFW eC20
               DFL For,4
               DFL DMoke,FMG0
               DFW -3
               DFL 20,12,20,4,20,8
               DFL DMoke,FMG0
               DFW -8
               DFL 35,4,35,4,Next
               DFL FLoad,VRC
               DFW eD20
               DFL For,3
               DFL Call
               DFW eS21
               DFL Next
               DFL Disown
               DFL Call
               DFW eS00
               DFL FLoad,VRC
               DFW eD20
               DFL For,21,Rest,4,Next
               DFL Master
               DFL 40,8,30,8,32,12
               DFL Call
               DFW eS21
               DFL Jmp
               DFW INPUTNAME2

 ;======================== END OF LEVEL MUSIC DATA =============================

XL00           DFL 0,5,3,7,12,0,5,7,3,12,0,7,5,3,12,5
XD00           DFW 0,0,1,5
               DFW XL00
               DFL 0,15,0,8
               DFS 10,0
               DFL 33,$33,$9A,50,50

ENDOFLEVEL2    DFL RestR,2
ENDOFLEVEL1    DFL RestR,2
ENDOFLEVEL0    DFL FLoad,VRC
               DFW XD00
               DFL 60,32,Ret

 ;========================== GET READY JINGLE DATA =============================

RD00           DFW +20000,-39000,+14000,-40000
               DFL 220,220,220,220,0,5
               DFS 8,0
               DFW $0800
               DFL %01000001,$FF,$F0,255,1

GETREADY0      DFL Master,Filter
               DFW TC00
GETREADY0Labe  DFL FLoad,VRC
               DFW RD00
               DFL 50,32
               DFL For,6,Rest,32,Next,Soke,VADSC,1
Texit          DFL Ret

GETREADY1      DFL Rest,1
GETREADY2      DFL Rest,1
               DFL Jmp
               DFW GETREADY0Labe

 ;====================== END OF BONUS LEVEL MUSIC DATA =========================

CfS0           DFL FLoad,VRC
               DFW GD20a
               DFL Master,Filter
               DFW GC20a
               DFL Ret

ENDOFBONUS2    DFL Call
			   DFW CfS0
               DFL Moke,VSRV,$86
               DFL For,2
               DFL 38,8,50,8,53,2,52,2,48,2,45,4,43,2,45,4
               DFL 38,8,50,8,53,2,52,2,48,2,55,4,53,2,52,2,48,2
               DFL Next
               DFL For,2
               DFL 50,8,52,6,53,1,55,1,53,6,55,2,57,3,55,3,53,2
               DFL 50,6,52,1,53,1,52,6,48,2,50,16
               DFL Next
               DFL Ret

 ;======================== GAME OVER MUSIC DATA ================================

OVER0          DFL RestR,2
OVER1          DFL FLoad,VRC
               DFW GD20a
               DFL RestR,1
               DFL Jmp
               DFW OVER2a


OF20           DFW +147,0,0,0
               DFL 7,0,0,0,2,4
OF21           DFW N61-N64,0,0,0
               DFL 1,0,0,0,5,4
OF22           DFW +85,-85,0,0
               DFL 4,4,2,0,4,5

OVER2          DFL Call
               DFW CfS0
               DFL Filter
               DFW CaC0
OVER2a         DFL Moke,VWF,65,Moke,VADSD,45
               DFL Transp,+9
               DFL For,4
               DFL Freq
               DFW OF21
               DFL 55+R,6*2-2
               DFL Freq
               DFW OF20
               DFL 50,6
               DFL Moke,FMC,0
               DFL 52,3
               DFL Next
               DFL Moke,FMC,4,DMoke,FMG0
               DFW +208
               DFL 55,10,55,10
               DFL Moke,FMC,0
               DFL 57,4,55,4,53,4,52,2,53,2,52,2,50,4,52,4
               DFL 53,2,52,2,50,2,50,2,48,2,45,2
               DFL 48,2,50,2
               DFL Freq
               DFW OF22
               DFL 48,20
               DFL Rest,1
               DFL Ret

 ;=================== IN THE LABORATORY BACKGROUND SOUND DATA ==================

LABORATORY2    DFL Filter
               DFW BC00
               DFL Code
               DFW BX00
               DFL Rest,8
LABORATORY1    DFL Rest,8
LABORATORY0    DFL FLoad,VRC
               DFW BD00
               DFL Moke,PMC,0,Moke,VWF,%00010101
               DFL Jmp
               DFW BONUS0Loop

 ;========================= BONUS SCREEN MUSIC DATA ============================

BD00           DFW -200,0,0,0
               DFL 255,0,0,0,10,4
               DFL 255,0,0,4
               DFW +50,0,$0800
               DFL %01000001,$03,$97,13,8

BC00           DFW -2,-2,+2,+2
               DFL 255,255,255,255,255,5
               DFW 1200
BS00           DFL 12,4,10,4,8,4,5,4,3,4,0,4,Ret
BS01           DFL 0,4,3,4,5,4,8,4,10,4,12,4,Ret
BS02           DFL 12,4,0,4,10,4,0,4,7,4,3,4,Ret
BS03           DFL 0,4,3,4,7,4,12,4,Ret
BX00           LDA #%11110111
               STA $D417
               LDA #%00011111
               STA $D418
               LDA #3
               STA FilterChannel
               JMP StartFilter

BONUS2         DFL Filter
               DFW BC00
               DFL Code
               DFW BX00
               DFL Rest,6
BONUS1         DFL Rest,6
BONUS0         DFL FLoad,VRC
               DFW BD00
BONUS0Loop     DFL For,2
               DFL For,2
               DFL CT,+67
               DFW BS00
               DFL CT,+55
               DFW BS00
               DFL CT,+43
               DFW BS00
               DFL CT,+31
               DFW BS00
               DFL Next
               DFL For,2
               DFL CT,+71
               DFW BS01
               DFL CT,+57
               DFW BS01
               DFL CT,+45
               DFW BS01
               DFL CT,+31
               DFW BS01
               DFL Next
               DFL Next
               DFL For,4
               DFL CT,+50
               DFW BS02
               DFL CT,+55
               DFW BS02
               DFL CT,+53
               DFW BS02
               DFL CT,+58
               DFW BS02
               DFL Next
               DFL For,4
               DFL CT,+50
               DFW BS03
               DFL CT,+62
               DFW BS03
               DFL CT,+55
               DFW BS03
               DFL CT,+67
               DFW BS03
               DFL CT,+60
               DFW BS03
               DFL CT,+72
               DFW BS03
               DFL CT,+65
               DFW BS03
               DFL CT,+77
               DFW BS03
               DFL Next,Jmp
               DFW BONUS0Loop

 ;====================== BONUS SCREEN BASS MUSIC DATA ==========================

BBD20          DFW +40,-40,+40,0
               DFL 3,5,2,0,10,5
               DFL 12,255,0,4
               DFW +160,-68,$0800
               DFL 73,$03,$A7,2,5
BBC20          DFW -40,+4,+12,-12
               DFL 20,25,20,20,0,4
               DFW 700
JeF20          DFW -45,0,+45,0
               DFL 4,4,4,4,16,5
JeF21          DFW -30,0,0,+4
               DFL 255,0,0,0,15,7
JaS0           DFL Rest,3,38,2,40,2,38,2,35,2,34,3,Rest,1,33,6,Ret
JOPSd          DFL 33,8,42,4,Rest,2,43,3,Rest,1
               DFL 38,2,39,2,40,2,43,2,40,2,39,2,38,2
               DFL 33,8,45,4,Rest,2,43,3,Rest,1
               DFL 45,1,47,1,45,2
               DFL 43,1,45,1,43,2
               DFL 42,1,43,1,42,2
               DFL 40,2,33,6
               DFL 33,2,43,2,45,2,43,2,40,2,Rest,2,22,2,34,4,47,2
               DFL 45,2,43,2,21,2
               DFL 33,3,Rest,1,33,4
               DFL 25,2,26,2,27,2,28,4,28,2,31,3,Rest,1
               DFL For,2,31,2,28,2,Next
               DFL Ret
MaS0           DFL 17,2,17,2,29,2,17,2,Ret

BBASS2         DFL Master,Filter
               DFW BBC20
               DFL FLoad,VRC
               DFW BBD20
               DFL 35,4,23,4,35,4,34,4,22,4,34,4,33,4,21,4,33,4,32,4,20,4,32,4
               DFL For,2
               DFL For,2,31,9,43,9,41,9,41,3,38,6,36,6,34,6,Next
               DFL 27,9,39,9,37,9
               DFL 37,3,34,6,32,6,30,6,26,9,38,9,36,9,36,3,14,3,26,3,17,3,29,3
               DFL 18,3,30,3
               DFL Next

               DFL Time,4
               DFL Call
               DFW CfS0

               DFL Call
               DFW JOPSd

               DFL DMoke,PINIT
               DFW $0800
               DFL 24,8,36,3,Call
               DFW JaS0
               DFL 23,8,35,3,Call
               DFW JaS0
               DFL 22,8,34,3,Call
               DFW JaS0
               DFL 21,8,33,3,Call
               DFW JaS0

               DFL Call
               DFW JOPSd

               DFL For,2
               DFL 45,2,43,2,40,3,Rest,1,43,2,40,4,37,4,38,2,39,2
               DFL 40,4,43,4,44,2
               DFL 45,2,43,2,40,3,Rest,1,43,2,40,3,Rest,1
               DFL Freq
               DFW JeF20
               DFL 39,12
               DFL Freq
               DFW JeF21
               DFL 48,6
               DFL Freq
               DFW GD20a
               DFL Next

               DFL For,4
               DFL 31,8,32,6,33,2,Rest,2,21,8,31,1,33,1
               DFL 36,1,38,1,36,2,31,8,32,6,33,2,Rest,2
               DFL 21,2,22,2,23,2,26,2,27,2,28,2,30,2
               DFL Next

               DFL Time,5
               DFL CT,+0
               DFW CRIXa
               DFL Time,3

               DFL Call
               DFW CfS0
               DFL For,4
               DFL 19,8,31,2,7,2,19,2,21,2,22,6,22,2,34,2,22,4,23,2,24,6,24,2
               DFL 36,2,24,4,24,2
               DFL CT,-2
               DFW MaS0
               DFL CT,+0
               DFW MaS0
               DFL Next

               DFL For,4
               DFL For,2
               DFL 31,2,31,2,43,2,31,2,31,2,41,2,31,2,31,2
               DFL 38,2,31,2,36,2,31,2,34,2,31,2,29,2,26,2
               DFL Next
               DFL For,2
               DFL 29,2,29,2,43,2,29,2,29,2,41,2,29,2,29,2
               DFL 38,2,29,2,36,2,29,2,34,2,31,2,29,2,26,2
               DFL Next
               DFL Next

               DFL For,4
               DFL For,2
               DFL 31,2,31,2,19,2,31,2,19,2
               DFL For,4,19,2,31,2,Next
               DFL 31,2,31,2,19,2
               DFL Next
               DFL 31,2,31,2,22,2,31,2,22,2
               DFL For,4,22,2,31,2,Next
               DFL 31,2,31,2,22,2,29,2,29,2,24,2,29,2,24,2
               DFL For,3,24,2,29,2,Next
               DFL 24,2,28,2,28,2,28,2,24,2
               DFL Next

               DFL Time,2
               DFL Jmp
               DFW BBASS2

 ;====================== FILTH ALARM MUSIC DATA ================================

FILTH          DFL FLoad,VRC
               DFW GD20a
               DFL Master,Filter
               DFW GC20a
               DFL For,2
               DFL 21,2,21,2,28,2,28,2,27,2,27,2,26,2,26,2
               DFL 33,2,33,2,32,2,31,2,28,2,27,2,26,2,24,2
               DFL Next,Ret

 ;=========================== GAME MUSIC DATA ==================================

;CHRIX A...

GC20a          DFW +20,-20,+50,-50
               DFL 4,4,4,4,10,7
               DFW 600
GD20a          DFW +20,-20,+20,0
               DFL 2,4,2,0,8,5
               DFL 20,200,0,5
               DFW +100,-10,$0400
               DFL 73,$01,$C4,2,5

CaC0           DFW +20,-20,+20,+120
               DFL 4,4,4,0,4,7
               DFW 100
CaF0           DFW 0,0,1,5,CaL0
               DFL 0,7,7,8
CaL0           DFL -2,-4,-2,+3,-2,-4,-2,0
CaL1           DFL -2,-4,-2,+2,-2,-4,-2,0
CaL2           DFL -2,-4,-2,+5,-2,-4,-2,0

CRIXa          DFL Call
               DFW CfS0
               DFL Freq
               DFW CaF0
               DFL Filter
               DFW TD00
               DFL Moke,VWF,65,Moke,VADSD,255
               DFL 59,16
               DFL For,3
               DFL Call
               DFW CaS0
               DFL Rest,16
               DFL Next
CaS0           DFL DSoke,FOLA
               DFW CaL1
               DFL Rest,16
               DFL DSoke,FOLA
               DFW CaL0
               DFL Rest,16
               DFL DSoke,FOLA
               DFW CaL2
               DFL Rest,16
               DFL DSoke,FOLA
               DFW CaL0
               DFL Ret

 ;======================= TITLE SCREEN MUSIC DATA ==============================

TC00           DFW -6,-1,+1,+6
               DFL 128,255,255,128,0,5
               DFW 1100
TD00           DFW +25,-25,+25,+10
               DFL 9,18,9,0,100,7
               DFL 160,160,0,5
               DFW +8,-8,$0800
               DFL 65,$06,$FA,255,254
TF01           DFW -73,+0,+73,+0
               DFL 10,10,10,10,10,5
TV01           DFL 65,$06,$F6,20,50
TF02           DFW +20,+0,-40,+0
               DFL 41,40,20,0,5,4
TD03           DFW +4,0,0,0
               DFL 255,0,0,0,10,5
               DFL $1C,4,0,133
               DFW +$29,+$7C,$0480
               DFL %01010001,$09,$8A,20,254
TX00           LDA #3
               STA FilterChannel
               RTS 
TS00           DFL For,4
               DFL 50,12,74,12,69,12,65,12
               DFL 62,6,65,6,65,6
               DFL 57,6,62,6,62,6
               DFL 53,6,57,6
               DFL Next
               DFL For,4
               DFL 47,12,76,12,71,12,68,12
               DFL 64,6,68,6,68,6
               DFL 59,6,64,6,56,6,59,6,52,6
               DFL Next
               DFL Ret
TS01           DFL For,4
               DFL 41,12,65,12,60,12,58,12
               DFL 53,6,58,6,58,6
               DFL 48,6,53,6,53,6,46,6,48,6
               DFL Next
               DFL For,4
               DFL 40,12,64,12,58,12,56,12
               DFL 52,6,56,6,56,6
               DFL 46,6,52,6,52,6,40,6,46,6
               DFL Next
               DFL For,4
               DFL 39,12,63,12,58,12,55,12
               DFL 51,6,55,6,55,6
               DFL 46,6,51,6,51,6,43,6,46,6
               DFL Next
               DFL For,4
               DFL 38,12,62,12,58,12,54,12
               DFL 50,6,54,6,54,6
               DFL 46,6,50,6,50,6,42,6,46,6
               DFL Next
               DFL For,4
               DFL 37,12,61,12,58,12,53,12
               DFL 49,6,53,6,53,6
               DFL 46,6,49,6,49,6,41,6,46,6
               DFL Next
               DFL For,4
               DFL 36,12,60,12,58,12,52,12
               DFL 48,6,52,6,52,6
               DFL 46,6,48,6,48,6,40,6,46,6
               DFL Next
               DFL For,4
               DFL 35,12,59,12,58,12,51,12
               DFL 47,6,51,6,51,6
               DFL 46,6,47,6,47,6,39,6,42,6
               DFL Next
               DFL For,4
               DFL 34,12,58,12,53,12,50,12
               DFL 46,6,50,6,50,6
               DFL 41,6,46,6,46,6,38,6,41,6
               DFL Next
               DFL Ret

TITLE0         DFL FLoad,VRC
               DFW TD00
               DFL Master
               DFL Filter
               DFW TC00
               DFL 58,32
               DFL Code
               DFW TX00
               DFL For,20,Rest,32,Next
               DFL 58,32,Rest,32,Rest,32
               DFL MBendOff
               DFL Rest,24,58,4,57,4,58,32,Rest,24,55,8,62,32
               DFL MBendOn,DMoke,FBG
               DFW +6
               DFL 64,32
               DFL MBendOff
               DFL 64,32,Rest,32,Rest,32,Rest,8,60,16
               DFL 55,4,53,4,52,32,Rest,32,53,32,55,32
               DFL Freq
               DFW TF01
               DFL 55,32
               DFL Freq
               DFW TF02
               DFL Rest,32
               DFL Rest,32
               DFL Moke,FMC,4,55,24,Moke,FMC,0,53,8
               DFL Moke,FMD1,5
               DFL For,4
               DFL Moke,FMC,4,55,16,Moke,FMC,0,53,6
               DFL Next
               DFL FLoad,FMDLY
               DFW TD00
               DFL MBendOff
               DFL 55,32
               DFL Soke,VADSC,254
               DFL Rest,32
               DFL Rest,32
               DFL Rest,32
               DFL Rest,24
               DFL 55,16,60,32,Rest,32,64,32,Rest,32,62,32,Soke,VADSC,150
               DFL Rest,32
               DFL Rest,32
               DFL Rest,16
               DFL 58,16,62,32,Rest,32,65,32,Rest,16
               DFL Freq
               DFW TF02
               DFL Moke,FMDLY,50,DMoke,FMG0
               DFW -30
               DFL 67,16
               DFL Freq
               DFW TD00
               DFL MBendOff,64,32,Soke,VADSC,254
               DFL Rest,32,Rest,32,Rest,32
               DFL 67,24,69,24,67,16
               DFL 65,24,64,24,60,16
               DFL 62,32,Rest,32,Rest,32,Rest,16,60,16
               DFL 58,32,Rest,32
               DFL 55,32,Rest,16
               DFL DMoke,FBG
               DFW +0
               DFL MBendOn
               DFL 53,12
               DFL DSoke,FBG
               DFW +18
               DFL Rest,8
               DFL DSoke,FBG
               DFW +0
               DFL MBendOn,Moke,VSRV,$AF,DMoke,FBG
               DFW +0
               DFL For,127,Rest,4,Next
               DFL 60,32
               DFL For,6,Rest,32,Next
               DFL Rest,16
               DFL Soke,FMDLY,100,DSoke,FBG
               DFW -12
               DFL Rest,16
               DFL DSoke,FBG
               DFW +0
               DFL DSoke,VADSC
               DFW 254+255*256
               DFL FLoad,VRC
               DFW TD03
               DFL For,24,Rest,32,Next
               DFL Call
               DFW TS00
               DFL Call
               DFW TS00
               DFL Call
               DFW TS01
               DFL Rest,9
               DFL Jmp
               DFW TITLE0


TD10           DFW +25,-25,+25,0
               DFL 9,18,9,0,100,0
               DFL 160,160,0,5
               DFW +8,-8,$0800
               DFL 65,$B6,$FF,254,255
TV11           DFL 65,$00,$56,12,50
TL10           DFL 5,12,0,7,4,12,0,7,2,12,0,7,4,12,0,7
TL11           DFL 5,12,-2,7,4,12,-2,7,2,12,-2,7,4,12,-2,7
TL12           DFL 4,-12,12,7,4,-24,4,7,12,-12,4,7,12,-24,12,7
TL13           DFL 2,-12,10,7,2,-26,2,7,10,-12,2,7,10,-26,10,7

TITLE1         DFL FLoad,VRC
               DFW TD20
               DFL DMoke,FOLA
               DFW TL10
               DFL For,13,Rest,32,Next
               DFL 60,32
               DFL For,7,Rest,32,Next
               DFL For,2
               DFL DSoke,FOLA
               DFW TL11
               DFL For,8,Rest,32,Next
               DFL DSoke,FOLA
               DFW TL10
               DFL For,8,Rest,32,Next
               DFL Next
               DFL DSoke,FOLA
               DFW TL11
               DFL For,8,Rest,32,Next
               DFL DSoke,FOLA
               DFW TL10
               DFL For,12,Rest,8,Next
               DFL Rest,5
               DFL DSoke,PMG0
               DFW -1
               DFL DSoke,FOLA
               DFW TL12
               DFL Rest,3
               DFL For,19,Rest,8,Next
               DFL DSoke,PMG0
               DFW +0
               DFL DSoke,FOLA
               DFW TL13
               DFL FLoad,VRC
               DFW TD10
               DFL For,8,Rest,32,Next
               DFL For,3
               DFL 24,32
               DFL For,7,Rest,32,Next
               DFL 31,32
               DFL For,7,Rest,32,Next
               DFL Next
               DFL FLoad,VRC
               DFW TD03
               DFL Moke,FMC,5
               DFL Rest,9
               DFL For,24,Rest,32,Next
               DFL Call
               DFW TS00
               DFL Call
               DFW TS01
               DFL Jmp
               DFW TITLE1


TC20           DFW -1,-1,-1,+7
               DFL 255,255,255,0,255,7
               DFW 100
TD20           DFW 0,0,1,20,TL20
               DFL 0,15,0,8
               DFL 1,1,0,5
               DFW +1,+0,$0001
               DFL 65,$FE,$BF,255,255
TD21           DFW +6,-6,+6,-6
               DFL 10,20,10,0,100,5
               DFL 160,160,0,5
               DFW +8,-8,$0800
               DFL 65,$CC,$8A,255,254
 ;              DFL 33,$CC,$CA,255,254
TL20           DFL 0,7,4,12,0,7,2,12,0,7,4,12,0,7,5,12
TL21           DFL -2,7,4,12,-2,7,2,12,-2,7,4,12,-2,7,5,12
TL22           DFL 12,7,4,-12,12,7,4,-24,4,7,12,-12,4,7,12,-24
TL23           DFL 10,7,2,-12,10,7,2,-26,2,7,10,-12,2,7,10,-26

TITLE2         DFL FLoad,VRC
               DFW TD20
               DFL For,5,Rest,32,Next
               DFL 60,32
               DFL For,15,Rest,32,Next
               DFL For,2
               DFL DSoke,FOLA
               DFW TL21
               DFL For,8,Rest,32,Next
               DFL DSoke,FOLA
               DFW TL20
               DFL For,8,Rest,32,Next
               DFL Next
               DFL DSoke,FOLA
               DFW TL21
               DFL For,25,Rest,4,Next
               DFL Soke,VADSC,254
               DFL DSoke,PMG0
               DFW -1
               DFL DMoke,PINIT
               DFW $0ECF
               DFL DMoke,PMG0
               DFW -1
               DFL For,15,Rest,8,Next
               DFL 60,32
               DFL For,3
               DFL DSoke,FOLA
               DFW TL22
               DFL For,8,Rest,32,Next
               DFL DSoke,FOLA
               DFW TL23
               DFL For,8,Rest,32,Next
               DFL Next
               DFL FLoad,VRC
               DFW TD10
               DFL Rest,4
               DFL 29,32
               DFL For,7,Rest,32,Next
               DFL 26,32
               DFL FLoad,VRC
               DFW TD21
               DFL For,7,Rest,32,Next
               DFL Master,Filter
               DFW TC20
               DFL For,2
               DFL 29,32
               DFL For,11,Rest,32,Next
               DFL 23,32
               DFL For,11,Rest,32,Next
               DFL Next
               DFL For,6
               DFL 34,32
               DFL For,11,Rest,32,Next
               DFL Next
               DFL 34,32
               DFL For,10,Rest,32,Next
               DFL DSoke,FMDLY
               DFW 255+256*7
               DFL Moke,VSRV,$8F,DMoke,VADSD
               DFW 254+255*256
               DFL Rest,32
               DFL 22,32
               DFL For,45,Rest,8,Next
               DFL RestR,5
               DFL Jmp
               DFW TITLE2

ED ;============================================================================

SIZE           EQU ED-$45B0
GAP            EQU 15*512-SIZE ;      I've currently got 7.5K to play with
CH0VALUE       EQU 1
CH1VALUE       EQU 1
CH2VALUE       EQU 1
Q              EQU 82
refsp          EQU $100

 ;^^^^^^^^^^^^^^^ This is the end of the source file... (or is it?) ^^^^^^^^^^^^

