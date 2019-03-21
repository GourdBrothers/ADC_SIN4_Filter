;=================================================
;==== _CSU1186_MATH.ASM
;=================================================

;**************************************************
;input	:	TempRam3, TempRam4
;		    TempRam5, TempRam6
;output	:
;		    TempRam3, TempRam4
;**************************************************
_Add2_2:
		MOVFW		TempRam6
		ADDWF		TempRam4, F
		MOVFW		TempRam5
		ADDWFC		TempRam3, F
RETURN
		
;**************************************************
;input	:	TempRam3, TempRam4  
;			TempRam5, TempRam6  
;output	:
;			TempRam3, TempRam4
;**************************************************
_Sub2_2:
		MOVFW		TempRam6
		SUBWF		TempRam4, F
		MOVFW		TempRam5
		SUBWFC		TempRam3, F
RETURN
;**************************************************
;  TempRam3,TempRam4
;**************************************************
_Neg2:
		BTFSC		STATUS, C
RETURN
		COMF        TempRam3,F
		COMF        TempRam4,F
		MOVLW       01H
		ADDWF       TempRam4,F
		MOVLW       00H
		ADDWFC      TempRam3,F
RETURN
;**************************************************
;input	:	TempRam1, TempRam2, TempRam3 
;			TempRam4, TempRam5, TempRam6  
;output	:
;			TempRam1, TempRam2, TempRam3
;**************************************************
_Sub3_3:
		MOVFW		TempRam6
		SUBWF		TempRam3, F
		MOVFW		TempRam5
		SUBWFC		TempRam2, F
		MOVFW		TempRam4
		SUBWFC		TempRam1, F
RETURN

;**************************************************
; TempRam1, TempRam2, TempRam3
;**************************************************		
_Neg3:
		BTFSC		STATUS, C
RETURN
		COMF        TempRam1,F
		COMF        TempRam2,F
		COMF        TempRam3,F
		MOVLW       01H
		ADDWF       TempRam3,F
		MOVLW       00H
		ADDWFC      TempRam2,F
		MOVLW       00H
		ADDWFC      TempRam1,F
RETURN
;**************************************************
;input	:TempRam1,TempRam2, TempRam3  TempRam4, TempRam5, TempRam6  
;		 TempRam11,TempRam12,TempRam13
;output	:
;yushu	:	TempRam1, TempRam2, TempRam3
;shang	:	TempRam4, TempRam5, TempRam6
;temp	:	buffer0,buffer1,buffer2,buffer3
;**************************************************
_Div6_3:
		MACRO_MOVFL		buffer3,24
_Div6_3Loop:	
		BCF		STATUS,C
		RLF		TempRam6, F
		RLF		TempRam5, F
		RLF		TempRam4, F
		RLF		TempRam3, F
		RLF		TempRam2, F
		RLF		TempRam1, F
		
		movfw		TempRam13
		subwf		TempRam3, 0
		movwf		buffer2
		
		movfw		TempRam12
		subwfc		TempRam2, 0
		movwf		buffer1
		
		movfw		TempRam11
		subwfc		TempRam1, 0
		movwf		buffer0
		
		btfss		STATUS, C
		goto		_Div6_3Loop1
		
		MACRO_MOVFF		TempRam1,buffer0
		MACRO_MOVFF		TempRam2,buffer1
		MACRO_MOVFF		TempRam3,buffer2
		
		incf		TempRam6, 1	
_Div6_3Loop1:
		decfsz		buffer3, 1
		goto		_Div6_3Loop
return
		
;**************************************************
_ProcAdd1:
		BCF		    STATUS, C
		RLF		    TempRam3, 1
		RLF		    TempRam2, 1
		RLF		    TempRam1, 1
		
		MOVFW		TempRam13
		SUBWF		TempRam3, 1
		MOVFW		TempRam12
		SUBWFC		TempRam2, 1
		MOVFW		TempRam11
		SUBWFC		TempRam1, 1
		
		BTFSS		STATUS, C
RETURN
_ProcAdd1_A:		
		MOVLW		1
		ADDWF		TempRam6, 1
		MOVLW		0
		ADDWFC		TempRam5, 1
		MOVLW		0
		ADDWFC		TempRam4, 1
RETURN
		
