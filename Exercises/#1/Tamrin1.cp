#line 1 "D:/User Files/Documents/University/Sem 7/Tamrin 1/Tamrin1.c"
int i;
void main() {
trisB=0;
while (1) {
for (i=0;i<8;i++){
portB=1<<i;
delay_ms(200);
}
for (i=6;i>0;i--){
portB=1<<i;
delay_ms(200);
}
}
}
