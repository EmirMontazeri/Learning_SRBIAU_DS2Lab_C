#line 1 "D:/User Files/Documents/University/Sem 7/Tamrin 3/Tamrin3.c"
int i=0;

void interrupt(){
if(i<10){
i++;
INTCON.T0IF=0;
TMR0=60;
}else{
portA.f0=~portA.f0;
i=0;
}
}

void main() {
trisA=0;
portA=0;
INTCON=0b10100000;
OPTION_REG=7;
TMR0=60;
}