;**************************************************
;input	:	TempRam4,TempRam5, TempRam6
;           TempRam11,TempRam12,TempRam13
;output	: 	TempRam1,TempRam2,TempRam3,TempRam4,TempRam5,TempRam6
;need	:	buffer0 ,buffer1 ,buffer2,buffer3,buffer4,buffer5,buffer6
;**************************************************
_Mul3_3:
		clrf		TempRam1
		clrf		TempRam2
		clrf		TempRam3
		clrf		buffer0
		clrf		buffer1
		clrf		buffer2
		
		MACRO_MOVFF		buffer3,TempRam4
		MACRO_MOVFF		buffer4,TempRam5
		MACRO_MOVFF		buffer5,TempRam6
		
		clrf		TempRam4
		clrf		TempRam5
		clrf		TempRam6
		
		MACRO_MOVFL		buffer6,24
_Mul3_2Loop:
        RRF        TempRam11, 1
		rrf		   TempRam12, 1
		rrf		   TempRam13, 1
		
		btfss		STATUS, C
		goto		_Mul3_2Loop1
		
		movfw		buffer5
		addwf		TempRam6, 1
		
		movfw		buffer4
		addwfc		TempRam5, 1
		
		movfw		buffer3
		addwfc		TempRam4, 1
		
		movfw		buffer2
		addwfc		TempRam3, 1
		
		movfw		buffer1
		addwfc		TempRam2, 1
		
		movfw		buffer0
		addwfc		TempRam1, 1
_Mul3_2Loop1:
		bcf		    STATUS, C
		rlf		    buffer5, 1      
		rlf		    buffer4, 1      
		rlf		    buffer3, 1      
		rlf		    buffer2, 1      
		rlf		    buffer1, 1     
		rlf		    buffer0, 1      
		
		decfsz		buffer6, 1
		goto		_Mul3_2Loop
RETURN

;-----------------------------------------------------
;------------  InPut: TempRam11/12/13
;------------  OutPut: TempRam1,2,3,4,5,6 (HIGH->LOW)
;-----------------------------------------------------
F_HexToBcd:
		CLRF        TempRam1
		CLRF        TempRam2
		CLRF        TempRam3
		CLRF        TempRam4
		CLRF        TempRam5
		CLRF        TempRam6
		MACRO_MOVFL		buffer0,24        
		BCF		    STATUS,C
L_Hex2BcdLoop:  	
		RLF		    TempRam13,F
		RLF		    TempRam12,F       
		RLF		    TempRam11,F       
		RLF		    TempRam6 ,F        
		RLF		    TempRam5 ,F        
		RLF		    TempRam4 ,F	      
		RLF		    TempRam3 ,F        
		RLF		    TempRam2 ,F        
		RLF		    TempRam1 ,F        
		DECFSZ		buffer0  ,F
		GOTO        L_AdjustDec       
        GOTO        F_HexToBcd_END
L_AdjustDec:    	
		MACRO_MOVFL		FSR0,TempRam1
		CALL		F_AdjustBcd
		MACRO_MOVFL		FSR0,TempRam2
		CALL		F_AdjustBcd
		MACRO_MOVFL		FSR0,TempRam3
		CALL		F_AdjustBcd
		MACRO_MOVFL		FSR0,TempRam4
		CALL		F_AdjustBcd
		MACRO_MOVFL		FSR0,TempRam5
		CALL		F_AdjustBcd
		MACRO_MOVFL		FSR0,TempRam6
		CALL		F_AdjustBcd
		GOTO        L_Hex2BcdLoop
;------------------------------------
F_HexToBcd_END:
F_SpliteBcd:
		MACRO_MOVFF		buffer0,TempRam1
		MACRO_MOVFF		buffer1,TempRam2
		MACRO_MOVFF		buffer2,TempRam3
		MACRO_MOVFF		buffer3,TempRam4
		MACRO_MOVFF		buffer4,TempRam5
		MACRO_MOVFF		buffer5,TempRam6
		MOVFW       buffer5
		ANDLW		00FH
		MOVWF		TempRam6
		MACRO_RRF_4BIT    buffer5
		MOVFW       buffer5
		andlW		00FH
		MOVWF		TempRam5
	;---
		MOVFW   	buffer4
		ANDLW		00FH
		MOVWF		TempRam4
		MACRO_RRF_4BIT	buffer4
		MOVFW       buffer4
		andlW		00FH
		MOVWF		TempRam3
	;---
		MOVFW   	buffer3
		ANDLW		00FH
		MOVWF		TempRam2
		MACRO_RRF_4BIT	buffer3
		MOVFW       buffer3
		andlW		00FH
		MOVWF		TempRam1
RETURN

F_AdjustBcd:
		MOVLW       003H
		ADDWF       IND0,W
		BTFSC       WORK,3
		MOVWF       IND0
		MOVLW       030H
		ADDWF       IND0,W
		BTFSC       WORK,7
		MOVWF       IND0

RETURN

		

		