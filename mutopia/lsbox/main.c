/*
   main.c

   Copyright 2006 Flaming Lotus Girls

   Program for testing the serial protocol:  poofer boxes

*/


#include <avr/interrupt.h>

#include "lsbox.h"
#include "serial.h"
#include "flg-packet.h"



/* Global variables */
int         packet_available;
int         packet_state;
int         unit_address;
tpacket     packet;
int         received_char;

unsigned int timer[6];


void initialize(void)
{
   int i;

   initialize_hw();

   unit_address = read_my_address();

   packet_available = 0;
   packet_state = PACKET_STATE_IDLE;

   clear_packet(&packet);

   received_char = 0;

   for (i = 0; i < 6; i++)
     timer[i] = 0;
}



void start_processing(void)
{
   enable_serial_interrupts();
}


void turn_relay_on( int relay ) 
{
  /* send an on packet here */
}

void turn_relay_off( int relay ) 
{
  /* send an off packet here */
}


/** handle a simple, direct relay to switch association
 *  \param relay    relay number to handle
 *  \param cur_val  current value of switch
 *  \param old_val  last value of switch
 *
 *  Handles sending on and off packets for a direct mapping
 *  between a swich and a relay.  Also handle retransmits
 *  to keep ON relays from timeout at the receiver end.
 */

void handle_relay( int relay, int cur_val, int old_val )
{
  if( cur_val && (timer[relay] == 0) ) {
    timer[relay] = RELAY_TIMEOUT;
    turn_relay_on(relay);
  } else if( !cur_val && old_val ) {
    timer[relay] = 0;
    turn_relay_off(relay);
  }
}

int main(void)
{
   unsigned int cur_b;
   unsigned int cur_c;
   unsigned int cur_d;

   unsigned int old_b;
   unsigned int old_c;
   unsigned int old_d;

   old_b = PORTB;
   old_c = PORTC;
   old_d = PORTD;

   while (1) {
     
     cur_b = PORTB;
     cur_c = PORTC;
     cur_d = PORTD;

     handle_relay( 0, cur_b & POD1L, old_b & POD1L );
     handle_relay( 1, cur_b & POD1R, old_b & POD1R );
     handle_relay( 2, cur_b & POD1U, old_b & POD1U );
     handle_relay( 3, cur_b & POD1D, old_b & POD1D );

     
     old_b = cur_b;
     old_c = cur_c;
     old_d = cur_d;

   }

   return 0;
}
