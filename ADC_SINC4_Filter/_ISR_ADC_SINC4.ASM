;=============================================================
;=== _ISR_ADC_SINC4.ASM
;=== Input  : ADRamH,ADRamM,ADRamL
;=== Output : H_DATA,M_DATA,L_DATA
;=============================================================

ISR_AdcSinc4_Add:

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
	
	MOVFW	IZC         ; IZC + IZD -> IZD
	ADDWF	IZD  ,F
	MOVFW	IZC+1
	ADDWFC	IZD+1,F
	MOVFW	IZC+2
	ADDWFC	IZD+2,F
	MOVFW	IZC+3
	ADDWFC	IZD+3,F
	MOVFW	IZC+4
	ADDWFC	IZD+4,F	

	INCF	ADCCnt,F
	MOVLW 	16
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
	
ISR_AdcSinc4_Dec:
    
    ;--- DZA = IZD - DZA
    MOVFW    DZA
    SUBWF    IZD,W
    MOVWF    DZA
    
    MOVFW    DZA1
    SUBWFC   IZD1,W
    MOVWF    DZA1
    
    MOVFW    DZA2
    SUBWFC   IZD2,W
    MOVWF    DZA2
    
    MOVFW    DZA3
    SUBWFC   IZD3,W
    MOVWF    DZA3
    
    MOVFW    DZA4
    SUBWFC   IZD4,W
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
    
    ;--- DZC = DZB - DZC
    MOVFW    DZC+0
    SUBWF    DZB+0,W
    MOVWF    DZC+0
    
    MOVFW    DZC+1
    SUBWFC   DZB+1,W
    MOVWF    DZC+1
    
    MOVFW    DZC+2
    SUBWFC   DZB+2,W
    MOVWF    DZC+2
    
    MOVFW    DZC+3
    SUBWFC   DZB+3,W
    MOVWF    DZC+3
    
    MOVFW    DZC+4
    SUBWFC   DZB+4,W
    MOVWF    DZC+4
    
    ;--- R_ADCTemp = DZC - DZD
    MOVFW    DZD+0
    SUBWF    DZC+0,W
    
    MOVFW    DZD+1
    SUBWFC   DZC+1,W
    
    MOVFW    DZD+2
    SUBWFC   DZC+2,W
	MOVWF    L_DATA
    
    MOVFW    DZD+3
    SUBWFC   DZC+3,W
	MOVWF    M_DATA
    
    MOVFW    DZD+4
    SUBWFC   DZC+4,W
	MOVWF    H_DATA
    
; data copy
	MACRO_MOVFF DZD  , DZC 
	MACRO_MOVFF DZD1 , DZC1
	MACRO_MOVFF DZD2 , DZC2
	MACRO_MOVFF DZD3 , DZC3
	MACRO_MOVFF DZD4 , DZC4
	
	MACRO_MOVFF DZC  , DZB 
	MACRO_MOVFF DZC1 , DZB1
	MACRO_MOVFF DZC2 , DZB2
	MACRO_MOVFF DZC3 , DZB3
	MACRO_MOVFF DZC4 , DZB4
	
	MACRO_MOVFF DZB , DZA 
	MACRO_MOVFF DZB1, DZA1
	MACRO_MOVFF DZB2, DZA2
	MACRO_MOVFF DZB3, DZA3
	MACRO_MOVFF DZB4, DZA4
	
	MACRO_MOVFF DZA , IZD 
	MACRO_MOVFF DZA1, IZD1
	MACRO_MOVFF DZA2, IZD2
	MACRO_MOVFF DZA3, IZD3
	MACRO_MOVFF DZA4, IZD4
	
adc_int_OK:
    INCF        SampleTimes,F
	MOVLW       04H
	SUBWF       SampleTimes,W
	BTFSS       STATUS,C
	GOTO        adc_int_end
	DECF        SampleTimes,F
    BSF         SysFlag1,B_Flag1_AdcOk

adc_int_end:

