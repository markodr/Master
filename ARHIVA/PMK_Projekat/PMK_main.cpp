#include "mbed.h"
#include "string.h" 
#include "DS1820.h"
#include "NOKIA_5110.h"
#include "ESP8266.h"
#include "MS5803_14BA.h"

#define SEMPLOVI       100
#define semplovanje 2.0
#define sound_period 0.3
#define countdown 30

// Ovo je deo iz biblioteke
#ifdef TARGET_K64F
 #define SPI_SCK     PTD1
 #define SPI_MOSI    PTD2
 #define SPI_MISO    PTD3
 #define SPI_CS      PTD0
 #define I2C_SDA     PTE25
 #define I2C_SCL     PTE24
#elif defined(TARGET_KL25Z)
 #define SPI_SCK     PTD1
 #define SPI_MOSI    PTD2
 #define SPI_MISO    PTD3
 #define SPI_CS      PTD0
 #define I2C_SDA     PTE0
 #define I2C_SCL     PTE1
#endif



InterruptIn mybutton(USER_BUTTON);
DigitalOut myled(LED1); // Neki pin treba da zasvetli 
Serial pc(SERIAL_TX, SERIAL_RX);
Serial esp(PA_11,PA_12); // Ne moze na SERIAL 2, koristi ih za vezu sa racunarom !!!
Serial hc04(PA_9,PA_10);
AnalogIn analog_value(PA_0);
MS5803_14BA  ps(D14, D15, MS5803_ADDRC_H, D1_OSR_4096, D2_OSR_4096); // High postavljen pin
DS1820 probe(D3);   
PwmOut sound(PC_8);
Ticker flipper;
Timer t;

int time_sec=countdown;
int time_min=0;
int adc_i=0; 
float adc_merenja[SEMPLOVI];
float temp_merenja[SEMPLOVI];
float pressure_presure[SEMPLOVI];
float pressure_temperature[SEMPLOVI];

// Koristi se za update displeja i pakovanje svih semplova u niz
float adc_tmp;
float tmp_temp;
float average_tmp;
float average_adc;
float average_presure;
float average_presure_temp;
bool update_now=0;
char str_time[40];
char str_min[20];
char str_sec[20];
char str_average_tmp[20];
char str_average_adc[20];
char str_average_presure[20];
char str_average_presure_temp[20];

// Ovo je za ESP8266
char povezi_ap[50]; // Mora ovako jer je ovo prokleti C
char povezi_sajt[128];

char esp_str[1024]; // Funkcija koja prima podatke radi clear promenljive

//char ssid[32] = "Supplyframe-BG-T";     
//char pwd [32] = "798BJGRE"; 

//char ssid[32] = "Plati Pa Klati";     
//char pwd [32] = "Yv7dAt7K1";

char ssid[32] = "SupplyFrame-JNP";     
char pwd [32] = "feverSTB15";  

char url[128];
char location_url[23]="http://ip-api.com/json";


