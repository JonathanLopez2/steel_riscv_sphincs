#ifndef SPX_UART_H
#define SPX_UART_H

void uart_tx_string(const char* str);
void itoa(char *buf, unsigned long d, int base);
void print_runtime(unsigned long longcycle_start, unsigned long cycle_end);
unsigned long read_cycles(void);


#endif