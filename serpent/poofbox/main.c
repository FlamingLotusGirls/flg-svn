/*
   main.c

   Copyright 2006 Flaming Lotus Girls

   Program for testing the serial protocol:  poofer boxes

*/


#include <avr/interrupt.h>

#include "poofbox.h"
#include "serial.h"
#include "flg-packet.h"



/* Global variables */
int         packet_available;
int         packet_state;
int         unit_address;
tpacket     packet;
int         received_char;

long int    timer[6];


void initialize(void)
{
   int i;

   initialize_hw();

   unit_address = read_my_address();

   packet_available = 0;
   packet_state = PACKET_STATE_IDLE;

   clear_packet(packet);

   received_char = 0;

   for (i = 0; i < 6; i++)
     timer[i] = 0;
}



void start_processing(void)
{
   enable_serial_interrupts();
}


void service_timers(void)
{

  int i;

  for (i = 0; i < 6; i++) {

    /* Turn off relay if timer has reached 0 */
    if (timer[i] <= 0)
       PORTC &= ~(1 << i);

    /* Count down */
    if (timer[i] > 0)
       timer[i]--;

  }

  

}



int main(void)
{
   initialize();

   start_processing();


   while (1) {

     if (packet_available) {
         parse_packet(packet);
     }

     service_timers();

   }

   return 0;
}
