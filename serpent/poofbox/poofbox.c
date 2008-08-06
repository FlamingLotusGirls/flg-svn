/*
   poofbox.c

   Copyright 2006 Flaming Lotus Girls

   This file is for code unique to the poofer control box hardware

*/

#include <avr/io.h>
#include <avr/interrupt.h>

#include "poofbox.h"
#include "serial.h"

void ioport_init(void)
{
  /* Port B has 3 outputs */
  /* 3,4,5,6 and 7 are ISP header and XTAL osc, so don't touch them! */
  DDRB = (1 << ONBOARDLED) | (1 << BICOLOR1) | (1 << BICOLOR2);

  /* Port C has relay outputs only */
  DDRC = (1 << RELAY0) |
         (1 << RELAY1) |
         (1 << RELAY2) |
         (1 << RELAY3) |
         (1 << RELAY4) |
         (1 << RELAY5);

  /* Port D uses 0 and 1 for the serial data, 2 is the TE output,
     and the others are switch inputs */
  DDRD = (1 << RS485TRANSMIT);
}


void initialize_hw(void)
{
  /* Clear all interrupts */
  cli();

  /* Initialize the I/O ports */
  ioport_init();

  /* Initialize the UART */
  uart_init();
}



/* Read the port which has the switch connected, and ignore non-switch bits */
int read_dip_switch(void)
{
  return ((PIND >> SWITCH_SHIFT) & SWITCH_MASK);
}


/*
   determine this unit's locally assigned address

   This looks like a stupid implementation but that's because we use
   all switch bits for the address.
*/

int read_my_address(void)
{
   return read_dip_switch();
}


void set_onboardled(int value)
{
  if (value)
    PORTB |= (1 << ONBOARDLED);
  else
    PORTB &= ~(1 << ONBOARDLED);
}

void set_bicolor(int illuminate, int color)
{
  if (illuminate)
  {
    if (color)
    {
      PORTB &= ~(1 << BICOLOR2);
      PORTB |= (1 << BICOLOR1);
    }
    else
    {
      PORTB &= ~(1 << BICOLOR1);
      PORTB |= (1 << BICOLOR2);
    }
  }
  else
  {
      PORTB &= ~(1 << BICOLOR1 | 1 << BICOLOR2);
  }

}

