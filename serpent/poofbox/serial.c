/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <joerg@FreeBSD.ORG> wrote this file.  As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.        Joerg Wunsch
 * ----------------------------------------------------------------------------
 *
 * Adapted 21 Jun 2006 for Flaming Lotus Girls
 *
 */

#include "poofbox.h"

/*
#include <stdint.h>
#include <stdio.h>
*/

#include <avr/io.h>
#include <avr/interrupt.h>

#include "serial.h"

/*
 * Initialize the UART
 */
void
uart_init(void)
{
  UBRRL = (F_CPU / (16UL * UART_BAUD)) - 1;

  UCSRB = _BV(TXEN) | _BV(RXEN); /* tx/rx enable */

  /*  UCSRC = (3 << UCSZ0); */  /* This FUCKED it! Do not use.  */
}

/*
 * Send character c down the UART Tx, wait until tx holding register
 * is empty.
 */
int
uart_putchar(char c)
{

  loop_until_bit_is_set(UCSRA, UDRE);

  /* Set TE on RS-485 transceiver */
  /* This needs to be implemented */
#warning This code cannot transmit on the RS-485 bus

  UDR = c;

  /* Wait until data has been sent */
  loop_until_bit_is_set(UCSRA, UDRE);

  /* clear the RS-485 transmit pin */
  /* This also needs to be implemented */

  return 0;
}


/* This turns on receive interrupts only */
void enable_serial_interrupts(void)
{
  /* Receive Complete interrupt in UART config register */
  UCSRB |= _BV(RXCIE);

  /* Now enable global interrupts */
  sei();
}
