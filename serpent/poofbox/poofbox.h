/*
   poofbox.h

   Copyright 2006 Flaming Lotus Girls

   Constants specific to the poofer control boxes for Serpent Mom

*/


#define   F_CPU      7372800UL

#define   UART_BAUD  19200

/* This about 24000 per second:  it's in units of "loop iterations"  */
#define   RELAY_TIMEOUT   12000;

/* Our port connections */

/* Port B */
#define   ONBOARDLED PB0
#define   BICOLOR1   PB1
#define   BICOLOR2   PB2

/* Port C */
/* Relay indices are 0-based */
/* Outlet numbers in the external world are 1-based; see parse_packet() in flg-packet.c */
#define   RELAY0     PC0
#define   RELAY1     PC1
#define   RELAY2     PC2
#define   RELAY3     PC3
#define   RELAY4     PC4
#define   RELAY5     PC5

/* Port D */
/* Note switch indices are 1-based cause the switch is labeled that way on the PC board! */
#define   RS485TRANSMIT   PD2
#define   SWITCH1         PD3
#define   SWITCH2         PD4
#define   SWITCH3         PD5
#define   SWITCH4         PD6
#define   SWITCH5         PD7


/* For address read from DIP switch */
#define   SWITCH_MASK     0x1f
#define   SWITCH_SHIFT    3

void initialize_hw(void);

int read_my_address(void);

void set_onboardled(int value);

void set_bicolor(int illuminate, int color);
