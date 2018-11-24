;============================================
;==== 1186 四阶滤波算法（先积分后微分）
;==== 后面可以增加其他的滤波算法来满足对应的
;==== 场合
;==== 20181124
;==== IDE: CSU-IDE V4.0.9
;==== ICE: EVL-10186
;============================================
    INCLUDE   _CSU8RP1186.INC
	INCLUDE   _CSU_MACRO.ASM
	INCLUDE   _RAM_Define.ASM
	INCLUDE   _CONST_Define.ASM
;============================================
	ORG	      000H
	NOP
	GOTO      _SYS_RESET
    ORG       004H
	GOTO      _ISR_ENTRY
;============================================
    ORG       008H
    INCLUDE   _CSU1186_ISR.ASM
    INCLUDE   _CSU1186_MATH.ASM
	INCLUDE   _LCD_CDOE.ASM
	INCLUDE   _FUN_LIB.ASM
;============================================

_SYS_RESET:
    DW        0FFFFH
    NOP

;============================================
_SYS_INIT:
    INCLUDE   _CSU1186_Init.ASM
	
    BSF       SysFlag1,B_Flag1_AdcStart
    CLRF      SampleTimes

_SYS_START_END:

;============================================
_MAIN_LOOP:
    HALT
	NOP

_MAIN_PRO_ADC:	
	BTFSS          SysFlag1,B_Flag1_AdcOk
	GOTO           _MAIN_LOOP

_MAIN_PRO_ADC_END:

_MAIN_DISPLAY:
	CALL           _LCDBUF_CLR_ALL
	
_MAIN_DISPLAY_ADC:
	MACRO_MOVFF    TempRam11,H_DATA
	MACRO_MOVFF    TempRam12,M_DATA
	MACRO_MOVFF    TempRam13,L_DATA
	CALL           F_HexToBcd
	CALL           _LCD_GetNumCode
	
_MAIN_DISPLAY_LOAD:
	CALL           _LCDBUF_LOAD_LCD

_MAIN_DISPLAY_END:

    BCF            SysFlag1,B_Flag1_AdcOk

    GOTO           _MAIN_LOOP

;============================================
	END
;============================================
