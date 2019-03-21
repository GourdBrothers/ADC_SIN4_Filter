

Fun_1186_uart_init:
	BSF		INTE2,URTIE
	BCF		INTE2,URRIE
	BSF		PT2EN,5
	BSF		PT2,5
	BCF		PT2EN,4
	BSF		PT2PU,4
	MOVLW	00000000B
	MOVWF	SCON2
	MOVLW	01000011B		; PT24,PT25 ´®¿ÚÍ¨ÐÅ
	MOVWF	SCON1
RETURN
	
Fun_1186_uart_Close:
	BCF		INTE2,URTIE
	BCF		INTE2,URRIE
	CLRF	SCON1
RETURN
	
Fun_1186_uart_SendNBytes:
	MOVLW		04H
	MOVWF		UART_TX_CNT
	BSF			BSR,IRP0
	MOVLW		UART_TX_0
	MOVWF		FSR0
Fun_1186_uart_SendBytes:
	CLRF		buffer0
	CLRF		buffer1
	BCF			UART_Flag,B_UART_Flag_TX
	MOVFW		IND0
	MOVWF		SBUF
Fun_1186_uart_SendBytesLoop:
;	MOVLW		01H
;	ADDWF		buffer1,F
;	MOVLW		00H
;	ADDWFC		buffer0,F
;	MOVLW		LOW		1000
;	SUBWF		buffer1,W
;	MOVLW		HIGH	1000
;	SUBWFC		buffer0,W
;	BTFSC		STATUS,C
;	GOTO		Fun_1186_uart_SendBytesEnd
;	
	BTFSS		UART_Flag,B_UART_Flag_TX
	GOTO		Fun_1186_uart_SendBytesLoop
	INCF		FSR0,F
	DECFSZ		UART_TX_CNT,F
	GOTO		Fun_1186_uart_SendBytes
Fun_1186_uart_SendBytesEnd:
	BCF			BSR,IRP0
RETURN
	