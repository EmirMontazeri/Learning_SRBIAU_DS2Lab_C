#line 1 "D:/User Files/Downloads/Compressed/1229_dht11_humidity_and_temperature_sensor_mikroc_library_v2.0.0.0/dht11_library/MyProject.c"
#line 15 "D:/User Files/Downloads/Compressed/1229_dht11_humidity_and_temperature_sensor_mikroc_library_v2.0.0.0/dht11_library/MyProject.c"
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD2_bit;
sbit LCD_D5 at RD3_bit;
sbit LCD_D6 at RD4_bit;
sbit LCD_D7 at RD5_bit;
sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD2_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D7_Direction at TRISD5_bit;
#line 1 "d:/user files/downloads/compressed/1229_dht11_humidity_and_temperature_sensor_mikroc_library_v2.0.0.0/dht11_library/dht11.c"
#line 1 "c:/program files/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 16 "d:/user files/downloads/compressed/1229_dht11_humidity_and_temperature_sensor_mikroc_library_v2.0.0.0/dht11_library/dht11.c"
uint8_t dht11_read_byte()
{
 uint8_t i = 8, dht11_byte = 0;

 while(i--)
 {
 while( ! RB0_bit  );

 delay_us(40);

 if(  RB0_bit  )
 {
 dht11_byte |= (1 << i);
 while(  RB0_bit  );
 }
 }
 return(dht11_byte);
}


void dht11_read(uint8_t *dht11_humi, uint8_t *dht11_temp)
{

  RB0_bit  = 0;
  TRISB0_bit  = 0;
 delay_ms(25);
  RB0_bit  = 1;
 delay_us(30);
  TRISB0_bit  = 1;


 while(  RB0_bit  );
 while( ! RB0_bit  );
 while(  RB0_bit  );


 *dht11_humi = dht11_read_byte();
 dht11_read_byte();
 *dht11_temp = dht11_read_byte();
 dht11_read_byte();
 dht11_read_byte();

}
#line 36 "D:/User Files/Downloads/Compressed/1229_dht11_humidity_and_temperature_sensor_mikroc_library_v2.0.0.0/dht11_library/MyProject.c"
void main()
{
 OSCCON = 0x70;
 ANSELH = 0;
 delay_ms(1000);

 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);

 while(1)
 {
 char humidity, temperature;
 char temp[] = "Temp = 00.0 C";
 char humi[] = "Humi = 00.0 %";


 dht11_read(&humidity, &temperature);

 temp[7] = temperature / 10 + '0';
 temp[8] = temperature % 10 + '0';
 humi[7] = humidity / 10 + '0';
 humi[8] = humidity % 10 + '0';
 temp[11] = 223;
 lcd_out(1, 1, temp);
 lcd_out(2, 1, humi);

 delay_ms(1000);

 }

}
