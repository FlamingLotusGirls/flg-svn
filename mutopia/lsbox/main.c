/*
   main.c

   Copyright 2006 Flaming Lotus Girls

   Program for testing the serial protocol:  poofer boxes

*/


#include <avr/interrupt.h>

#include <avr/pgmspace.h>

#include "lsbox.h"
#include "serial.h"
#include "flg-packet.h"
#include "relay_map.h"


unsigned int relay_timers[6];
unsigned int purge_timers[4];

void initialize(void)
{
   int i;

   initialize_hw();


   for (i = 0; i < (sizeof(relay_timers)/sizeof(*relay_timers)); i++)
     relay_timers[i] = 0;
   for (i = 0; i < (sizeof(purge_timers)/sizeof(*purge_timers)); i++)
     purge_timers[i] = 0;

   sei();

}

void timeout_relays( void )
{
  int i;
  for( i=0 ; i<(sizeof(relay_timers)/sizeof(*relay_timers)) ; i++ ) {
    if( relay_timers[i] == 1) {
      relay_timers[i] = RELAY_TIMEOUT;
      packet_send_write( i, 1 );
    }
  }
}

void relay_on( int relay )
{
  if( relay_timers[relay] == 0 ) {
    relay_timers[relay] = RELAY_TIMEOUT;
    packet_send_write( relay, 1 );
  }
}

void relay_off( int relay )
{
  if( relay_timers[relay] != 0 ) {
    relay_timers[relay] = 0;
    packet_send_write( relay, 0 );
  }
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
  if( cur_val && (relay_timers[relay] == 0) ) {
    relay_on(relay);
  } else if( !cur_val && old_val ) {
    relay_off(relay);
  }
}


/** handle fire button with fire and purge relays
 *  \param fire_relay    relay which activates fire
 *  \param purge_relay   relay which activates purge
 *  \param purge_timer   purge timer to use
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

void handle_fire( int fire_relay, int purge_relay, int purge_timer,
		  int cur_val, int old_val )
{
  /* we want to make sure not to re-trigger while purging */
  if( purge_timers[purge_timer] == 0 ) {
    if( cur_val ) {
      relay_on( fire_relay );
    } else if( !cur_val && old_val ) {
      relay_off( fire_relay );
      purge_timers[purge_timer] = purge_adc_val >> 2;
      relay_on( purge_relay );
    }
  } else if( purge_timers[purge_timer] == 1 ) {
    purge_timers[purge_timer] = 0;
    relay_off(purge_relay);
  }
}

void handle_axis( int enable_relay, int dir_relay, 
		  int cur_pos_val, int old_pos_val,
		  int cur_neg_val, int old_neg_val )
{
  if( cur_pos_val ) {
    relay_on( enable_relay );
    relay_on( dir_relay );
  } else if( cur_neg_val ) {
    relay_on( enable_relay );
    relay_off( dir_relay );
  } else if( (!cur_pos_val && old_pos_val) ||
	     (!cur_neg_val && old_neg_val) ) {
    relay_off( enable_relay );
    relay_off( dir_relay );
  }
	     
}


void spew_mode(int mode)
{
   uart_putchar(int2hex(PINC >> 4));
   uart_putchar(int2hex(PINC & 0xf));
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

   packet_send_write( 1, 1 );
}



/* The following for handle_pod1() */

unsigned int cur_b;
unsigned int cur_c;
unsigned int cur_d;

unsigned int old_b;
unsigned int old_c;
unsigned int old_d;


void handle_pods(void)
{
  cur_b = ~PINB;
  cur_c = ~PINC;
  cur_d = ~PIND;

  handle_axis( 0, 1, cur_b & _BV(POD1L), old_b & _BV(POD1L),
	       cur_b & _BV(POD1R), old_b & _BV(POD1R) );
  handle_axis( 2, 3, cur_b & _BV(POD1U), old_b & _BV(POD1U),
	       cur_b & _BV(POD1D), old_b & _BV(POD1D) );
  handle_fire( 4, 5, 0,
	       cur_b & _BV(POD1FIRE), old_b & _BV(POD1FIRE) );

  handle_axis( 8, 9, cur_b & _BV(POD2L), old_b & _BV(POD2L),
	       cur_b & _BV(POD2R), old_b & _BV(POD2R) );
  handle_axis( 10, 11, cur_c & _BV(POD2U), old_c & _BV(POD2U),
	       cur_c & _BV(POD2D), old_c & _BV(POD2D) );
  handle_fire( 12, 13, 1,
	       cur_b & _BV(POD2FIRE), old_b & _BV(POD2FIRE) );

  handle_axis( 16, 17, cur_c & _BV(POD3L), old_c & _BV(POD3L),
	       cur_c & _BV(POD3R), old_c & _BV(POD3R) );
  handle_axis( 18, 19, cur_c & _BV(POD3U), old_c & _BV(POD3U),
	       cur_c & _BV(POD3D), old_c & _BV(POD3D) );
  handle_fire( 20, 21, 2,
	       cur_c & _BV(POD3FIRE), old_c & _BV(POD1FIRE) );

  old_b = cur_b;
  old_c = cur_c;
  old_d = cur_d;
}


int main(void)
{
   int mode = 0;


   /* The following for handle_pod1() */

   old_b = ~PINB;
   old_c = ~PINC;
   old_d = ~PIND;

   /* End state variables for handle_pod1() */


   initialize();

   while(1) 
   {
     timeout_relays();
     mode = 2;//read_mode_switch();

      //spew_mode(mode);
      
      switch(mode) {

         case 0:
           test_uart();
           break;

         case 1:
           test_uart_and_packet();
           break;

         case 2:
           handle_pods();
          break;

         default:
           say_hello();
           break;
      }
   }

   return 0;
}

