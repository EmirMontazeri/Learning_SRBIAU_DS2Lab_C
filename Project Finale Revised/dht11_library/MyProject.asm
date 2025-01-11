
_dht11_read_byte:

;dht11.c,16 :: 		uint8_t dht11_read_byte()
;dht11.c,18 :: 		uint8_t i = 8, dht11_byte = 0;
	MOVLW      8
	MOVWF      dht11_read_byte_i_L0+0
	CLRF       dht11_read_byte_dht11_byte_L0+0
;dht11.c,20 :: 		while(i--)
L_dht11_read_byte0:
	MOVF       dht11_read_byte_i_L0+0, 0
	MOVWF      R0+0
	DECF       dht11_read_byte_i_L0+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_dht11_read_byte1
;dht11.c,22 :: 		while( !DHT11_PIN );
L_dht11_read_byte2:
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_dht11_read_byte3
	GOTO       L_dht11_read_byte2
L_dht11_read_byte3:
;dht11.c,24 :: 		delay_us(40);
	MOVLW      26
	MOVWF      R13+0
L_dht11_read_byte4:
	DECFSZ     R13+0, 1
	GOTO       L_dht11_read_byte4
	NOP
;dht11.c,26 :: 		if( DHT11_PIN )
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_dht11_read_byte5
;dht11.c,28 :: 		dht11_byte |= (1 << i);   // set bit i
	MOVF       dht11_read_byte_i_L0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__dht11_read_byte21:
	BTFSC      STATUS+0, 2
	GOTO       L__dht11_read_byte22
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__dht11_read_byte21
L__dht11_read_byte22:
	MOVF       R0+0, 0
	IORWF      dht11_read_byte_dht11_byte_L0+0, 1
;dht11.c,29 :: 		while( DHT11_PIN );
L_dht11_read_byte6:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_dht11_read_byte7
	GOTO       L_dht11_read_byte6
L_dht11_read_byte7:
;dht11.c,30 :: 		}
L_dht11_read_byte5:
;dht11.c,31 :: 		}
	GOTO       L_dht11_read_byte0
L_dht11_read_byte1:
;dht11.c,32 :: 		return(dht11_byte);
	MOVF       dht11_read_byte_dht11_byte_L0+0, 0
	MOVWF      R0+0
;dht11.c,33 :: 		}
L_end_dht11_read_byte:
	RETURN
; end of _dht11_read_byte

_dht11_read:

;dht11.c,36 :: 		void dht11_read(uint8_t *dht11_humi, uint8_t *dht11_temp)
;dht11.c,39 :: 		DHT11_PIN     = 0;   // connection pin output low
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;dht11.c,40 :: 		DHT11_PIN_DIR = 0;   // configure connection pin as output
	BCF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;dht11.c,41 :: 		delay_ms(25);        // wait 25 ms
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_dht11_read8:
	DECFSZ     R13+0, 1
	GOTO       L_dht11_read8
	DECFSZ     R12+0, 1
	GOTO       L_dht11_read8
	NOP
;dht11.c,42 :: 		DHT11_PIN     = 1;   // connection pin output high
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;dht11.c,43 :: 		delay_us(30);        // wait 30 us
	MOVLW      19
	MOVWF      R13+0
L_dht11_read9:
	DECFSZ     R13+0, 1
	GOTO       L_dht11_read9
	NOP
	NOP
;dht11.c,44 :: 		DHT11_PIN_DIR = 1;   // configure connection pin as input
	BSF        TRISB0_bit+0, BitPos(TRISB0_bit+0)
;dht11.c,47 :: 		while( DHT11_PIN );
L_dht11_read10:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_dht11_read11
	GOTO       L_dht11_read10
L_dht11_read11:
;dht11.c,48 :: 		while( !DHT11_PIN );
L_dht11_read12:
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_dht11_read13
	GOTO       L_dht11_read12
L_dht11_read13:
;dht11.c,49 :: 		while( DHT11_PIN );
L_dht11_read14:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_dht11_read15
	GOTO       L_dht11_read14
L_dht11_read15:
;dht11.c,52 :: 		*dht11_humi = dht11_read_byte();  // read humidity byte 1
	CALL       _dht11_read_byte+0
	MOVF       FARG_dht11_read_dht11_humi+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;dht11.c,53 :: 		dht11_read_byte();               // read humidity byte 2 (skipped)
	CALL       _dht11_read_byte+0