void esp_read(){ // Cita response sa WiFi ESP modula
    // Samo vrti dok se ne primi odgovor.
    memset(esp_str,0,strlen(esp_str));
    int i_tp2=0;  
    unsigned long i=0; 
    
    for(i=0; i<=10000000; i++){ // ZNACI OBAVEZNO SA TIMER-om !!! Ovo je privremeno resenje (prototip)        
        if(esp.readable()) {
            esp_str[i_tp2]=esp.getc();
            i_tp2+=1;
            }
    }
    //pc.printf(esp_str);    
}
void flip() { // Prekidna rutina systick tajmera
// Konverzija pritiska !!!
    ps.convert();

	// ADC merenje
    adc_tmp=analog_value.read_u16()* 3.3 /65535;
    adc_merenja[adc_i]=adc_tmp;

	// Temp merenje
    probe.convertTemperature(true);
    tmp_temp=probe.temperature();         
    temp_merenja[adc_i]=tmp_temp;

	// Merenje pritiska
    pressure_presure[adc_i]=ps.getPressure();

	// Merenje temperature pritiska
    pressure_temperature[adc_i]=ps.getTemperature();
        
    adc_i+=1;

// Nova merenja ce pregaziti stara
    if (adc_i>=SEMPLOVI){
        adc_i=0;
        } 
    
    // Ovo skida/dodaje sekunde posto koristimo SW tajmer
    time_sec-=3;
}
void reed_switch_esp() { // Prekidna rutina za taster 


		flipper.detach(); 
    //sound=sound_period;
    average_tmp=0;
    average_adc=0;
    average_presure=0;
    average_presure_temp=0;
// Zaustavi merenje - systick tajmer (ADC,DS1820S)    

    int i;
// Upali LED & REED
    myled=1;
    pc.printf("\nSending average of %d samples\n", adc_i); 
    for(i=0; i<adc_i; i+=1)
        {
        //pc.printf("ADC:%f\n DS1820:%3.1f C\n MS5803_P:%f\n MS5803_T:%3.1f C\n", adc_merenja[i],temp_merenja[i],pressure_presure[i],pressure_temperature[i]);
        //hc04.printf("ADC:%f\n DS1820:%3.1f C\n MS5803_P:%f\n MS5803_T:%3.1f C\n", adc_merenja[i],temp_merenja[i],pressure_presure[i],pressure_temperature[i]);
                    
        average_tmp+=temp_merenja[i];
        average_adc+=adc_merenja[i];
        average_presure+=pressure_presure[i];
        average_presure_temp+=pressure_temperature[i];
               
        }
    
    adc_i=0;
// Izracunaj srednju vrednost    
    average_tmp=average_tmp/i;
    average_adc=average_adc/i;
    average_presure=average_presure/i;
    average_presure_temp=average_presure_temp/i;
// Konvertuj srednje vrednosti u string zbog url enkodovanja    
    sprintf(str_average_tmp,  "%3.2f", average_tmp);
    sprintf(str_average_adc,  "%3.2f", average_adc);
    sprintf(str_average_presure,  "%3.2f", average_presure);
    sprintf(str_average_presure_temp,  "%3.2f", average_presure_temp);
// Ispisi srednje vrednosti
    hc04.printf("\nSensor data (average)\n");
    hc04.printf("\n");
    hc04.printf("\nDS1820  C  : %f",average_tmp);
    hc04.printf("\n");
    hc04.printf("\nADC   V    : %f",average_adc);
    hc04.printf("\n");
    hc04.printf("\nMS5803 bar : %f",average_presure);
    hc04.printf("\n");
    hc04.printf("\nMS5803  C  : %f",average_presure_temp);
    hc04.printf("\n");
// Napravi URL    
    strcpy(url, "GET /update.html?key=ENEW0YDAD7LQL7EE&field1=");
    strcat(url, str_average_tmp);//str_average_tmp
    strcat(url, "&field2=");
    strcat(url, str_average_adc); //str_average_adc
    strcat(url, "&field3=");
    strcat(url, str_average_presure);//str_average_presure
    strcat(url, "&field4=");
    strcat(url, str_average_presure_temp); //str_average_presure_temp
    strcat(url, " HTTP/1.1\r\nHost: 184.106.153.149\r\n\r\n");
// Pucaj na ThingsSpeak 
    esp.printf("AT+CIPSTART=\"TCP\",\"184.106.153.149\", 80\r\n");
    wait(1);
    esp.printf("AT+CIPSEND=250\r\n");
    wait(1);
    esp.printf(url);
    wait(1);
    pc.printf("\n");
    pc.printf(url); 
    myled=0; 
    sound=0;
// Pokreni merenje - systick tajmer (ADC,DS1820S)   
    flipper.attach(&flip, semplovanje); 
}

