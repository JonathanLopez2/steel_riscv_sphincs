#include <string.h>
#include <stdint.h>
#include "uart.h"

// Addresses to TX/RX data over the UART
volatile int* uart_tx_address = (int*) 0x00010000;
volatile int* uart_rx_address = (int*) 0x00010004;

char str[21] = {0};
char* pbuf = &str[0];

// Sends a string over the UART transmitter

void uart_tx_string(const char* str)
{ 
  for(int i = 0; i < strlen(str); i++)
  {
    while((*uart_tx_address) != 1);
    (*uart_tx_address) = str[i];
  };
}

void itoa(char *buf, unsigned long d, int base)
{
    int div = 1;
    while (d/div >= base)
        div *= base;

    while (div != 0)
    {
        int num = d/div;
        d = d%div;
        div /= base;
        if (num > 9)
            *(buf++) = (num-10) + 'A';
        else
            *(buf++) = num + '0';
    }
  *(buf++) = '\0';
}

void print_runtime(unsigned long cycle_start, unsigned long cycle_end)
{
  unsigned long long clock_cycles = cycle_end - cycle_start;

  itoa(pbuf, cycle_start, 10);
  uart_tx_string("\nStart cycle: ");
  uart_tx_string(str);
  uart_tx_string("\n");

  itoa(pbuf, cycle_end, 10);
  uart_tx_string("\nEnd cycle: ");
  uart_tx_string(str);
  uart_tx_string("\n");

  itoa(pbuf, clock_cycles, 10);
  uart_tx_string("\nTotal clock cycles: ");
  uart_tx_string(str);
  uart_tx_string("\n");
}

unsigned long read_cycles(void)
{
  unsigned long cycles;
  asm volatile ("csrr %0, cycle" : "=r" (cycles) );
  return cycles;
}