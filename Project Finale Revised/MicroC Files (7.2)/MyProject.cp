#line 1 "C:/Users/monta/Desktop/Project Finale Revised/MicroC Files/MyProject.c"

 sbit LCD_RS at RB2_bit;
 sbit LCD_EN at RB3_bit;
 sbit LCD_D4 at RB4_bit;
 sbit LCD_D5 at RB5_bit;
 sbit LCD_D6 at RB6_bit;
 sbit LCD_D7 at RB7_bit;
 sbit LCD_RS_Direction at TRISB2_bit;
 sbit LCD_EN_Direction at TRISB3_bit;
 sbit LCD_D4_Direction at TRISB4_bit;
 sbit LCD_D5_Direction at TRISB5_bit;
 sbit LCD_D6_Direction at TRISB6_bit;
 sbit LCD_D7_Direction at TRISB7_bit;

 unsigned char Check, T_byte1, T_byte2,
 RH_byte1, RH_byte2, Ch ;
 unsigned Temp, RH, Sum ;
void StartSignal(){
 TRISB.B0 = 0;
 PORTB.B0 = 0;
 delay_ms(18);
 PORTB.B0 = 1;
 delay_us(30);
 TRISB.B0 = 1;
 }

 void CheckResponse(){
 Check = 0;
 delay_us(40);
 if (PORTB.B0 == 0){
 delay_us(80);
 if (PORTB.B0 == 1) Check = 1; delay_us(40);}
 }

 char ReadData(){
 char i, j;
 for(j = 0; j < 8; j++){
 while(!PORTB.B0);
 delay_us(30);
 if(PORTB.B0 == 0)
 i&= ~(1<<(7 - j));
 else {i|= (1 << (7 - j));
 while(PORTB.B0);}
 }
 return i;
 }

void main() {
 TRISD = 0;
 PORTD = 0;
 TRISB.F1 = 0;
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 while(1){
 StartSignal();
 CheckResponse();
 if(Check == 1){
 RH_byte1 = ReadData();
 RH_byte2 = ReadData();
 T_byte1 = ReadData();
 T_byte2 = ReadData();
 Sum = ReadData();
 if(Sum == ((RH_byte1+RH_byte2+T_byte1+T_byte2) & 0XFF)){
 Temp = T_byte1;
 RH = RH_byte1;
 Lcd_Out(1, 2, "Temp:        C");
 Lcd_Out(2, 2, "Hum :        %");
 LCD_Chr(1, 12, 48 + ((Temp / 10) % 10));
 LCD_Chr(1, 13, 48 + (Temp % 10));
 LCD_Chr(2, 12, 48 + ((RH / 10) % 10));
 LCD_Chr(2, 13, 48 + (RH % 10));
 }
 else{
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Check sum error");
 PORTD = 0b10000000;}
 }
 else {
 Lcd_Out(1, 3, "No response");
 Lcd_Out(2, 1, "from the sensor");
 PORTD = 0b10000000;
 }

 if (Temp >= 31) {
 PORTD.f2 = 1;
 PORTD.f3 = 0;
 PORTD.f4 = 0;
 PORTD.f5 = 0;
 PORTD.f6 = 0;
 }
 if ((Temp >= 26) && (Temp <= 30)) {
 PORTD.f2 = 0;
 PORTD.f3 = 1;
 PORTD.f4 = 0;
 PORTD.f5 = 0;
 PORTD.f6 = 0;
 }
 if ((Temp >= 21) && (Temp <= 25)) {
 PORTD.f2 = 0;
 PORTD.f3 = 0;
 PORTD.f4 = 1;
 PORTD.f5 = 0;
 PORTD.f6 = 0;
 }
 if ((Temp >= 16) && (Temp <= 20)) {
 PORTD.f2 = 0;
 PORTD.f3 = 0;
 PORTD.f4 = 0;
 PORTD.f5 = 1;
 PORTD.f6 = 0;
 }
 if (Temp < 16) {
 PORTD.f2 = 0;
 PORTD.f3 = 0;
 PORTD.f4 = 0;
 PORTD.f5 = 0;
 PORTD.f6 = 1;
 }
 if (RH > 60) {
 PORTD.f1 = 1;
 PORTD.f0 = 0;
 delay_ms(1000);
 }
 if ((RH <= 60) && (RH >= 40)) {
 PORTD.f1 = 0;
 PORTD.f0 = 0;
 delay_ms(1000);
 }
 if (RH < 40) {
 PORTD.f1 = 0;
 PORTD.f0 = 1;
 delay_ms(1000);

 }

 delay_ms(1000);
 }
}
