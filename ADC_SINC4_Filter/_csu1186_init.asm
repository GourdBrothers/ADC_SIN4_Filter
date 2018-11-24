;======================================
;==== _CSU1186_Init.ASM
;======================================
_CSU1186_Init_Entry:
   CLRF           INTE

_CSU1186_Init_CLK:

   MACRO_MOVFL    MCK   ,00000100B     ; CPU_CLK 1000KHZ
   NOP
   MACRO_MOVFL    MCK2  ,00000010B
   NOP
   
_CSU1186_Init_PT1:
   DW             0FFFFH
   NOP
   MACRO_MOVFL    AENB  ,00000000B
   MACRO_MOVFL    PT1EN ,11111111B
   MACRO_MOVFL    PT1PU ,00000000B
   MACRO_MOVFL    PT1   ,00000000B

_CSU1186_Init_PT2:
   DW             0FFFFH
   NOP
   MACRO_MOVFL    PTINT ,00000000B
   MACRO_MOVFL    PT2CON,00000000B
   MACRO_MOVFL    PT2MR ,00000000B
   MACRO_MOVFL    PT2EN ,11111100B
   MACRO_MOVFL    PT2PU ,00000011B
   MACRO_MOVFL    PT2   ,11000011B
   
   BCF            NETC,ADEN

_CSU1186_Init_RAM:
   BCF            BSR,IRP0
   MACRO_MOVFL    FSR0,buffer0
_CSU1186_Init_RAM_LOOP:
   CLRF           IND0
   INCF           FSR0,F
   MOVLW          0FFH
   SUBWF          FSR0,W
   BTFSS          STATUS,C
   GOTO           _CSU1186_Init_RAM_LOOP
   CLRF           IND0
   
_CSU1186_Init_RAM1:
   BSF            BSR,IRP0
   MACRO_MOVFL    FSR0,000H
_CSU1186_Init_RAM1_LOOP:
   CLRF           IND0
   INCF           FSR0,F
   MOVLW          080H
   SUBWF          FSR0,W
   BTFSS          STATUS,C
   GOTO           _CSU1186_Init_RAM1_LOOP
   CLRF           IND0
   BCF            BSR,IRP0

_CSU1186_Init_POWER:
   MOVLW          00100011B         ; ENVDDA
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          NETF
   MOVLW          10000010B         ; LDO: 2.45
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          NETE

_CSU1186_Init_LCD:
   CALL           Fun_LCD_Config
   CALL           _LCDBUF_SET_ALL
   CALL           _LCDBUF_LOAD_LCD
   MACRO_OpenLed

_CSU1186_Init_ADC:
   CALL           F_Delay_1MS
   MOVLW          11100000B
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          TEMPC
;---
   ; MOVLW          00000101B   ;  64X,250K,/2048
   MOVLW          00000110B   ;  64X,250K,/2048
   ; MOVLW          00000111B   ;  64X,250K,/2048
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          ADCON
;---
   MOVLW          00000000B
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          NETA
;---
   MOVLW          00000110B
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          NETC

   BSF            INTE  ,ADIE

_CSU1186_Init_INT:
   BSF            INTE,GIE 

_CSU1186_Init_Exit:



