/**************************************************************************************

  Interfacing PIC16F887 microcontroller with DHT11 sensor.
  Humidity (in rH%) and temperature (in °C) are displayed on 16x2 LCD.
  C Code for mikroC PRO for PIC compiler.
  Internal oscillator used @ 8MHz
  Configuration words: CONFIG1 = 0x2CD4
                       CONFIG2 = 0x0700
  This is a free software with NO WARRANTY.
  https://simple-circuit.com/

***************************************************************************************/

// LCD module connections
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
// end LCD module connections

// DHT11 pin connection (here data pin is connected to pin RB0)
#define DHT11_PIN         RB0_bit
#define DHT11_PIN_DIR     TRISB0_bit

#include <DHT11.c>  // include DHT11 driver source file

// main function
void main()
{
  OSCCON = 0x70;            // set internal oscillator to 8MHz
  ANSELH = 0;                      // Configure all PORTB pins as digital
  delay_ms(1000);           // wait a second

  Lcd_Init();               // initialize LCD module
  Lcd_Cmd(_LCD_CURSOR_OFF); // cursor off
  Lcd_Cmd(_LCD_CLEAR);      // clear LCD

  while(1)
  {
    char humidity, temperature;
    char temp[] = "Temp = 00.0 C";
    char humi[] = "Humi = 00.0 %";
    
    // read humidity (in rH%) and temperature (in °C) from the DHT11 sensor
    dht11_read(&humidity, &temperature);
    
    temp[7]  = temperature / 10  + '0';
    temp[8]  = temperature % 10  + '0';
    humi[7]  = humidity    / 10  + '0';
    humi[8]  = humidity    % 10  + '0';
    temp[11] = 223;    // put degree symbol (°)
    lcd_out(1, 1, temp);
    lcd_out(2, 1, humi);

    delay_ms(1000);  // wait a second

  }

}
// end of code.