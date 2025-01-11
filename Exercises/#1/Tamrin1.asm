
_main:

;Tamrin1.c,2 :: 		void main() {
;Tamrin1.c,3 :: 		trisB=0;
	CLRF       TRISB+0
;Tamrin1.c,4 :: 		while (1) {
L_main0:
;Tamrin1.c,5 :: 		for (i=0;i<8;i++){
	CLRF       _i+0
	CLRF       _i+1
L_main2:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVLW      8
	SUBWF      _i+0, 0
L__main11:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;Tamrin1.c,6 :: 		portB=1<<i;
	MOVF       _i+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main12:
	BTFSC      STATUS+0, 2
	GOTO       L__main13
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main12
L__main13:
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;Tamrin1.c,7 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;Tamrin1.c,5 :: 		for (i=0;i<8;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Tamrin1.c,8 :: 		}
	GOTO       L_main2
L_main3:
;Tamrin1.c,9 :: 		for (i=6;i>0;i--){
	MOVLW      6
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main6:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVF       _i+0, 0
	SUBLW      0
L__main14:
	BTFSC      STATUS+0, 0
	GOTO       L_main7
;Tamrin1.c,10 :: 		portB=1<<i;
	MOVF       _i+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main15:
	BTFSC      STATUS+0, 2
	GOTO       L__main16
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main15
L__main16:
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;Tamrin1.c,11 :: 		delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
;Tamrin1.c,9 :: 		for (i=6;i>0;i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;Tamrin1.c,12 :: 		}
	GOTO       L_main6
L_main7:
;Tamrin1.c,13 :: 		}
	GOTO       L_main0
;Tamrin1.c,14 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
