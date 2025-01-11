sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D7 at RB5_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D4 at RB2_bit;

sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D7_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB2_bit;

char i;

void main() {
Lcd_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);
while(1){
for(i=0; i<38; i++) {
Lcd_out(1, 17, "Emir MN 39912340119138");
Lcd_Cmd(_LCD_SHIFT_LEFT);
delay_ms(300);
}
Lcd_Cmd(_LCD_CLEAR);
for(i=38;i<76;i++){
Lcd_out(2, 17, "Emir MN 39912340119138");
Lcd_Cmd(_LCD_SHIFT_LEFT);
delay_ms(300);
}
Lcd_Cmd(_LCD_CLEAR);
}
}