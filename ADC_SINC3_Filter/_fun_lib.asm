;=================================================
;==== _FUN_LIB.ASM
;=================================================
F_Delay_100MS:
    MACRO_MOVFL     REG1,100
	GOTO      F_Delay_2
F_Delay_40MS:
    MACRO_MOVFL     REG1,40
	GOTO      F_Delay_2
F_Delay_20MS:
    MACRO_MOVFL     REG1,20
	GOTO      F_Delay_2
F_Delay_10MS:
    MACRO_MOVFL     REG1,10
    GOTO      F_Delay_2
F_Delay_1MS:
    MACRO_MOVFL   REG1,1
F_Delay_2:
    MACRO_MOVFL   REG2,200
F_Delay_2_LOOP:
    CLRWDT
    NOP                           ; 1
    NOP                           ; 1
	NOP                           ; 1
    DECFSZ        REG2,F          ; 1
	GOTO          F_Delay_2_LOOP  ; 1
F_Delay_1:        
    DECFSZ        REG1,F
	GOTO          F_Delay_2
RETURN


