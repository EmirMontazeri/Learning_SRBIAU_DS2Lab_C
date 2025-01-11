/******************************************************************************
                               DHT11.c                                        *
                                                                              *
   DHT11 Digital humidity and temperature sensor library for                  *
     mikroC PRO for PIC compiler.                                             *
                                                                              *
*******************************************************************************
                                                                              *
 https://simple-circuit.com/                                                  *
                                                                              *
******************************************************************************/

#include <stdint.h>

// read one byte from sensor
uint8_t dht11_read_byte()
{
  uint8_t i = 8, dht11_byte = 0;

  while(i--)
  {
    while( !DHT11_PIN );

    delay_us(40);

    if( DHT11_PIN )
    {
      dht11_byte |= (1 << i);   // set bit i
      while( DHT11_PIN );
    }
  }
  return(dht11_byte);
}

// read humidity (in rH%) and temperature (in °Celsius) from sensor
void dht11_read(uint8_t *dht11_humi, uint8_t *dht11_temp)
{
  // send start signal
  DHT11_PIN     = 0;   // connection pin output low
  DHT11_PIN_DIR = 0;   // configure connection pin as output
  delay_ms(25);        // wait 25 ms
  DHT11_PIN     = 1;   // connection pin output high
  delay_us(30);        // wait 30 us
  DHT11_PIN_DIR = 1;   // configure connection pin as input

  // check sensor response
  while( DHT11_PIN );
  while( !DHT11_PIN );
  while( DHT11_PIN );

  // read data
  *dht11_humi = dht11_read_byte();  // read humidity byte 1
  dht11_read_byte();               // read humidity byte 2 (skipped)
  *dht11_temp = dht11_read_byte();  // read temperature byte 1
  dht11_read_byte();               // read temperature byte 2 (skipped)
  dht11_read_byte();               // read checksum (skipped)
  
}

// end of driver code.