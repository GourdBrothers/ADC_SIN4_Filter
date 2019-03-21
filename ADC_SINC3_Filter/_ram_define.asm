;==============================================
;==== _RAM_Define.ASM
;==============================================

buffer0		             EQU  080H
buffer1		             EQU  buffer0 + 1
buffer2		             EQU  buffer1 + 1
buffer3		             EQU  buffer2 + 1
buffer4		             EQU  buffer3 + 1
buffer5		             EQU  buffer4 + 1
buffer6		             EQU  buffer5 + 1

OTP_Addr                 EQU  buffer0
OTP_CNT                  EQU  buffer1
OTP_Current_Addr         EQU  buffer2
R_BH                     EQU  buffer3
R_BL                     EQU  buffer4
R_AH                     EQU  buffer5
R_AL                     EQU  buffer6

TempRam1	             EQU  buffer6    + 1
TempRam2	             EQU  TempRam1   + 1
TempRam3	             EQU  TempRam2   + 1
TempRam4	             EQU  TempRam3   + 1
TempRam5	             EQU  TempRam4   + 1
TempRam6	             EQU  TempRam5   + 1

TempRam11	             EQU  TempRam6   + 1
TempRam12	             EQU  TempRam11  + 1
TempRam13	             EQU  TempRam12  + 1

Display1	             EQU  TempRam13  + 1
    B_Display1_P1        EQU  7
Display2                 EQU  Display1   + 1
    B_Display2_P2        EQU  7
Display3                 EQU  Display2   + 1
    B_Display3_P3        EQU  7
Display4                 EQU  Display3   + 1
Display5                 EQU  Display4   + 1
    B_Display5_KG        EQU  0
    B_Display5_NEG       EQU  1
    B_Display5_MILK      EQU  2
    B_Display5_BC        EQU  3
    B_Display5_ML        EQU  4
    B_Display5_OZ        EQU  5
    B_Display5_LB        EQU  6
    B_Display5_G         EQU  7
Display6                 EQU  Display5       + 1

WorkRegBank              EQU  Display6       + 1
StatusBank               EQU  WorkRegBank    + 1

REG0                     EQU  StatusBank     + 1
REG1                     EQU  REG0           + 1
REG2                     EQU  REG1           + 1
REG3                     EQU  REG2           + 1

SysFlag1                 EQU  REG3           + 1
   B_Flag1_AdcStart	     EQU  0
   B_Flag1_AdcOk	     EQU  1
   B_Flag1_AdcDataOk     EQU  2
   B_Flag1_AdcStable     EQU  3

SampleTimes              EQU  SysFlag1       + 1
AdcShiftCnt              EQU  SampleTimes    + 1
ADCCnt                   EQU  AdcShiftCnt    + 1

ADRamH                   EQU  ADCCnt         + 1
ADRamM                   EQU  ADRamH         + 1
ADRamL                   EQU  ADRamM         + 1

H_DR                     EQU  ADRamL         + 1
M_DR                     EQU  H_DR           + 1
L_DR                     EQU  M_DR           + 1

H_DATA                   EQU  L_DR           + 1
M_DATA                   EQU  H_DATA         + 1
L_DATA                   EQU  M_DATA         + 1

IZA                      EQU  L_DATA         + 1 ; IZA
IZA1                     EQU  IZA            + 1
IZA2                     EQU  IZA1           + 1
IZA3                     EQU  IZA2           + 1
IZA4                     EQU  IZA3           + 1

IZB                      EQU  IZA4           + 1 ; IZB
IZB1                     EQU  IZB            + 1
IZB2                     EQU  IZB1           + 1
IZB3                     EQU  IZB2           + 1
IZB4                     EQU  IZB3           + 1

IZC                      EQU  IZB4           + 1 ; IZC
IZC1                     EQU  IZC            + 1
IZC2                     EQU  IZC1           + 1
IZC3                     EQU  IZC2           + 1
IZC4                     EQU  IZC3           + 1

IZD                      EQU  IZC4           + 1 ; IZD
IZD1                     EQU  IZD            + 1
IZD2                     EQU  IZD1           + 1
IZD3                     EQU  IZD2           + 1
IZD4                     EQU  IZD3           + 1

DZA                      EQU  IZD4           + 1 ; DZA
DZA1                     EQU  DZA            + 1
DZA2                     EQU  DZA1           + 1
DZA3                     EQU  DZA2           + 1
DZA4                     EQU  DZA3           + 1

DZB                      EQU  DZA4           + 1 ; DZB
DZB1                     EQU  DZB            + 1
DZB2                     EQU  DZB1           + 1
DZB3                     EQU  DZB2           + 1
DZB4                     EQU  DZB3           + 1

DZC                      EQU  DZB4           + 1 ; DZC
DZC1                     EQU  DZC            + 1
DZC2                     EQU  DZC1           + 1
DZC3                     EQU  DZC2           + 1
DZC4                     EQU  DZC3           + 1

DZD                      EQU  DZC4           + 1 ; DZD
DZD1                     EQU  DZD            + 1
DZD2                     EQU  DZD1           + 1
DZD3                     EQU  DZD2           + 1
DZD4                     EQU  DZD3           + 1


;==============================================
;==== BANK1
;==============================================

UART_Flag		EQU		0100H
	B_UART_Flag_TX	EQU	0
UART_TX_CNT		EQU		UART_Flag	+ 1
UART_TX_0		EQU		UART_TX_CNT	+ 1
UART_TX_1		EQU		UART_TX_0	+ 1
UART_TX_2		EQU		UART_TX_1	+ 1
UART_TX_3		EQU		UART_TX_2	+ 1


