
_main:

;Tamrin2.c,2 :: 		void main() {
;Tamrin2.c,3 :: 		trisA = 0b11111111;
	MOVLW      255
	MOVWF      TRISA+0
;Tamrin2.c,4 :: 		trisB = 0b00000000;
	CLRF       TRISB+0
;Tamrin2.c,6 :: 		do {
L_main0:
;Tamrin2.c,7 :: 		if (portA.f0==0){
	BTFSC      PORTA+0, 0
	GOTO       L_main3
;Tamrin2.c,8 :: 		for(i=0;i<5;i++){
	CLRF       _i+0
	CLRF       _i+1
L_main4:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      5
	SUBWF      _i+0, 0
L__main26:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
;Tamrin2.c,9 :: 		if (i==1||i==3||i==5){
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      1
	XORWF      _i+0, 0
L__main27:
	BTFSC      STATUS+0, 2
	GOTO       L__main24
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVLW      3
	XORWF      _i+0, 0
L__main28:
	BTFSC      STATUS+0, 2
	GOTO       L__main24
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      5
	XORWF      _i+0, 0
L__main29:
	BTFSC      STATUS+0, 2
	GOTO       L__main24
	GOTO       L_main9
L__main24:
;Tamrin2.c,10 :: 		portB = 0b01010101;}
	MOVLW      85
	MOVWF      PORTB+0
	GOTO       L_main10
L_main9:
;Tamrin2.c,11 :: 		else {portB = 0b10101010;}
	MOVLW      170
	MOVWF      PORTB+0
L_main10:
;Tamrin2.c,12 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
;Tamrin2.c,8 :: 		for(i=0;i<5;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Tamrin2.c,13 :: 		}
	GOTO       L_main4
L_main5:
;Tamrin2.c,14 :: 		}else if (portA.f1==0){
	GOTO       L_main12
L_main3:
	BTFSC      PORTA+0, 1
	GOTO       L_main13
;Tamrin2.c,15 :: 		for(i=0;i<5;i++){
	CLRF       _i+0
	CLRF       _i+1
L_main14:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      5
	SUBWF      _i+0, 0
L__main30:
	BTFSC      STATUS+0, 0
	GOTO       L_main15
;Tamrin2.c,16 :: 		if (i==1||i==3||i==5){
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      1
	XORWF      _i+0, 0
L__main31:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVLW      3
	XORWF      _i+0, 0
L__main32:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      5
	XORWF      _i+0, 0
L__main33:
	BTFSC      STATUS+0, 2
	GOTO       L__main23
	GOTO       L_main19
L__main23:
;Tamrin2.c,17 :: 		portB = 0b11001100;}
	MOVLW      204
	MOVWF      PORTB+0
	GOTO       L_main20
L_main19:
;Tamrin2.c,18 :: 		else {portB = 0b00110011;}
	MOVLW      51
	MOVWF      PORTB+0
L_main20:
;Tamrin2.c,19 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
;Tamrin2.c,15 :: 		for(i=0;i<5;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Tamrin2.c,20 :: 		}
	GOTO       L_main14
L_main15:
;Tamrin2.c,21 :: 		}
	GOTO       L_main22
L_main13:
;Tamrin2.c,22 :: 		else {portB = 0b11111111;}
	MOVLW      255
	MOVWF      PORTB+0
L_main22:
L_main12:
;Tamrin2.c,23 :: 		}while(1);
	GOTO       L_main0
;Tamrin2.c,24 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
