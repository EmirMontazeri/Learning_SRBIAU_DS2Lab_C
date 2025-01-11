int i;
void main() {
trisA = 0b11111111;
trisB = 0b00000000;

do {
if (portA.f0==0){
for(i=0;i<5;i++){
if (i==1||i==3||i==5){
portB = 0b01010101;}
else {portB = 0b10101010;}
delay_ms(300);
}
}else if (portA.f1==0){
for(i=0;i<5;i++){
if (i==1||i==3||i==5){
portB = 0b11001100;}
else {portB = 0b00110011;}
delay_ms(300);
}
}
else {portB = 0b11111111;}
}while(1);
}