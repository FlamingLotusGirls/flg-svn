/*
   flg-packet.c

   Copyright 2006 Flaming Lotus Girls

*/

#include <avr/io.h>
#include <avr/interrupt.h>
#include "flg-packet.h"
#include "lsbox.h"
#include "serial.h"
#include "relay_map.h"


static tpacket packet;


/* extern globals */
extern int packet_available;
extern int packet_state;
extern int received_char;
extern int unit_address;
extern unsigned long int timer[];



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

char int2hex(int value)
{
  if (value < 0)
    return('0');

  if (value < 10)
    return('0' + value);

  if (value > 15)
    return('F');

  return('A' + (value - 10));
}

void packet_send_test( void )
{

  uart_putchar('a');

}



void packet_form_cmd( tpacket *p, uint8_t cmd, int relay, int data )
{
  uint8_t unit = pgm_read_word( relay*2 );
  uint8_t addr = pgm_read_word( relay*2+1 );

  p->head = cmd;

  p->unit_number1 = int2hex(unit>>4);
  p->unit_number2 = int2hex(unit&0xf);

  p->addr = '0' + addr;

  p->data = '0' + data;
}



void packet_send( tpacket *p )
{

  //  uart_putchar(PACKET_CHAR_WRITE);
  uart_putchar(p->head);

  uart_putchar(p->unit_number1);
  uart_putchar(p->unit_number2);

  uart_putchar(p->addr);
  uart_putchar(p->data);

  uart_putchar(PACKET_CHAR_TAIL);
  //  uart_putchar('\n');                 /* not sure if we want this */
  //  uart_putchar('\r');
}

void packet_send_write( int relay, int data )
{
  packet_form_cmd( &packet, PACKET_CHAR_WRITE, relay, data );
  packet_send( &packet );
}
