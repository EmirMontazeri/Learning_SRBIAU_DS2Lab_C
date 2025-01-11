
_StartSignal:

;MyProject.c,18 :: 		void StartSignal(){
;MyProject.c,19 :: 		TRISB.B0 = 0; //Configure RD0 as output
	BCF        TRISB+0, 0
;MyProject.c,20 :: 		PORTB.B0 = 0; //RD0 sends 0 to the sensor
	BCF        PORTB+0, 0
;MyProject.c,21 :: 		delay_ms(18);
	MOVLW      47
	MOVWF      R12+0
	MOVLW      191
	MOVWF      R13+0
L_StartSignal0:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal0
	DECFSZ     R12+0, 1
	GOTO       L_StartSignal0
	NOP
	NOP
;MyProject.c,22 :: 		PORTB.B0 = 1; //RD0 sends 1 to the sensor
	BSF        PORTB+0, 0
;MyProject.c,23 :: 		delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_StartSignal1:
	DECFSZ     R13+0, 1
	GOTO       L_StartSignal1
	NOP
	NOP
;MyProject.c,24 :: 		TRISB.B0 = 1; //Configure RD0 as input
	BSF        TRISB+0, 0
;MyProject.c,25 :: 		}
L_end_StartSignal:
	RETURN
; end of _StartSignal

_CheckResponse:

;MyProject.c,27 :: 		void CheckResponse(){
;MyProject.c,28 :: 		Check = 0;
	CLRF       _Check+0
;MyProject.c,29 :: 		delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_CheckResponse2:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse2
	NOP
;MyProject.c,30 :: 		if (PORTB.B0 == 0){
	BTFSC      PORTB+0, 0
	GOTO       L_CheckResponse3
;MyProject.c,31 :: 		delay_us(80);
	MOVLW      53
	MOVWF      R13+0
L_CheckResponse4:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse4
;MyProject.c,32 :: 		if (PORTB.B0 == 1) Check = 1; delay_us(40);}
	BTFSS      PORTB+0, 0
	GOTO       L_CheckResponse5
	MOVLW      1
	MOVWF      _Check+0
L_CheckResponse5:
	MOVLW      26
	MOVWF      R13+0
L_CheckResponse6:
	DECFSZ     R13+0, 1
	GOTO       L_CheckResponse6
	NOP
L_CheckResponse3:
;MyProject.c,33 :: 		}
L_end_CheckResponse:
	RETURN
; end of _CheckResponse

_ReadData:

