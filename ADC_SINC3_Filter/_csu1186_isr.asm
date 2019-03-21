;=====================================
;====  _CSU1186_ISR.ASM
;=====================================

_ISR_ENTRY:
        MOVWF           WorkRegBank
	    MACRO_MOVFF     StatusBank,STATUS
	
_ISR_ENTRY_CHK:	

        BTFSC           INTF, ADIF
        GOTO            _ISR_ADC
        BTFSC			INTF2,URTIF
        GOTO			_ISR_UART_TX
		
        CLRF            INTF
        CLRF			INTF2

_ISR_EXIT:
	    MACRO_MOVFF     STATUS,StatusBank
        MOVFW           WorkRegBank

RETFIE


;-----------------------------------------------------------------------
_ISR_UART_TX:
		BCF				INTF2,URTIF
		BSF				UART_Flag,B_UART_Flag_TX
_ISR_UART_TX_END:
		GOTO			_ISR_EXIT
		
;-----------------------------------------------------------------------
_ISR_ADC:
        DW              0FFFFH
		NOP             
		BCF             INTF, ADIF
		
        BTFSC           SysFlag1,B_Flag1_AdcOk
        GOTO            _ISR_ADC_END

		BTFSS		    SysFlag1,B_Flag1_AdcStart
		GOTO		    _ISR_ADC1
		
		INCF            SampleTimes,F
		MOVLW		    3
        DW              0FFFFH
		DW              0FFFFH
		NOP             
		SUBWF		    SampleTimes, W
		BTFSS		    STATUS, C
		GOTO		    _ISR_ADC_END
		BCF 	        SysFlag1,B_Flag1_AdcStart
		CLRF		    SampleTimes
		CLRF	        ADCCnt
		GOTO            _ISR_ADC_END
		
_ISR_ADC1:	
		MACRO_MOVFF		ADRamL, ADOLL
		MACRO_MOVFF		ADRamM, ADOL
		MACRO_MOVFF		ADRamH, ADOH
		
	    MOVLW           080H
		XORWF		    ADRamH, F

		MOVLW           005H
		DW              0FFFFH
		DW              0FFFFH
		NOP
		MOVWF           AdcShiftCnt
_ISR_ADC1_LOOP:
        BCF             STATUS,C
		RRF             ADRamH,F
		RRF             ADRamM,F
		RRF             ADRamL,F
        DECFSZ          AdcShiftCnt,F
		GOTO            _ISR_ADC1_LOOP
		NOP
_ISR_ADC2:
		INCLUDE         "_ISR_ADC_SINC3.ASM"

_ISR_ADC_END:
    
_ISR_ADC_EXIT:
        GOTO            _ISR_EXIT
