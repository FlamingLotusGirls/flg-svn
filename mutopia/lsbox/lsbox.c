/*
   lsbox.c

   Copyright 2008 Flaming Lotus Girls

   This file is for code unique to the liquid shooter control box

*/

#include <avr/io.h>
#include <avr/interrupt.h>

#include "lsbox.h"
#include "serial.h"


static int adc_channel;

extern unsigned int timer[6];

uint16_t purge_adc_val;
uint16_t dump_adc_val;


void lsbox_ioport_init(void)
{
  /* Do something (?) to initialize port A */


  /* Port B is all inputs */
  /* 5,6 and 7 are ISP header, but with no switches activated,
     they're fine to use as inputs */
  DDRB = 0;
  PORTB = 0xff;     /* Set all pullups on these */

  /* Port C is all inputs */
  DDRC = 0;
  PORTC = 0xff;     /* Set all pullups on these */

  /* Port D uses 0 and 1 for the serial data, 2 is the TE output,
     and the others are switch inputs */
  /* Note the TE output isn't used yet, but allocating it is good */
  DDRD = (1 << RS485TRANSMIT);
  PORTD = 0xf8;     /* Set pullups on switch inputs */

  /*
   *    timer setup
   * 
   * base clock rate 7.3728 MHz
   * prescaler 64 = 115.2 KHz
   * OCR0 = 115
   * CTC mode interrupts at 1002 Hz
   */

  /* set OSC0A to 115 */
  OCR0 = 115;
  
  /* set TC into CTC mode */
  TCCR0 = _BV(WGM01);
  
  /* enable output compare interrupt */
  TIMSK = _BV(OCIE0);

  /* set 64 prescalar */
  TCCR0 = _BV(CS01) | _BV(CS00);

  /*
   *     ADC setup
   *
   * base clock rate 7.3728 MHz
   * prescalar 64 = 115.2 KHz
   * conversion time = 13 clocks ~= 8.862 KHz  ~= 113uS
   */

  /* select channel, AVCC reference */
  adc_channel = 0;
  ADMUX = _BV( REFS0 ) | adc_channel;
  
  /* enable, enable interrupts, prescalart=64 */
  ADCSRA = _BV(ADEN) | _BV(ADIE) | _BV(ADPS2) | _BV(ADPS1);

  /* start conversion */
  ADCSRA |= _BV(ADSC);
  
}


void initialize_hw(void)
{
  /* Clear all interrupts */
  cli();

  /* Initialize the I/O ports */
  lsbox_ioport_init();

  /* init uart */
  uart_init();

  /* A/D converter is either initialized above, or in a function like below */
  //  lsbox_ad_init();
}


/*
   determine this unit's locally assigned address

   This looks like a stupid implementation but that's because we
   don't have a dip switch on this one, but it may later be called upon to rx packets
*/

int read_my_address(void)
{
  return RX_ADDRESS;
}




/* Read the port which has the switch connected, and ignore non-switch bits */
int read_mode_switch(void)
{
   return ((PIND >> MODE_SWITCH_SHIFT) & MODE_SWITCH_MASK);
}


int read_joystick(int stick)
{
  int pb = 0;
  int pc = 0;
  int purge = 0;

  switch (stick) {
    case 0:
      return (PINB & 0x3f);
      break;

    case 1:
      pb = ((PINB >> 6) & 0x03);
      pc = ((PINC >> 5) & 0x07);
      purge = (PINB & 0x20);
      return (pb | (pc << 2) | purge);
      break;

    case 2:
      return (PINC & 0x3f);
      break;

    default:
      return 0;
      break;
  }

}

int read_mist(void)
{
  return (PIND & (1 << MIST));
}

ISR( TIMER0_COMP_vect )
{
  int i;
  for( i=0 ; i<(sizeof(timer)/sizeof(*timer)) ; i++ ) {
    if( timer[i] ) {
      timer[i]--;
    }
  }
}

ISR( ADC_vect )
{
  switch( adc_channel ) {
    case 0:
      purge_adc_val = ADC;
      adc_channel = 1;
      break;

    case 1:
      dump_adc_val = ADC;
      adc_channel = 0;
      break;
  }

  /* select channel */
  ADMUX = _BV( REFS0 ) | adc_channel;
  
  /* start conversion */
  ADCSRA |= _BV(ADSC);
}
