/*
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

  * Demo Program
  * Barometer Sensor (Altimeter) MS5803-01BA of MEAS Switzerland     (www.meas-spec.com).
  * The driver uses I2C mode (sensor PS pin low).
  * Other types of MEAS are compatible but not tested.
  * Written by Raig Kaufer distribute freely!
  *
  * Modified for MS5803-14BA by Francesco Adamo, Italy
 */

#include "mbed.h"

#ifndef MS5803_14BA_H
#define MS5803_14BA_H

#define MS5803_RX_DEPTH 3
#define MS5803_TX_DEPTH 2


#define MS5803_ADDRC_L 0x77 //0b1110111  CSB Pin is low
#define MS5803_ADDRC_H 0x76 //0b1110110  CSB Pin is high 

#define MS5803_BASE_ADDR MS5803_ADDRC_L // choose your connection here

#define COMMAND_RESET       0x1E // Sensor Reset

#define D1_OSR_256  0x40 // Convert D1 OSR 256
#define D1_OSR_512  0x42 // Convert D1 OSR  512
#define D1_OSR_1024 0x44 // Convert D1 OSR 1024
#define D1_OSR_2048 0x46 // Convert D1 OSR 2048
#define D1_OSR_4096 0x48 // Convert D1 OSR 4096

#define D2_OSR_256  0x50 // Convert D2 OSR  256
#define D2_OSR_512  0x52 // Convert D2 OSR  512
#define D2_OSR_1024 0x54 // Convert D2 OSR 1024
#define D2_OSR_2048 0x56 // Convert D2 OSR 2048
#define D2_OSR_4096 0x58 // Convert D2 OSR 4096

#define COMMAND_READ_ADC     0x00 // read ADC command
#define COMMAND_READ_PROM    0xA0 // read PROM command base address

class MS5803_14BA {
private:
    I2C     _i2c;
    char    device_address, _d1_osr, _d2_osr;

    uint32_t D1, D2;
    uint16_t C[8];
    float T_MS5803, P_MS5803;
    /* Data buffers */
    char MS5803_rx_data[MS5803_RX_DEPTH];
    char MS5803_tx_data[MS5803_TX_DEPTH];

public:
    MS5803_14BA(PinName sda, PinName scl, char MS5803_ADDR);
    MS5803_14BA(PinName sda, PinName scl, char MS5803_ADDR, char d1_osr, char d2_osr);
    
    void reset(void);
    void readPROM(void);
    void convertD1(void);
    void convertD2(void);
    int32_t readADC(void);
    float getPressure(void);
    float getTemperature(void);
    void convert(void);
};
#endif
