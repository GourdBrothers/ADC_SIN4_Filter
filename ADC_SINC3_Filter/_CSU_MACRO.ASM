;=================================
;====  _CSU_MACRO.ASM
;=================================

MACRO_MOVFF    MACRO   F1,F2
    MOVFW      F2
	MOVWF      F1
	ENDM
	
MACRO_MOVFL    MACRO   F1,D
    MOVLW      D
	MOVWF      F1
	ENDM

MACRO_RRF_4BIT MACRO   F1
    BCF        STATUS,C
	RRF        F1,F
    BCF        STATUS,C
	RRF        F1,F
    BCF        STATUS,C
	RRF        F1,F
    BCF        STATUS,C
	RRF        F1,F
    ENDM
	
MACRO_OpenLed  MACRO
    MOVFW      _PORT_BackLight
	MOVWF      REG0
	BCF        REG0,B_Pin_BackLight_6
	BCF        REG0,B_Pin_BackLight_7
	MOVFW      REG0
    MOVWF      _PORT_BackLight
    ENDM
	
MACRO_CloseLed  MACRO
    MOVFW      _PORT_BackLight
	MOVWF      REG0
	BSF        REG0,B_Pin_BackLight_6
	BSF        REG0,B_Pin_BackLight_7
	MOVFW      REG0
    MOVWF      _PORT_BackLight
    ENDM
