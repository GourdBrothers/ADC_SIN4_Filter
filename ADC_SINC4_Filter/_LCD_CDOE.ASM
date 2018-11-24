;=========================================
;==== _LCD_CDOE.ASM
;=========================================
    SEG_A       EQU       00010000B
    SEG_B       EQU       00100000B
    SEG_C       EQU       01000000B
    SEG_F       EQU       00000001B
    SEG_G       EQU       00000010B
    SEG_E       EQU       00000100B
    SEG_D       EQU       00001000B

	Lcdch0      EQU       SEG_A+SEG_B+SEG_C+SEG_D+SEG_E+SEG_F
	Lcdch1	    EQU       SEG_B+SEG_C
	Lcdch2	    EQU       SEG_A+SEG_B+SEG_D+SEG_E+SEG_G
	Lcdch3	    EQU       SEG_A+SEG_B+SEG_C+SEG_D+SEG_G
	Lcdch4	    EQU       SEG_B+SEG_C+SEG_F+SEG_G
	Lcdch5	    EQU       SEG_A+SEG_C+SEG_D+SEG_F+SEG_G
	Lcdch6	    EQU       SEG_A+SEG_C+SEG_D+SEG_E+SEG_F+SEG_G
	Lcdch7	    EQU       SEG_A+SEG_B+SEG_C
	Lcdch8	    EQU       SEG_A+SEG_B+SEG_C+SEG_D+SEG_E+SEG_F+SEG_G
	Lcdch9	    EQU       SEG_A+SEG_B+SEG_C+SEG_D+SEG_F+SEG_G
	LcdchNo	    EQU       00H
	LcdchA	    EQU       SEG_A+SEG_B+SEG_C+SEG_E+SEG_F+SEG_G
	Lcdchb	    EQU       SEG_C+SEG_D+SEG_E+SEG_F+SEG_G
	LcdchC	    EQU       SEG_A+SEG_D+SEG_E+SEG_F
	Lcdchd	    EQU       SEG_B+SEG_C+SEG_D+SEG_E+SEG_G
	LcdchE	    EQU       SEG_A+SEG_D+SEG_E+SEG_F+SEG_G
	LcdchF	    EQU       SEG_A+SEG_E+SEG_F+SEG_G
	LcdchH      EQU       SEG_B+SEG_C+SEG_E+SEG_F+SEG_G
	LcdchL	    EQU       SEG_D+SEG_E+SEG_F
	LcdchN	    EQU       SEG_A+SEG_B+SEG_C+SEG_E+SEG_F
	Lcdcho	    EQU       SEG_C+SEG_D+SEG_E+SEG_G
	LcdchP	    EQU       SEG_A+SEG_B+SEG_E+SEG_F+SEG_G
	Lcdchr	    EQU       SEG_E+SEG_G
	LcdchT	    EQU       SEG_D+SEG_E+SEG_F+SEG_G
	LcdchU	    EQU       SEG_B+SEG_C+SEG_D+SEG_E+SEG_F
	LcdchBar    EQU       SEG_G

	Disp_No     EQU       10
;=========================================



_Lcd_Num:
    ADDPCW
    RETLW    Lcdch0
    RETLW    Lcdch1
    RETLW    Lcdch2
    RETLW    Lcdch3
    RETLW    Lcdch4
    RETLW    Lcdch5
    RETLW    Lcdch6
    RETLW    Lcdch7
    RETLW    Lcdch8
    RETLW    Lcdch9
    RETLW    LcdchNo
	
Fun_LCD_Config:
   MOVLW          00001010B   ; 3.0V , 50K REF
   DW             0FFFFH
   DW             0FFFFH
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          NETD
   MOVLW          10100111B   ; 1/3 BIAS, 1/4 DUTY
   DW             0FFFFH
   DW             0FFFFH
   DW             0FFFFH
   DW             0FFFFH
   NOP
   MOVWF          LCDENR
RETURN

_LCDBUF_SET_ALL:
    MOVLW    0FFH
    GOTO     _LCDBUF_BUF_COMM
_LCDBUF_CLR_ALL:
    MOVLW    000H
_LCDBUF_BUF_COMM:
    MOVWF    Display1
    MOVWF    Display2
    MOVWF    Display3
    MOVWF    Display4
    MOVWF    Display5
    MOVWF    Display6
RETURN


_LCDBUF_LOAD_LCD:
    MACRO_MOVFF       LCD4,  Display1
    MACRO_RRF_4BIT    Display1
	MACRO_MOVFF       LCD5,  Display1

    MACRO_MOVFF       LCD6,  Display2
    MACRO_RRF_4BIT    Display2
	MACRO_MOVFF       LCD7,  Display2

    MACRO_MOVFF       LCD8,  Display3
    MACRO_RRF_4BIT    Display3
	MACRO_MOVFF       LCD9,  Display3

    MACRO_MOVFF       LCD10,  Display4
    MACRO_RRF_4BIT    Display4
	MACRO_MOVFF       LCD11,  Display4
	
    MACRO_MOVFF       LCD1,  Display5
    MACRO_RRF_4BIT    Display5
	MACRO_MOVFF       LCD12, Display5
	
    MACRO_MOVFF       LCD2,  Display6
    MACRO_RRF_4BIT    Display6
	MACRO_MOVFF       LCD3,  Display6

RETURN


_LCD_GetNumCode:

    MOVFW            TempRam3
    CALL             _Lcd_Num
	IORWF            Display1,F

    MOVFW            TempRam4
    CALL             _Lcd_Num
	IORWF            Display2,F

    MOVFW            TempRam5
    CALL             _Lcd_Num
	IORWF            Display3,F

    MOVFW            TempRam6
    CALL             _Lcd_Num
	IORWF            Display4,F

RETURN
