/*
   flg-packet.h

   Copyright 2006 Flaming Lotus Girls

*/


#define  PACKET_CHAR_WRITE   '!'
#define  PACKET_CHAR_READ    '?'
#define  PACKET_CHAR_RESPOND '^'
#define  PACKET_CHAR_TAIL    '.'


#define  PACKET_STATE_IDLE       0
#define  PACKET_STATE_HEAD_OK    1
#define  PACKET_STATE_UNIT2_WAIT 2
#define  PACKET_STATE_ADDR_WAIT  3
#define  PACKET_STATE_DATA_WAIT  4
#define  PACKET_STATE_TAIL_WAIT  5


/* These don't make sense yet:  they need to be character pairs */
/* Specifically, NOP would be '0' and '0', and bcast 'f' and 'f' */
/* These are unit numbers */
#define  NOP                   0x00
#define  BROADCAST             0xff



typedef struct
{
  char head;
  char unit_number1;
  char unit_number2;
  char addr;
  char data;
} tpacket;


int hex2int(char letter);

char int2hex(int value);

void packet_form_cmd( tpacket *p, uint8_t cmd, int relay, int data );
void packet_send( tpacket *p );
void packet_send_write( int relay, int data );
void packet_send_test( void );
