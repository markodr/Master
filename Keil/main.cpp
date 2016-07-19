#include "mbed.h"
#include <stdlib.h> 

#define pauza 0.01
#define prag 8
Serial pc(USBTX, USBRX); // tx, rx

// Na ovm piovima se nalaze senzori
AnalogIn   Senzor0(A0);
AnalogIn   Senzor1(A1);
AnalogIn   Senzor2(A2);
AnalogIn   Senzor3(A3);

// Promenljive
float senzori[4];
char prijem[5];
float threshold;

// Sve se salje kao float string 8 bajta odnostno 6 cifara iza nule !!


float recive_data(){
// poslati dva puta da se aktivira Data Ready
	float treshold[4];
	int i;
	float minimum;
// Malo veci buffer za prijem ne koristi se ceo
	char prijem[5]; 
// Brisem stare vrenosti bez ovoga sabira prosle vrednosti
	treshold[0]=0;
	treshold[1]=0;
	treshold[2]=0;
	treshold[3]=0;
	minimum=0;
// Primi jedan karakter 	
	for (i=0;i<=1;i++){
		prijem[i]=pc.getc();	
	}
// Racunam srednju vrednost
	if (prijem[0]=='C'){
			for(i=1;i<=10;i++){
			treshold[0]=treshold[0]+Senzor0.read();
			treshold[1]=treshold[1]+Senzor1.read();
			treshold[2]=treshold[2]+Senzor2.read();
			treshold[3]=treshold[3]+Senzor3.read();	
			}
			treshold[0]=treshold[0]/i;
			treshold[1]=treshold[1]/i;
			treshold[2]=treshold[2]/i;
			treshold[3]=treshold[3]/i;    
// Racunam minimum - pocni od i=1			
	    minimum=treshold[0]; 
			for (i=1;i<=1;i++){
				if (treshold[i]<minimum){
					minimum=treshold[i];
				}
			}
			return minimum;
	}
	else {
		minimum=0;
		return minimum;
	}
}    
void send_data(){
		 int i;
     senzori[0]=Senzor0.read();
     wait(pauza);
     senzori[1]=Senzor1.read();
     wait(pauza);
     senzori[2]=Senzor2.read();
     wait(pauza);
     senzori[3]=Senzor3.read();
     wait(pauza);
     for(i=0;i<=3;i++){
				pc.printf("%f\n",senzori[i]);
      }
     pc.printf("END  END\n");
}
main() {
    
  pc.printf("Hello World !\n");
  while(1) { 
// Salji podatke sa senzora
		send_data();
// Proveri da li je stigao zahtev za treshold
		if( pc.readable()){ 
		threshold=recive_data();
		pc.printf("\nThreshold =%f \n",threshold);
		}
			

  }// While
} // Main

 

    
    
    

    
/*
while(1){
        
        if(Senzor1.read()<=0.5){
            pc.printf("1.000000\n");
            }
        else{
            pc.printf("0.000000\n");
            }    
        wait(pauza);
        
        if(Senzor2.read()<=0.5){
            pc.printf("1.000000\n");
            }
        else{
            pc.printf("0.000000\n");
            }    
        wait(pauza);
        
        if(Senzor3.read()<=0.5){
            pc.printf("1.000000\n");
            }
        else{
            pc.printf("0.000000\n");
            }    
        wait(pauza);
        if(Senzor4.read()<=0.5){
            pc.printf("1.000000\n");
            }
        else{
            pc.printf("0.000000\n");
            }    
        wait(pauza);        

        
        
        pc.printf("END  END\n");
        wait(pauza);
        }
}
*/
        
