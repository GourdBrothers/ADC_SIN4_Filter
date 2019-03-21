;=============================================================
;=== _ISR_ADC_SINC3.ASM
;=== Input  : ADRamH,ADRamM,ADRamL
;=== Output : H_DATA,M_DATA,L_DATA
;=============================================================

ISR_AdcSinc3_Add:

	MOVFW	ADRamL	   ; adc out + IZA -> IZA
	ADDWFC	IZA  ,F
	MOVFW 	ADRamM
	ADDWFC	IZA+1,F
	MOVFW 	ADRamH
	ADDWFC	IZA+2,F
	MOVLW	0
	ADDWFC	IZA+3,F
	MOVLW	0
	ADDWFC	IZA+4,F

	MOVFW	IZA         ; IZA + IZB -> IZB
	ADDWF	IZB  ,F
	MOVFW	IZA+1
	ADDWFC	IZB+1,F
	MOVFW	IZA+2
	ADDWFC	IZB+2,F
	MOVFW	IZA+3
	ADDWFC	IZB+3,F	
	MOVFW	IZA+4
	ADDWFC	IZB+4,F	

	MOVFW	IZB         ; IZB + IZC -> IZC
	ADDWF	IZC,  F
	MOVFW	IZB+1
	ADDWFC	IZC+1,F
	MOVFW	IZB+2
	ADDWFC	IZC+2,F
	MOVFW	IZB+3
	ADDWFC	IZC+3,F	
	MOVFW	IZB+4
	ADDWFC	IZC+4,F	
	
	INCF	ADCCnt,F
	MOVLW 	8
	DW      0FFFFH
	DW      0FFFFH
	DW      0FFFFH
	DW      0FFFFH
	NOP
	SUBWF   ADCCnt,W
	BTFSS   STATUS,C
    GOTO 	adc_int_end
;================================	
INTER_DVIN:
	CLRF	ADCCnt
	
ISR_AdcSinc3_Dec:

	;--- DZA = IZC - DZA
    MOVFW    DZA
    SUBWF    IZC,W
    MOVWF    DZA
    
    MOVFW    DZA1
    SUBWFC   IZC1,W
    MOVWF    DZA1
    
    MOVFW    DZA2
    SUBWFC   IZC2,W
    MOVWF    DZA2
    
    MOVFW    DZA3
    SUBWFC   IZC3,W
    MOVWF    DZA3
    
    MOVFW    DZA4
    SUBWFC   IZC4,W
    MOVWF    DZA4
    
    ;--- DZB = DZA - DZB
    MOVFW    DZB+0
    SUBWF    DZA+0,W
    MOVWF    DZB+0
    
    MOVFW    DZB+1
    SUBWFC   DZA+1,W
    MOVWF    DZB+1
    
    MOVFW    DZB+2
    SUBWFC   DZA+2,W
    MOVWF    DZB+2
    
    MOVFW    DZB+3
    SUBWFC   DZA+3,W
    MOVWF    DZB+3
    
    MOVFW    DZB+4
    SUBWFC   DZA+4,W
    MOVWF    DZB+4
    
;--- R_ADCTemp = DZB - DZC
    
    MOVFW    DZC+0
    SUBWF    DZB+0,W
    
    MOVFW    DZC+1
    SUBWFC   DZB+1,W
    MOVWF    L_DATA
    
    MOVFW    DZC+2
    SUBWFC   DZB+2,W
	MOVWF    M_DATA
    
    MOVFW    DZC+3
    SUBWFC   DZB+3,W
	MOVWF    H_DATA
    
    MOVFW    DZC+4
    SUBWFC   DZB+4,W
    
    BCF		STATUS,C
    RRF		H_DATA,F
    RRF		M_DATA,F
    RRF		L_DATA,F
    
; data copy
	
	MACRO_MOVFF DZC  , DZB 		; C <- B
	MACRO_MOVFF DZC1 , DZB1
	MACRO_MOVFF DZC2 , DZB2
	MACRO_MOVFF DZC3 , DZB3
	MACRO_MOVFF DZC4 , DZB4
	
	MACRO_MOVFF DZB , DZA		; B <- A
	MACRO_MOVFF DZB1, DZA1
	MACRO_MOVFF DZB2, DZA2
	MACRO_MOVFF DZB3, DZA3
	MACRO_MOVFF DZB4, DZA4
	
	MACRO_MOVFF DZA , IZC		; A <- C
	MACRO_MOVFF DZA1, IZC1
	MACRO_MOVFF DZA2, IZC2
	MACRO_MOVFF DZA3, IZC3
	MACRO_MOVFF DZA4, IZC4
	
adc_int_OK:
    INCF        SampleTimes,F
	MOVLW       03H
	SUBWF       SampleTimes,W
	BTFSS       STATUS,C
	GOTO        adc_int_end
	DECF        SampleTimes,F
    BSF         SysFlag1,B_Flag1_AdcOk

adc_int_end:

