/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <joerg@FreeBSD.ORG> wrote this file.  As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.        Joerg Wunsch
 * ----------------------------------------------------------------------------
 *
 *  Adapted 20 Jun 2006    for Flaming Lotus Girls
 */

/*
 * Perform UART startup initialization.
 */
void	uart_init(void);

/*
 * Send one character to the UART.
 */
int	uart_putchar(char c);



void enable_serial_interrupts(void);


