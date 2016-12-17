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

#include <stdlib.h>
#include "MS5803_14BA.h"

MS5803_14BA::MS5803_14BA(PinName sda, PinName scl, char MS5803_ADDR) : _i2c(sda, scl) {
    device_address = MS5803_ADDR << 1;
    _d1_osr = D1_OSR_4096;
    _d2_osr = D2_OSR_4096;
    reset();    // reset the sensor
    readPROM(); // read the calibration values
}

MS5803_14BA::MS5803_14BA(PinName sda, PinName scl, char MS5803_ADDR, char d1_osr, char d2_osr) : _i2c( sda, scl ) {
    device_address = MS5803_ADDR << 1;
    _d1_osr = D1_OSR_4096;
    _d2_osr = D2_OSR_4096;
    reset();    // reset the sensor
    readPROM(); // read the calibration values and store them in array C[ ] 
}

/* Send soft reset to the sensor */
void MS5803_14BA::reset(void) {
    MS5803_tx_data[0] = COMMAND_RESET;
    _i2c.write(device_address,  MS5803_tx_data, 1);
    wait_ms(20);
}

/* read the sensor calibration data from ROM */
void MS5803_14BA::readPROM(void) {
    for (uint8_t i = 0; i < 8; i++) {
        MS5803_tx_data[0] = COMMAND_READ_PROM + (i << 1);
        _i2c.write( device_address,  MS5803_tx_data, 1);
        _i2c.read( device_address,  MS5803_rx_data, 2);
        C[i] = (MS5803_rx_data[0] << 8) + MS5803_rx_data[1];
    }
}

/* Start the sensor pressure conversion */
void MS5803_14BA::convertD1(void) {
    MS5803_tx_data[0] = _d1_osr;
    _i2c.write( device_address,  MS5803_tx_data, 1);
}

/* Start the sensor temperature conversion */
void MS5803_14BA::convertD2(void) {
    MS5803_tx_data[0] = _d2_osr;
    _i2c.write(device_address,  MS5803_tx_data, 1);
}

/* Read the previous started conversion results */
int32_t MS5803_14BA::readADC(void) {
    wait_ms(150);
    MS5803_tx_data[0] = COMMAND_READ_ADC;
    _i2c.write(device_address,  MS5803_tx_data, 1);
    _i2c.read(device_address,  MS5803_rx_data, 3);
    return (MS5803_rx_data[0] << 16) + (MS5803_rx_data[1] << 8) + MS5803_rx_data[2];
}

/* return the results */
float MS5803_14BA::getPressure(void) {
    return P_MS5803;
}

float MS5803_14BA::getTemperature (void) {
    return T_MS5803;
}

/* Sensor reading and calculation procedure */
void MS5803_14BA::convert(void) {
    int32_t dT, TEMP;
    int64_t OFF, SENS, P;

    convertD1();    // start pressure convertion
    D1 = readADC(); // read the pressure value
    convertD2();    // start temperature convertion
    D2 = readADC(); // read the temperature value

    /* calculation according MS5803-14BA data sheet */
    dT       = D2 - (C[5]* 256);
    TEMP     = 2000 + (dT * C[6])/8388608;
    T_MS5803 = (float) TEMP/100.0f; // result of temperature in deg C in this var

    OFF      = (int64_t)65536*C[2] + ((int64_t)dT * (int64_t)C[4])/128;
    SENS     = (int64_t)32768*C[1] + ((int64_t)dT * (int64_t)C[3])/256;
    P    = (((int64_t)D1 * SENS)/2097152 - OFF)/32768;
    P_MS5803 = (float) P/10.0f; // result of pressure in mBar in this var
}