;MyProject.c,35 :: 		char ReadData(){
;MyProject.c,37 :: 		for(j = 0; j < 8; j++){
	CLRF       R3+0
L_ReadData7:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ReadData8
;MyProject.c,38 :: 		while(!PORTB.B0); //Wait until PORTD.F0 goes HIGH
L_ReadData10:
	BTFSC      PORTB+0, 0
	GOTO       L_ReadData11
	GOTO       L_ReadData10
L_ReadData11:
;MyProject.c,39 :: 		delay_us(30);
	MOVLW      19
	MOVWF      R13+0
L_ReadData12:
	DECFSZ     R13+0, 1
	GOTO       L_ReadData12
	NOP
	NOP
;MyProject.c,40 :: 		if(PORTB.B0 == 0)
	BTFSC      PORTB+0, 0
	GOTO       L_ReadData13
;MyProject.c,41 :: 		i&= ~(1<<(7 - j)); //Clear bit (7-b)
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData50:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData51
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData50
L__ReadData51:
	COMF       R0+0, 1
	MOVF       R0+0, 0
	ANDWF      R2+0, 1
	GOTO       L_ReadData14
L_ReadData13:
;MyProject.c,42 :: 		else {i|= (1 << (7 - j)); //Set bit (7-b)
	MOVF       R3+0, 0
	SUBLW      7
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__ReadData52:
	BTFSC      STATUS+0, 2
	GOTO       L__ReadData53
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__ReadData52
L__ReadData53:
	MOVF       R0+0, 0
	IORWF      R2+0, 1
;MyProject.c,43 :: 		while(PORTB.B0);} //Wait until PORTD.F0 goes LOW
L_ReadData15:
	BTFSS      PORTB+0, 0
	GOTO       L_ReadData16
	GOTO       L_ReadData15
L_ReadData16:
L_ReadData14:
;MyProject.c,37 :: 		for(j = 0; j < 8; j++){
	INCF       R3+0, 1
;MyProject.c,44 :: 		}
	GOTO       L_ReadData7
L_ReadData8:
;MyProject.c,45 :: 		return i;
	MOVF       R2+0, 0
	MOVWF      R0+0
;MyProject.c,46 :: 		}
L_end_ReadData:
	RETURN
; end of _ReadData

_main:

;MyProject.c,48 :: 		void main() {
;MyProject.c,49 :: 		TRISD = 0;        // Configure Port D as output
	CLRF       TRISD+0
;MyProject.c,50 :: 		PORTD = 0;        // Initialize Port D
	CLRF       PORTD+0
;MyProject.c,51 :: 		TRISB.F1 = 0;
	BCF        TRISB+0, 1
;MyProject.c,52 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,53 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,54 :: 		Lcd_Cmd(_LCD_CLEAR); // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,55 :: 		while(1){
L_main17:
;MyProject.c,56 :: 		StartSignal();
	CALL       _StartSignal+0
;MyProject.c,57 :: 		CheckResponse();
	CALL       _CheckResponse+0
;MyProject.c,58 :: 		if(Check == 1){
	MOVF       _Check+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;MyProject.c,59 :: 		RH_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte1+0
;MyProject.c,60 :: 		RH_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _RH_byte2+0
;MyProject.c,61 :: 		T_byte1 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte1+0
;MyProject.c,62 :: 		T_byte2 = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _T_byte2+0
;MyProject.c,63 :: 		Sum = ReadData();
	CALL       _ReadData+0
	MOVF       R0+0, 0
	MOVWF      _Sum+0
	CLRF       _Sum+1
;MyProject.c,64 :: 		if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF)){
	MOVF       _RH_byte2+0, 0
	ADDWF      _RH_byte1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte1+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       _T_byte2+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      255
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	MOVLW      0
	ANDWF      R2+1, 1
	MOVF       _Sum+1, 0
	XORWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVF       R2+0, 0
	XORWF      _Sum+0, 0
L__main55:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;MyProject.c,65 :: 		Temp = T_byte1;
	MOVF       _T_byte1+0, 0
	MOVWF      _Temp+0
	CLRF       _Temp+1
;MyProject.c,66 :: 		RH = RH_byte1;
	MOVF       _RH_byte1+0, 0
	MOVWF      _RH+0
	CLRF       _RH+1
;MyProject.c,67 :: 		Lcd_Out(1, 2, "Temp:        C");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,68 :: 		Lcd_Out(2, 2, "Hum :        %");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,69 :: 		LCD_Chr(1, 12, 48 + ((Temp / 10) % 10));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,70 :: 		LCD_Chr(1, 13, 48 + (Temp % 10));
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,71 :: 		LCD_Chr(2, 12, 48 + ((RH / 10) % 10));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,72 :: 		LCD_Chr(2, 13, 48 + (RH % 10));
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _RH+0, 0
	MOVWF      R0+0
	MOVF       _RH+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,73 :: 		}
	GOTO       L_main21
L_main20:
;MyProject.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,76 :: 		Lcd_Cmd(_LCD_CLEAR); // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,77 :: 		Lcd_Out(1, 1, "Check sum error");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,78 :: 		PORTD = 0b10000000;}
	MOVLW      128
	MOVWF      PORTD+0
L_main21:
;MyProject.c,79 :: 		}
	GOTO       L_main22
L_main19:
;MyProject.c,81 :: 		Lcd_Out(1, 3, "No response");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,82 :: 		Lcd_Out(2, 1, "from the sensor");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,83 :: 		PORTD = 0b10000000;
	MOVLW      128
	MOVWF      PORTD+0