;dht11.c,54 :: 		*dht11_temp = dht11_read_byte();  // read temperature byte 1
	CALL       _dht11_read_byte+0
	MOVF       FARG_dht11_read_dht11_temp+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;dht11.c,55 :: 		dht11_read_byte();               // read temperature byte 2 (skipped)
	CALL       _dht11_read_byte+0
;dht11.c,56 :: 		dht11_read_byte();               // read checksum (skipped)
	CALL       _dht11_read_byte+0
;dht11.c,58 :: 		}
L_end_dht11_read:
	RETURN
; end of _dht11_read

_main:

;MyProject.c,36 :: 		void main()
;MyProject.c,38 :: 		OSCCON = 0x70;            // set internal oscillator to 8MHz
	MOVLW      112
	MOVWF      OSCCON+0
;MyProject.c,39 :: 		ANSELH = 0;                      // Configure all PORTB pins as digital
	CLRF       ANSELH+0
;MyProject.c,40 :: 		delay_ms(1000);           // wait a second
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	NOP
;MyProject.c,42 :: 		Lcd_Init();               // initialize LCD module
	CALL       _Lcd_Init+0
;MyProject.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,44 :: 		Lcd_Cmd(_LCD_CLEAR);      // clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,46 :: 		while(1)
L_main17:
;MyProject.c,49 :: 		char temp[] = "Temp = 00.0 C";
	MOVLW      84
	MOVWF      main_temp_L1+0
	MOVLW      101
	MOVWF      main_temp_L1+1
	MOVLW      109
	MOVWF      main_temp_L1+2
	MOVLW      112
	MOVWF      main_temp_L1+3
	MOVLW      32
	MOVWF      main_temp_L1+4
	MOVLW      61
	MOVWF      main_temp_L1+5
	MOVLW      32
	MOVWF      main_temp_L1+6
	MOVLW      48
	MOVWF      main_temp_L1+7
	MOVLW      48
	MOVWF      main_temp_L1+8
	MOVLW      46
	MOVWF      main_temp_L1+9
	MOVLW      48
	MOVWF      main_temp_L1+10
	MOVLW      32
	MOVWF      main_temp_L1+11
	MOVLW      67
	MOVWF      main_temp_L1+12
	CLRF       main_temp_L1+13
	MOVLW      72
	MOVWF      main_humi_L1+0
	MOVLW      117
	MOVWF      main_humi_L1+1
	MOVLW      109
	MOVWF      main_humi_L1+2
	MOVLW      105
	MOVWF      main_humi_L1+3
	MOVLW      32
	MOVWF      main_humi_L1+4
	MOVLW      61
	MOVWF      main_humi_L1+5
	MOVLW      32
	MOVWF      main_humi_L1+6
	MOVLW      48
	MOVWF      main_humi_L1+7
	MOVLW      48
	MOVWF      main_humi_L1+8
	MOVLW      46
	MOVWF      main_humi_L1+9
	MOVLW      48
	MOVWF      main_humi_L1+10
	MOVLW      32
	MOVWF      main_humi_L1+11
	MOVLW      37
	MOVWF      main_humi_L1+12
	CLRF       main_humi_L1+13
;MyProject.c,53 :: 		dht11_read(&humidity, &temperature);
	MOVLW      main_humidity_L1+0
	MOVWF      FARG_dht11_read_dht11_humi+0
	MOVLW      main_temperature_L1+0
	MOVWF      FARG_dht11_read_dht11_temp+0
	CALL       _dht11_read+0
;MyProject.c,55 :: 		temp[7]  = temperature / 10  + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_temperature_L1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      main_temp_L1+7
;MyProject.c,56 :: 		temp[8]  = temperature % 10  + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_temperature_L1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      main_temp_L1+8
;MyProject.c,57 :: 		humi[7]  = humidity    / 10  + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_humidity_L1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      main_humi_L1+7
;MyProject.c,58 :: 		humi[8]  = humidity    % 10  + '0';
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_humidity_L1+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      main_humi_L1+8
;MyProject.c,59 :: 		temp[11] = 223;    // put degree symbol (°)
	MOVLW      223
	MOVWF      main_temp_L1+11
;MyProject.c,60 :: 		lcd_out(1, 1, temp);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_temp_L1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,61 :: 		lcd_out(2, 1, humi);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_humi_L1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,63 :: 		delay_ms(1000);  // wait a second
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;MyProject.c,65 :: 		}
	GOTO       L_main17
;MyProject.c,67 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
