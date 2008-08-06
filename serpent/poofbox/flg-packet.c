/*
   flg-packet.c

   Copyright 2006 Flaming Lotus Girls

*/

#include <avr/io.h>
#include <avr/interrupt.h>
#include "flg-packet.h"
#include "poofbox.h"


/* extern globals */
extern int packet_available;
extern int packet_state;
extern tpacket packet;
extern int received_char;
extern int unit_address;
extern long int timer[];

/*
   UART receive interrupt:  collect packet
*/


ISR(USART_RXC_vect)
{
   char c;

   c = UDR;

   received_char = 1;

   /* Ignore a space character, with a nod to Lee */
   if (c == ' ')
     return;

   /* Even if we're in the middle of a packet, state is reset by receiving
      a packet start character */

   if (c == PACKET_CHAR_WRITE || c == PACKET_CHAR_READ) {
      packet_state = PACKET_STATE_IDLE;
   }


   switch (packet_state) {

      case PACKET_STATE_IDLE:
         if (packet_available) {
	   /* discard c! */
           /* increment an error counter:  our main loop isn't running fast enough */
           ;
         }

	 if (c == PACKET_CHAR_WRITE || c == PACKET_CHAR_READ) {
            packet.head = c;
            packet_state = PACKET_STATE_HEAD_OK;
	    set_onboardled(1);
	 }
         else
         {
	    /* Here, we've received something other than a packet start while idling.
               This is a kind of error, too, but just shows there's garbage on the line */
            ;
         }

         break;


       case PACKET_STATE_HEAD_OK:
         packet.unit_number1 = c;
         packet_state = PACKET_STATE_UNIT2_WAIT;
         break;

       case PACKET_STATE_UNIT2_WAIT:
         packet.unit_number2 = c;
         packet_state = PACKET_STATE_ADDR_WAIT;
         break;

       case PACKET_STATE_ADDR_WAIT:
         packet.addr = c;
         packet_state = PACKET_STATE_DATA_WAIT;
         break;

       case PACKET_STATE_DATA_WAIT:
         packet.data = c;
         packet_state = PACKET_STATE_TAIL_WAIT;

         break;

       case PACKET_STATE_TAIL_WAIT:
         if (c == PACKET_CHAR_TAIL) {
            packet_available = 1;

         } else {
	   /* This is an error condition:  a tail character was expected, but not received,
              so the packet is discarded */
	   ;
	 }


         /* We go to idle whether or not it was a tail character */
         packet_state = PACKET_STATE_IDLE;

         break;

       default:
         /* discard c! */
         /* Always go to the idle state, and ensure there's no packet available */
         packet_state = PACKET_STATE_IDLE;
         packet_available = 0;
         break;

   }

   /* Clear the LED if we go to idle state */
   if (packet_state == PACKET_STATE_IDLE)
      set_onboardled(0);

}



int hex2int(char letter)
{
  if (letter <= '9')
     return (letter - '0');

  if (letter <= 'f')
     return ((letter - 'a') + 10);

  if (letter <= 'F')
     return ((letter - 'A') + 10);

  return 999;         /* ha ha ha, this is bogus, but safe for this application */
}



/*
    Look at a packet and do something with it
    This is the part which defines the behavior that each packet can create
*/

void parse_packet(tpacket p)
{
  int bitnum;
  int unit1, unit2;
  int unit = 0;

  unit1 = hex2int(p.unit_number1);
  unit2 = hex2int(p.unit_number2);

  unit = (unit1 << 4) + unit2;


  /* Special case for broadcast all off */
  if (unit == 0 && p.addr == '0' && p.data == '0')
    PORTC &= ~((1 << RELAY0) |
               (1 << RELAY1) |
               (1 << RELAY2) |
               (1 << RELAY3) |
               (1 << RELAY4) |
               (1 << RELAY5));


  if (unit == unit_address) {

     /* Translate from ASCII char to which relay bit is being operated on */
     /* Note bit 0 is outlet '1' as it's labeled in on the outside box */
     bitnum = (p.addr - '0') - 1;

     /* Stay safe:  if it's not a valid bit number, we ignore it */
     if (bitnum >=0 && bitnum <= 5) {

        if (p.data == '0') {       /* Turn it off */
           PORTC &= ~(1 << bitnum);
        }

        if (p.data == '1') {       /* Turn it on */
           PORTC |= (1 << bitnum);
           timer[bitnum] = RELAY_TIMEOUT;
        }

     }

  }

  /* We've looked at the packet and either used it or ignored it */
  packet_available = 0;

}



void clear_packet(tpacket p)
{
  p.head = '\0';
  p.unit_number1 = '\0';
  p.unit_number2 = '\0';
  p.addr = '\0';
  p.data = '\0';
}