;MyProject.c,84 :: 		}
L_main22:
;MyProject.c,86 :: 		if (Temp  >= 31)  {
	MOVLW      0
	SUBWF      _Temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      31
	SUBWF      _Temp+0, 0
L__main56:
	BTFSS      STATUS+0, 0
	GOTO       L_main23
;MyProject.c,87 :: 		PORTD.f2 = 1;
	BSF        PORTD+0, 2
;MyProject.c,88 :: 		PORTD.f3 = 0;
	BCF        PORTD+0, 3
;MyProject.c,89 :: 		PORTD.f4 = 0;
	BCF        PORTD+0, 4
;MyProject.c,90 :: 		PORTD.f5 = 0;
	BCF        PORTD+0, 5
;MyProject.c,91 :: 		PORTD.f6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,92 :: 		}
L_main23:
;MyProject.c,93 :: 		if ((Temp >= 26) && (Temp <= 30)) {
	MOVLW      0
	SUBWF      _Temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      26
	SUBWF      _Temp+0, 0
L__main57:
	BTFSS      STATUS+0, 0
	GOTO       L_main26
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVF       _Temp+0, 0
	SUBLW      30
L__main58:
	BTFSS      STATUS+0, 0
	GOTO       L_main26
L__main46:
;MyProject.c,94 :: 		PORTD.f2 = 0;
	BCF        PORTD+0, 2
;MyProject.c,95 :: 		PORTD.f3 = 1;
	BSF        PORTD+0, 3
;MyProject.c,96 :: 		PORTD.f4 = 0;
	BCF        PORTD+0, 4
;MyProject.c,97 :: 		PORTD.f5 = 0;
	BCF        PORTD+0, 5
;MyProject.c,98 :: 		PORTD.f6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,99 :: 		}
L_main26:
;MyProject.c,100 :: 		if ((Temp >= 21) && (Temp <= 25)) {
	MOVLW      0
	SUBWF      _Temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      21
	SUBWF      _Temp+0, 0
L__main59:
	BTFSS      STATUS+0, 0
	GOTO       L_main29
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVF       _Temp+0, 0
	SUBLW      25
L__main60:
	BTFSS      STATUS+0, 0
	GOTO       L_main29
L__main45:
;MyProject.c,101 :: 		PORTD.f2 = 0;
	BCF        PORTD+0, 2
;MyProject.c,102 :: 		PORTD.f3 = 0;
	BCF        PORTD+0, 3
;MyProject.c,103 :: 		PORTD.f4 = 1;
	BSF        PORTD+0, 4
;MyProject.c,104 :: 		PORTD.f5 = 0;
	BCF        PORTD+0, 5
;MyProject.c,105 :: 		PORTD.f6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,106 :: 		}
L_main29:
;MyProject.c,107 :: 		if ((Temp >= 16) && (Temp <= 20)) {
	MOVLW      0
	SUBWF      _Temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      16
	SUBWF      _Temp+0, 0
L__main61:
	BTFSS      STATUS+0, 0
	GOTO       L_main32
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVF       _Temp+0, 0
	SUBLW      20
L__main62:
	BTFSS      STATUS+0, 0
	GOTO       L_main32
L__main44:
;MyProject.c,108 :: 		PORTD.f2 = 0;
	BCF        PORTD+0, 2
;MyProject.c,109 :: 		PORTD.f3 = 0;
	BCF        PORTD+0, 3
;MyProject.c,110 :: 		PORTD.f4 = 0;
	BCF        PORTD+0, 4
;MyProject.c,111 :: 		PORTD.f5 = 1;
	BSF        PORTD+0, 5
;MyProject.c,112 :: 		PORTD.f6 = 0;
	BCF        PORTD+0, 6
;MyProject.c,113 :: 		}
L_main32:
;MyProject.c,114 :: 		if (Temp < 16)  {
	MOVLW      0
	SUBWF      _Temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      16
	SUBWF      _Temp+0, 0
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main33
;MyProject.c,115 :: 		PORTD.f2 = 0;
	BCF        PORTD+0, 2
;MyProject.c,116 :: 		PORTD.f3 = 0;
	BCF        PORTD+0, 3
;MyProject.c,117 :: 		PORTD.f4 = 0;
	BCF        PORTD+0, 4
;MyProject.c,118 :: 		PORTD.f5 = 0;
	BCF        PORTD+0, 5
;MyProject.c,119 :: 		PORTD.f6 = 1;
	BSF        PORTD+0, 6
;MyProject.c,120 :: 		}
L_main33:
;MyProject.c,121 :: 		if (RH > 60)  {
	MOVF       _RH+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVF       _RH+0, 0
	SUBLW      60
L__main64:
	BTFSC      STATUS+0, 0
	GOTO       L_main34
;MyProject.c,122 :: 		PORTD.f1 = 1;
	BSF        PORTD+0, 1
;MyProject.c,123 :: 		PORTD.f0 = 0;
	BCF        PORTD+0, 0
;MyProject.c,124 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;MyProject.c,125 :: 		}
L_main34:
;MyProject.c,126 :: 		if ((RH <= 60) && (RH >= 40)) {
	MOVF       _RH+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _RH+0, 0
	SUBLW      60
L__main65:
	BTFSS      STATUS+0, 0
	GOTO       L_main38
	MOVLW      0
	SUBWF      _RH+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      40
	SUBWF      _RH+0, 0
L__main66:
	BTFSS      STATUS+0, 0
	GOTO       L_main38
L__main43:
;MyProject.c,127 :: 		PORTD.f1 = 0;
	BCF        PORTD+0, 1
;MyProject.c,128 :: 		PORTD.f0 = 0;
	BCF        PORTD+0, 0
;MyProject.c,129 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;MyProject.c,130 :: 		}
L_main38:
;MyProject.c,131 :: 		if (RH < 40) {
	MOVLW      0
	SUBWF      _RH+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVLW      40
	SUBWF      _RH+0, 0
L__main67:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
;MyProject.c,132 :: 		PORTD.f1 = 0;
	BCF        PORTD+0, 1
;MyProject.c,133 :: 		PORTD.f0 = 1;
	BSF        PORTD+0, 0
;MyProject.c,134 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;MyProject.c,136 :: 		}
L_main40:
;MyProject.c,138 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main42:
	DECFSZ     R13+0, 1
	GOTO       L_main42
	DECFSZ     R12+0, 1
	GOTO       L_main42
	DECFSZ     R11+0, 1
	GOTO       L_main42
	NOP
	NOP
;MyProject.c,139 :: 		}
	GOTO       L_main17
;MyProject.c,140 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