int main(){ // Main loop
// Podesvanje SPI pinova i inicijalizacija LCD-a    
		LcdPins myPins; 
    myPins.sce  = D5;//PB_4
    myPins.rst  = D7;//PA_8
    myPins.dc   = D4;//PB_10
    myPins.mosi = D11;//PA_7; SPI_MOSI
    myPins.sclk = D13;//PA_5; SPI_SCK
    myPins.miso = NC;
    NokiaLcd myLcd( myPins );
    myLcd.InitLcd();
// Podesavanje bluetooth,WiFi modula	
    esp.baud(115200); // Default vrednst je 115200 sada je na 9600
    pc.baud(9600);
    hc04.baud(9600);   
// PWM podesavanje
    sound.period_ms(1);
// Pocni da ispisujes LCD	
    myLcd.SetXY(char(0),char(0));
    myLcd.DrawString("   13M041BMP"); 
    myled=0;
// Resetuj WiFi modul    
    pc.printf("\nReset ESP8266\n");
    esp.printf("AT+RST\r\n");
    esp_read();
    wait(1);
    pc.printf(esp_str);
// Povezi se na AP
    pc.printf("\nConnecting to AP");        
    strcpy(povezi_ap, "AT+CWJAP=\"");
    strcat(povezi_ap, ssid);
    strcat(povezi_ap, "\",\"");
    strcat(povezi_ap, pwd);
    strcat(povezi_ap, "\"\r\n"); 
    esp.printf(povezi_ap);
    esp_read();
    pc.printf(esp_str);
    wait(1);  
// Povezi se na AP        
    pc.printf("\nIP");    
    esp.printf("AT+CIFSR\r\n");
    esp_read();
    pc.printf(esp_str);
// Proveri da li se WiFi modul povezao i dobio IP adresu    
    char *datax;
    datax=strstr(esp_str, "192.");
    //pc.printf("\nPointer %i",*datax);
    if (strcmp(datax,"0" )<=0){
        sound=sound_period;
        wait(1);
        sound=0;
        myLcd.SetXY(char(1),char(1));
        myLcd.DrawString("  ERROR NO IP");       
        }
    else{
        myLcd.SetXY(char(1),char(1));
        myLcd.DrawString("   CONECTED");
        }    
    
// Pokreni Systick Tajmer i interapt za slanje podataka
    mybutton.fall(&reed_switch_esp);
    flipper.attach(&flip, semplovanje);
// Pri pokretanju ispi
    myLcd.SetXY(char(0),char(2));
    myLcd.DrawString("Waiting data");
    myLcd.SetXY(char(0),char(3));
    myLcd.DrawString("Waiting data");
    myLcd.SetXY(char(0),char(4));
    myLcd.DrawString("Waiting data");
// Ovo mora jer se blokira ispis vrednosti prilikom salja na ThingSpeak    
    update_now=1;

    while (1) {  
        if ((time_sec!=0) && (update_now!=0)){ // Svaki tick azuriraj LCD  
					sprintf(str_min,  "%d", time_min);
          sprintf(str_sec,  "%d", time_sec);
          strcat(str_time," TIME: ");
          strcat(str_time,str_min);
          strcat(str_time,":");
          strcat(str_time,str_sec);
          myLcd.SetXY(char(0),char(5)); 
          myLcd.DrawString(str_time);
          memset(str_time,0,strlen(str_time));
            if (time_sec<10){
                myLcd.SetXY(char(60),char(5)); 
                myLcd.DrawString("   "); 
                }     
        }
        else{ // Pucaj na ThingSpeak i blokiraj LCD ispis
           update_now=0;
           myLcd.SetXY(char(0),char(2));
           myLcd.DrawString("            ");
           myLcd.SetXY(char(0),char(2));
           myLcd.DrawString(str_average_tmp);
           
           myLcd.SetXY(char(0),char(3));
           myLcd.DrawString("            ");
           myLcd.SetXY(char(0),char(3));
           myLcd.DrawString(str_average_adc);
           
           myLcd.SetXY(char(0),char(4));
           myLcd.DrawString("            ");
           myLcd.SetXY(char(0),char(4));
           myLcd.DrawString(str_average_presure);
          
           myLcd.SetXY(char(0),char(5)); 
           myLcd.DrawString("   UPDATING ");  
           time_sec=countdown;
           memset(str_time,0,strlen(str_time));
           reed_switch_esp(); 
           update_now=1;       
        }
        

    } //while
} //main
