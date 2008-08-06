/*
   lsbox.h

   Copyright 2008 Flaming Lotus Girls

   Constants specific to the liquid shooter control box for Mutopia

*/


#define   F_CPU      7372800UL

#define   UART_BAUD  19200

/* This address for receivingpackets, which we won't do yet */
#define   RX_ADDRESS 0


/* This about 24000 per second:  it's in units of "loop iterations"  */
#define   RELAY_TIMEOUT   12000;

/* Our port connections */

/* Port A */
#define   PURGE_TIME_POT  PA0
#define   DUMP_TIME_POT   PA1


/* Port B */
#define   POD1L           PB0
#define   POD1R           PB1
#define   POD1U           PB2
#define   POD1D           PB3
#define   POD1FIRE        PB4
#define   POD1PURGE       PB5
#define   POD2L           PB6
#define   POD2R           PB7


/* Port C */
#define   POD3L           PC0
#define   POD3R           PC1
#define   POD3U           PC2
#define   POD3D           PC3
#define   POD3FIRE        PC4
#define   POD2U           PC5
#define   POD2D           PC6
#define   POD2FIRE        PC7


/* Port D */
/* Port D 0 and 1 are used for the serial port */
#define   DONTUSE0        PD0
#define   DONTUSE1        PD1
#define   RS485TRANSMIT   PD2
#define   MIST            PD3
#define   DONTUSE4        PD4   /* These say don't use 'cause the mode switch is there */
#define   DONTUSE5        PD5
#define   DONTUSE6        PD6
#define   DONTUSE7        PD7

/* For read from mode switch */
/* The switch is the upper 4 bits on port D */
#define   MODE_SWITCH_MASK     0x0f
#define   MODE_SWITCH_SHIFT    4

void initialize_hw(void);

int read_my_address(void);

int read_mode_switch(void);

int read_joystick(int stick);

int read_buttons(void);

