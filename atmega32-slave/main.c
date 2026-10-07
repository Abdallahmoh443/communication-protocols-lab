#ifndef F_CPU
#define F_CPU 16000000UL
#endif

#include <avr/io.h>
#include <stdio.h>
#include <util/delay.h>
#include "middleware/driver/SPI.h"
#include "middleware/driver/USART.h"

/* Light 2-digit ASCII formatter (SRAM safe) */
static void Transmit2Digits(uint8_t number) {
    USART_TransmitChar((number / 10) + '0');
    USART_TransmitChar((number % 10) + '0');
}

int main(void) {
    uint8_t rtc_buffer[7];

    USART_Init(9600, F_CPU);
    SPI_SlaveInit();

    USART_TransmitString("SPI Slave Receiver Ready\r\n");

    while (1) {
        /* 1. Wait until Master pulls SS LOW to initiate a frame */
        while (PINB & (1 << SS_PIN));

        /* 2. Read Sync Header Byte */
        uint8_t sync = SPI_Transfer(0xFF);

        if (sync == 0xAA) {
            for (uint8_t i = 0; i < 7; i++) {
                rtc_buffer[i] = SPI_Transfer(0xFF);
            }

            /* 3. Wait until Master pulls SS HIGH (end of frame) */
            while (!(PINB & (1 << SS_PIN)));

            /* 4. Format Output without snprintf memory overhead */
            USART_TransmitString("Time: ");
            Transmit2Digits(rtc_buffer[2]); /* Hours */
            USART_TransmitChar(':');
            Transmit2Digits(rtc_buffer[1]); /* Minutes */
            USART_TransmitChar(':');
            Transmit2Digits(rtc_buffer[0]); /* Seconds */

            USART_TransmitString(" | Date: ");
            Transmit2Digits(rtc_buffer[4]); /* Date */
            USART_TransmitChar('/');
            Transmit2Digits(rtc_buffer[5]); /* Month */
            USART_TransmitString("/20");
            Transmit2Digits(rtc_buffer[6]); /* Year */
            USART_TransmitString("\r\n");
        }
    }

    return 0;
}