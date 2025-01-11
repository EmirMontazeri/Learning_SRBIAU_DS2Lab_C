
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Tamrin3.c,3 :: 		void interrupt(){
;Tamrin3.c,4 :: 		if(i<10){
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt4
	MOVLW      10
	SUBWF      _i+0, 0
L__interrupt4:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt0
;Tamrin3.c,5 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Tamrin3.c,6 :: 		INTCON.T0IF=0;
	BCF        INTCON+0, 2
;Tamrin3.c,7 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;Tamrin3.c,8 :: 		}else{
	GOTO       L_interrupt1
L_interrupt0:
;Tamrin3.c,9 :: 		portA.f0=~portA.f0;
	MOVLW      1
	XORWF      PORTA+0, 1
;Tamrin3.c,10 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;Tamrin3.c,11 :: 		}
L_interrupt1:
;Tamrin3.c,12 :: 		}
L_end_interrupt:
L__interrupt3:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Tamrin3.c,14 :: 		void main() {
;Tamrin3.c,15 :: 		trisA=0;
	CLRF       TRISA+0
;Tamrin3.c,16 :: 		portA=0;
	CLRF       PORTA+0
;Tamrin3.c,17 :: 		INTCON=0b10100000;
	MOVLW      160
	MOVWF      INTCON+0
;Tamrin3.c,18 :: 		OPTION_REG=7;
	MOVLW      7
	MOVWF      OPTION_REG+0
;Tamrin3.c,19 :: 		TMR0=60;
	MOVLW      60
	MOVWF      TMR0+0
;Tamrin3.c,20 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
