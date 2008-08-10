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

unsigned long int timer[6];


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


/** handle fire button with fire and purge relays
 *  \param fire_relay    relay which activates fire
 *  \param purge_relay   relay which activates purge
 *  \param cur_val       current value of fire button
 *  \param old_val       last value of fire button
 *
 *  Handles a fire button.  When pressed activates fire_relay
 *  and keeps active while pressed.  When released activates
 *  purge relay for 0-255 ms as set by purge pot.
 *
 *  XXX-ewg: we probably want more than 255ms in which case we need
 *           to keep acking the relay and keep a secondary counter.
 */

void handle_fire( int fire_relay, int purge_relay, int cur_val, int old_val )
{
  if( timer[purge_relay] ) {
    /* on last ms turn off relay */
    if( timer[purge_relay] == 1 ) {
      timer[purge_relay] = 0;
      turn_relay_off(purge_relay);
    }
  } else {
    /* we want to make sure not to re-trigger while purging */
    if( cur_val && (timer[fire_relay] == 0) ) {
      timer[fire_relay] = RELAY_TIMEOUT;
      turn_relay_on(fire_relay);
    } else if( !cur_val && old_val ) {
      timer[fire_relay] = 0;
      turn_relay_off(fire_relay);

      timer[purge_relay] = purge_adc_val >> 2;
      turn_relay_on(purge_relay);
    }
  }

}


void spew_mode(int mode)
{
   uart_putchar(int2hex(mode));
   uart_putchar('\n');
   uart_putchar('\r');
}


void say_hello(void)
{
   int i = 0;
   long int j = 0;
   char hello[] = "hello FLG\n\r";

   for (i = 0; i < 11; i++)
      uart_putchar(hello[i]);

   for (j = 0; j < 2000000; j++);
}

void test_uart(void)
{
  int i = 0;
  char hello[] = "a\n\r";

  for (i = 0; i < 3; i++)
    uart_putchar(hello[i]);
}


void test_uart_and_packet(void)
{
   uart_putchar('b');
   uart_putchar('c');

   tpacket p;
   p = form_command_packet(1, 1, 1);
   send_packet(p);
}



/* The following for handle_pod1() */

unsigned int cur_b;
unsigned int cur_c;
unsigned int cur_d;

unsigned int old_b;
unsigned int old_c;
unsigned int old_d;


void handle_pod1(void)
{
  cur_b = PORTB;
  cur_c = PORTC;
  cur_d = PORTD;

  handle_relay( 0, cur_b & POD1L, old_b & POD1L );
  handle_relay( 1, cur_b & POD1R, old_b & POD1R );
  handle_relay( 2, cur_b & POD1U, old_b & POD1U );
  handle_relay( 3, cur_b & POD1D, old_b & POD1D );
  handle_fire( 4, 5, cur_b & POD1FIRE, old_b & POD1FIRE );
     
  old_b = cur_b;
  old_c = cur_c;
  old_d = cur_d;
}


int main(void)
{
   int mode = 0;


   /* The following for handle_pod1() */

   old_b = PORTB;
   old_c = PORTC;
   old_d = PORTD;

   /* End state variables for handle_pod1() */


   initialize();

   while(1) 
   {
      mode = read_mode_switch();

      spew_mode(mode);
      
      switch(mode) {

         case 0:
           test_uart();
           break;

         case 1:
           test_uart_and_packet();
           break;

         case 2:
           handle_pod1();
          break;

         default:
           say_hello();
           break;
      }
   }

   return 0;
}

