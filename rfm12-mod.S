;;
;; rfm12-mod.asm
;;
;; This is a hacked firmware thought for the AT90S8535 controller found
;; on Compaq iPAQ h3600.  It allows to connect an RFM12 FSK-Transmitter
;; chip to the SPI pins.
;;
;; The code is based on a disassembly of the firmware read from the AVR,
;; i.e. it's mostly from upstream but slightly modified :-)
;;
;; The modifications are public domain, educational purpose, whatever foo.
;;
;;  Got questions?  Mail me!
;;
;;   stesie@brokenpipe.de
;;

.text

main:
	rjmp    __vect_Reset
	rjmp    __vect_ExternalInt0
	rjmp    __vect_ExternalInt1
	reti
	rjmp    __vect_Timer2Ovf
	reti
	reti
	reti
	reti
	rjmp    __vect_Timer0Ovf
	rjmp    __vect_SpiTransferComplete
	rjmp    __vect_UartRxComplete
	rjmp    __vect_UartDataRegEmpty
	rjmp    __vect_UartTxComplete
	rjmp    __vect_UartAdcComplete
	reti
	reti


__vect_ExternalInt0:
	in      r0, SREG
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label2
	sbi     PORTD, 7        ; 0x80 = 128
	mov     r19, r9
	andi    r19, 0x07       ; 7
	brne    Label2
	in      r19, GIMSK
	ori     r19, 0x80       ; 128
	out     GIMSK, r19
	ldi     r19, 0x80       ; 128
	out     GIFR, r19



Label2:
	sbis    PINB, 0         ; 0x01 = 1
	sbi     PORTC, 4        ; 0x10 = 16
	sbis    PINB, 2         ; 0x04 = 4
	rjmp    KeyPress_IRQ
	rjmp    __vect_ExternalInt0_out


KeyPress_IRQ:
	lds     r19, 0x0068
	andi    r19, 0x12       ; 18
	brne    __vect_ExternalInt0_out
	clr     r19
	sts     0x0069, r19
	sts     0x006c, r19
	sbi     PORTD, 6        ; 0x40 = 64
	ldi     r19, 0x05       ; 5
	sts     0x00fe, r19
	lds     r19, 0x0068
	ori     r19, 0x10       ; 16
	andi    r19, 0xfd       ; 253
	sts     0x0068, r19



__vect_ExternalInt0_out:
	out     SREG, r0
	reti


__vect_ExternalInt1:
	in      r0, SREG
	in      r19, GIMSK
	andi    r19, 0x7f       ; 127
	out     GIMSK, r19
	sbis    PINB, 3         ; 0x08 = 8
	rjmp    Label6
	clr     r19
	mov     r9, r19
	sts     0x0064, r19
	out     SREG, r0
	reti


Label6:
	ori     r25, 0x02       ; 2
	ldi     r19, 0x02       ; 2
	mov     r9, r19
	clr     r19
	sts     0x0064, r19
	sbi     PORTC, 0        ; 0x01 = 1
	out     SREG, r0
	reti


__vect_Timer0Ovf:
	in      r0, SREG
	lds     r19, 0x007a
	dec     r19
	breq    Label8
	sts     0x007a, r19
	rjmp    Label25


Label8:
	ldi     r19, 0x14       ; 20
	sts     0x007a, r19
	sbrs    r22, 0          ; 0x01 = 1
	rjmp    Label9
	dec     r8
	brne    Label9
	ori     r22, 0x08       ; 8



Label9:
	lds     r19, 0x00ff
	andi    r19, 0x03       ; 3
	breq    Label11
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label10
	lds     r19, 0x00f4
	ori     r19, 0x08       ; 8
	sts     0x00f4, r19
	rjmp    Label11


Label10:
	clr     r19
	sts     0x00ff, r19



Label11:
	lds     r19, 0x008c
	sbrc    r19, 2          ; 0x04 = 4
	rjmp    Label12
	sbrc    r19, 1          ; 0x02 = 2
	rjmp    Label22
	sbrc    r19, 0          ; 0x01 = 1
	rjmp    Label17
	rjmp    Label25


Label12:
	lds     r19, 0x0075
	ori     r19, 0x02       ; 2
	sts     0x0075, r19
	lds     r19, 0x006d
	sbrs    r19, 0          ; 0x01 = 1
	rjmp    Label13
	sbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label15


Label13:
	sbis    PINC, 6         ; 0x40 = 64
	rjmp    Label14
	cbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label15


Label14:
	sbi     PORTC, 6        ; 0x40 = 64



Label15:
	lds     r19, 0x008a
	dec     r19
	breq    Label16
	sts     0x008a, r19
	rjmp    Label25


Label16:
	ldi     r19, 0x05       ; 5
	sts     0x008a, r19
	ori     r25, 0x50       ; 80
	rjmp    Label25


Label17:
	lds     r19, 0x006d
	sbrs    r19, 0          ; 0x01 = 1
	rjmp    Label18
	sbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label20


Label18:
	sbis    PINC, 6         ; 0x40 = 64
	rjmp    Label19
	cbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label20


Label19:
	sbi     PORTC, 6        ; 0x40 = 64



Label20:
	lds     r19, 0x0089
	dec     r19
	breq    Label21
	sts     0x0089, r19
	rjmp    Label25


Label21:
	ldi     r19, 0x0a       ; 10
	sts     0x0089, r19
	ori     r25, 0x40       ; 64
	rjmp    Label25


Label22:
	lds     r19, 0x006d
	sbrs    r19, 0          ; 0x01 = 1
	rjmp    Label23
	sbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label25


Label23:
	sbis    PINC, 6         ; 0x40 = 64
	rjmp    Label24
	cbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label25


Label24:
	sbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label25










Label25:
	ldi     r19, 0x4c       ; 76
	out     TCNT0, r19
	out     SREG, r0
	reti


__vect_Timer2Ovf:
	in      r0, SREG
	lds     r19, 0x008e
	sbrs    r19, 1          ; 0x02 = 2
	rjmp    Label28
	lds     r19, 0x00f2
	dec     r19
	breq    Label27
	sts     0x00f2, r19
	rjmp    Label28


Label27:
	ldi     r19, 0xfa       ; 250
	sts     0x00f2, r19
	ori     r25, 0x20       ; 32



Label28:
	lds     r19, 0x0080
	dec     r19
	breq    Label29
	sts     0x0080, r19
	rjmp    Label30


Label29:
	ldi     r19, 0x7c       ; 124
	sts     0x0080, r19
	ori     r25, 0x08       ; 8


Label30:
	mov     r19, r9
	sbrc    r19, 2          ; 0x04 = 4
	rjmp    Label31
	sbrc    r19, 4          ; 0x10 = 16
	rjmp    Label31
	rjmp    Label33



Label31:
	lds     r19, 0x0079
	dec     r19
	breq    Label32
	sts     0x0079, r19
	rjmp    Label33


Label32:
	mov     r20, r9
	lds     r19, 0x0064
	sbrc    r20, 4          ; 0x10 = 16
	ori     r19, 0x08       ; 8
	sbrc    r20, 2          ; 0x04 = 4
	ori     r19, 0x04       ; 4
	sts     0x0064, r19



Label33:
	lds     r19, 0x006d
	sbrs    r19, 0          ; 0x01 = 1
	rjmp    Label35
	lds     r19, 0x0071
	dec     r19
	breq    Label34
	sts     0x0071, r19
	rjmp    Label35


Label34:
	ldi     r19, 0x64       ; 100
	sts     0x0071, r19
	lds     r19, 0x006d
	ori     r19, 0x02       ; 2
	sts     0x006d, r19



Label35:
	lds     r19, 0x0065
	sbrs    r19, 7          ; 0x80 = 128
	rjmp    Label37
	lds     r20, 0x00fd
	dec     r20
	breq    Label36
	sts     0x00fd, r20
	rjmp    Label37


Label36:
	andi    r19, 0x7f       ; 127
	sts     0x0065, r19



Label37:
	lds     r19, 0x00fe
	dec     r19
	breq    Label38
	sts     0x00fe, r19
	rjmp    Label45


Label38:
	ldi     r19, 0x08       ; 8
	sts     0x00fe, r19
	lds     r19, 0x0068
	sbrs    r19, 1          ; 0x02 = 2
	rjmp    Label43
	rjmp    Label39


Label39:
	sbic    PINB, 2         ; 0x04 = 4
	rjmp    Label40
	rjmp    Label45


Label40:
	sbrs    r19, 5          ; 0x20 = 32
	rjmp    Label41
	andi    r19, 0xdf       ; 223
	andi    r19, 0xfd       ; 253
	sts     0x0068, r19
	cbi     PORTD, 6        ; 0x40 = 64
	rjmp    Label45


Label41:
	sbrc    r19, 6          ; 0x40 = 64
	rjmp    Label45
	sbrc    r19, 3          ; 0x08 = 8
	rjmp    Label45
	andi    r19, 0xfd       ; 253
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label42
	ori     r19, 0x08       ; 8
	ori     r23, 0x04       ; 4


Label42:
	sts     0x0068, r19
	lds     r20, 0x006b
	ori     r20, 0x80       ; 128
	sts     0x006b, r20
	cbi     PORTD, 6        ; 0x40 = 64
	rjmp    Label45


Label43:
	sbic    PINB, 2         ; 0x04 = 4
	rjmp    Label44
	sbrs    r19, 4          ; 0x10 = 16
	rjmp    Label45
	ori     r25, 0x04       ; 4
	rjmp    Label45


Label44:
	sbrs    r19, 4          ; 0x10 = 16
	rjmp    Label45
	andi    r19, 0xef       ; 239
	sts     0x0068, r19
	cbi     PORTD, 6        ; 0x40 = 64










Label45:
	lds     r19, 0x00f5
	sbrc    r19, 1          ; 0x02 = 2
	rjmp    Label46
	sbrc    r19, 2          ; 0x04 = 4
	rjmp    Label46
	sbrc    r19, 3          ; 0x08 = 8
	rjmp    Label46
	rjmp    Label48




Label46:
	lds     r19, 0x00fc
	dec     r19
	breq    Label47
	sts     0x00fc, r19
	rjmp    Label48


Label47:
	lds     r19, 0x00f6
	ori     r19, 0x80       ; 128
	sts     0x00f6, r19



Label48:
	ldi     r19, 0x8d       ; 141
	out     TCNT2, r19
	out     SREG, r0
	reti


__vect_UartRxComplete:
	in      r0, SREG
	in      r19, USR
	sbrc    r19, 4          ; 0x10 = 16
	rjmp    uart_rx_error
	sbrc    r19, 3          ; 0x08 = 8
	rjmp    uart_rx_error
	in      r19, UDR
	lds     r20, 0x0065
	sbrc    r20, 6          ; 0x40 = 64
	rjmp    uart_rx_iret
	sbrs    r20, 7          ; 0x80 = 128
	rjmp    Label56
	lds     r21, 0x00ef
	cpi     r21, 0xde       ; 222
	breq    RX_RecvdFirstByte
	lds     r21, 0x0066
	dec     r21
	sts     0x0066, r21
	rjmp    RX_StoreByte


RX_RecvdFirstByte:
	mov     r20, r19
	andi    r20, 0x0f       ; 15
	inc     r20
	sts     0x0066, r20
	rjmp    RX_StoreByte



RX_StoreByte:
	lds     r30, 0x00ef
	clr     r31
	st      Z+, r19
	sts     0x00ef, r30
	cpi     r21, 0x00       ; 0
	breq    RX_PacketFinished
	rjmp    uart_rx_iret


RX_PacketFinished:
	ldi     r30, 0xde       ; 222
	clr     r31
	ld      r19, Z+
	mov     r20, r19
	andi    r19, 0x0f       ; 15
	breq    RX_ChksumTest


RX_ChksumLoop:
	ld      r21, Z+
	add     r20, r21
	dec     r19
	brne    RX_ChksumLoop


RX_ChksumTest:
	ld      r21, Z+
	cp      r20, r21
	brne    RX_ChksumError
	lds     r20, 0x0065
	andi    r20, 0x7f       ; 127
	ori     r20, 0x40       ; 64
	sts     0x0065, r20
	rjmp    uart_rx_iret


RX_ChksumError:
	lds     r20, 0x0065
	andi    r20, 0x7f       ; 127
	sts     0x0065, r20
	rjmp    uart_rx_iret


Label56:
	cpi     r19, 0x02       ; 2
	breq    Label57
	rjmp    uart_rx_iret


Label57:
	ldi     r21, 0x0a       ; 10
	sts     0x00fd, r21
	ori     r20, 0x80       ; 128
	sts     0x0065, r20
	ldi     r20, 0xde       ; 222
	sts     0x00ef, r20
	rjmp    uart_rx_iret



uart_rx_error:
	in      r19, UDR
	lds     r19, 0x0065
	andi    r19, 0x7f       ; 127
	sts     0x0065, r19
	rjmp    uart_rx_iret








uart_rx_iret:
	out     SREG, r0
	reti


__vect_UartDataRegEmpty:
	in      r0, SREG
	lds     r19, 0x00d1
	lds     r20, 0x00d2
	cp      r19, r20
	brcs    TX_SendNextByte


TX_NoMoreBytes:
	andi    r23, 0xfe       ; 254
	in      r19, UCR
	andi    r19, 0x9f       ; 159
	out     UCR, r19
	out     SREG, r0
	reti


TX_SendNextByte:
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    TX_NoMoreBytes
	lds     r30, 0x00d1
	clr     r31
	ld      r19, Z+
	out     UDR, r19
	sts     0x00d1, r30
	out     SREG, r0
	reti


__vect_UartTxComplete:
	in      r0, SREG
	in      r19, UCR
	andi    r19, 0xbf       ; 191
	out     UCR, r19
	out     SREG, r0
	reti


__vect_UartAdcComplete:
	in      r0, SREG
	in      r20, ADCL
	in      r21, ADCH
	andi    r21, 0x03       ; 3
	andi    r24, 0x7f       ; 127
	sbrc    r24, 6          ; 0x40 = 64
	rjmp    ADC_Store_BattTemperature
	sbrc    r24, 5          ; 0x20 = 32
	rjmp    ADC_Store_LightSensor
	sbrc    r24, 4          ; 0x10 = 16
	rjmp    ADC_Store_ChargerCurrent
	sbrc    r24, 3          ; 0x08 = 8
	rjmp    ADC_Store_BattVoltage
	sbrc    r24, 2          ; 0x04 = 4
	rjmp    ADC_Store_KeySignal
	sbrc    r24, 1          ; 0x02 = 2
	rjmp    Label65
	sbrc    r24, 0          ; 0x01 = 1
	rjmp    Label68
	out     SREG, r0
	reti


Label65:
	mov     r19, r9
	sbrs    r19, 1          ; 0x02 = 2
	rjmp    Label66
	mov     r10, r21
	mov     r11, r20
	rjmp    Label67


Label66:
	cbi     PORTC, 0        ; 0x01 = 1
	sbi     PORTC, 1        ; 0x02 = 2
	sbi     PORTC, 2        ; 0x04 = 4
	cbi     PORTC, 3        ; 0x08 = 8
	sts     0x0062, r21
	sts     0x0063, r20


Label67:
	andi    r24, 0xfd       ; 253
	ori     r25, 0x01       ; 1
	out     SREG, r0
	reti


Label68:
	mov     r19, r9
	sbrs    r19, 1          ; 0x02 = 2
	rjmp    Label69
	cbi     PORTC, 0        ; 0x01 = 1
	sbi     PORTC, 2        ; 0x04 = 4
	sbi     PORTC, 1        ; 0x02 = 2
	sbi     PORTC, 3        ; 0x08 = 8
	mov     r12, r21
	mov     r13, r20
	ori     r19, 0x10       ; 16
	mov     r9, r19
	ldi     r19, 0x02       ; 2
	sts     0x0079, r19
	lds     r19, 0x0064
	ori     r19, 0x02       ; 2
	sts     0x0064, r19
	rjmp    Label70


Label69:
	sbi     PORTC, 2        ; 0x04 = 4
	cbi     PORTC, 3        ; 0x08 = 8
	sbi     PORTC, 1        ; 0x02 = 2
	cbi     PORTC, 0        ; 0x01 = 1
	sts     0x0060, r21
	sts     0x0061, r20
	lds     r19, 0x0064
	ori     r19, 0x01       ; 1
	sts     0x0064, r19


Label70:
	andi    r24, 0xfe       ; 254
	out     SREG, r0
	reti


ADC_Store_KeySignal:
	andi    r24, 0xfb       ; 251
	lsr     r20
	lsr     r20
	andi    r20, 0x3f       ; 63
	sbrc    r21, 0          ; 0x01 = 1
	ori     r20, 0x40       ; 64
	sbrc    r21, 1          ; 0x02 = 2
	ori     r20, 0x80       ; 128
	cpi     r20, 0xe8       ; 232
	brcs    Label72
	clr     r19
	rjmp    Label82


Label72:
	cpi     r20, 0xd0       ; 208
	brcs    Label73
	ldi     r19, 0x09       ; 9
	rjmp    Label82


Label73:
	cpi     r20, 0xb8       ; 184
	brcs    Label74
	ldi     r19, 0x08       ; 8
	rjmp    Label82


Label74:
	cpi     r20, 0xa0       ; 160
	brcs    Label75
	ldi     r19, 0x07       ; 7
	rjmp    Label82


Label75:
	cpi     r20, 0x88       ; 136
	brcs    Label76
	ldi     r19, 0x06       ; 6
	rjmp    Label82


Label76:
	cpi     r20, 0x70       ; 112
	brcs    Label77
	ldi     r19, 0x05       ; 5
	rjmp    Label82


Label77:
	cpi     r20, 0x58       ; 88
	brcs    Label78
	ldi     r19, 0x04       ; 4
	rjmp    Label82


Label78:
	cpi     r20, 0x40       ; 64
	brcs    Label79
	ldi     r19, 0x03       ; 3
	rjmp    Label82


Label79:
	cpi     r20, 0x26       ; 38
	brcs    Label80
	ldi     r19, 0x02       ; 2
	rjmp    Label82


Label80:
	cpi     r20, 0x0c       ; 12
	brcs    Label81
	ldi     r19, 0x0a       ; 10
	rjmp    Label82


Label81:
	ldi     r19, 0x01       ; 1











Label82:
	cpi     r19, 0x00       ; 0
	breq    Label83
	lds     r20, 0x0069
	cp      r20, r19
	breq    Label84
	ldi     r20, 0x01       ; 1
	sts     0x006c, r20
	sts     0x0069, r19
	out     SREG, r0
	reti


Label83:
	sts     0x006c, r19
	sts     0x0069, r19
	out     SREG, r0
	reti


Label84:
	lds     r20, 0x006c
	inc     r20
	sts     0x006c, r20
	cpi     r20, 0x03       ; 3
	brcc    Label85
	out     SREG, r0
	reti


Label85:
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label87


Label86:
	lds     r20, 0x0068
	ori     r20, 0x02       ; 2
	ori     r20, 0x08       ; 8
	andi    r20, 0xef       ; 239
	sts     0x0068, r20
	sts     0x006b, r19
	ori     r23, 0x04       ; 4
	out     SREG, r0
	reti


Label87:
	cpi     r19, 0x06       ; 6
	brcs    Label88
	cpi     r19, 0x0a       ; 10
	breq    Label88
	lds     r20, 0x0068
	ori     r20, 0x02       ; 2
	ori     r20, 0x20       ; 32
	andi    r20, 0xf7       ; 247
	andi    r20, 0xef       ; 239
	sts     0x0068, r20
	out     SREG, r0
	reti



Label88:
	lds     r20, 0x0068
	ori     r20, 0x40       ; 64
	sts     0x0068, r20
	rjmp    Label86


ADC_Store_BattVoltage:
	andi    r24, 0xf7       ; 247
	lds     r19, 0x007f
	cpi     r19, 0x00       ; 0
	brne    Label90
	inc     r19
	sts     0x007f, r19
	sts     0x007e, r20
	sts     0x007d, r21
	sts     0x0082, r20
	sts     0x0081, r21
	out     SREG, r0
	reti


Label90:
	mov     r1, r20
	mov     r2, r21
	lds     r19, 0x0082
	sub     r20, r19
	brcc    Label91
	lds     r19, 0x0081
	inc     r19
	rjmp    Label92


Label91:
	lds     r19, 0x0081


Label92:
	sub     r21, r19
	brcc    Label93
	com     r21
	com     r20
	inc     r20


Label93:
	cpi     r21, 0x00       ; 0
	breq    Label95


Label94:
	clr     r19
	sts     0x007f, r19
	out     SREG, r0
	reti


Label95:
	cpi     r20, 0x09       ; 9
	brcs    Label96
	rjmp    Label94


Label96:
	mov     r20, r1
	mov     r21, r2
	lds     r19, 0x007e
	add     r20, r19
	lds     r19, 0x007d
	adc     r21, r19
	lds     r19, 0x007f
	inc     r19
	cpi     r19, 0x08       ; 8
	breq    Label97
	sts     0x007f, r19
	sts     0x007e, r20
	sts     0x007d, r21
	sts     0x0082, r1
	sts     0x0081, r2
	out     SREG, r0
	reti


Label97:
	lsr     r20
	lsr     r20
	lsr     r20
	andi    r20, 0x1f       ; 31
	sbrc    r21, 0          ; 0x01 = 1
	ori     r20, 0x20       ; 32
	sbrc    r21, 1          ; 0x02 = 2
	ori     r20, 0x40       ; 64
	sbrc    r21, 2          ; 0x04 = 4
	ori     r20, 0x80       ; 128
	lsr     r21
	lsr     r21
	lsr     r21
	andi    r21, 0x1f       ; 31
	clr     r19
	sts     0x007f, r19
	sts     0x007c, r20
	sts     0x007b, r21
	out     SREG, r0
	reti


ADC_Store_ChargerCurrent:
	andi    r24, 0xef       ; 239
	sts     0x0083, r20
	sts     0x0084, r21
	ldi     r19, 0x99       ; 153
	sub     r20, r19
	brcc    Label99
	ldi     r19, 0x01       ; 1
	inc     r19
	rjmp    Label100


Label99:
	ldi     r19, 0x01       ; 1


Label100:
	sub     r21, r19
	brcc    Label101
	lds     r19, 0x008d
	inc     r19
	sts     0x008d, r19
	out     SREG, r0
	reti


Label101:
	clr     r19
	sts     0x008d, r19
	out     SREG, r0
	reti


ADC_Store_LightSensor:
	andi    r24, 0xdf       ; 223
	lsr     r20
	lsr     r20
	andi    r20, 0x3f       ; 63
	sbrc    r21, 0          ; 0x01 = 1
	ori     r20, 0x40       ; 64
	sbrc    r21, 1          ; 0x02 = 2
	ori     r20, 0x80       ; 128
	lds     r19, 0x008e
	sbrc    r19, 2          ; 0x04 = 4
	rjmp    Label103
	sts     0x00f1, r20
	ori     r19, 0x04       ; 4
	sts     0x008e, r19
	out     SREG, r0
	reti


Label103:
	lds     r21, 0x00f1
	sub     r21, r20
	brcc    Label104
	com     r21
	inc     r21


Label104:
	cpi     r21, 0x09       ; 9
	brcs    Label105
	rjmp    Label108


Label105:
	lds     r21, 0x00f1
	add     r20, r21
	brcc    Label106
	lsr     r20
	ori     r20, 0x80       ; 128
	rjmp    Label107


Label106:
	lsr     r20


Label107:
	sts     0x008f, r20


Label108:
	lds     r19, 0x008e
	andi    r19, 0xfb       ; 251
	sts     0x008e, r19
	out     SREG, r0
	reti


ADC_Store_BattTemperature:
	andi    r24, 0xbf       ; 191
	sts     0x0087, r20
	sts     0x0088, r21
	lds     r19, 0x00bb
	sbrc    r19, 0          ; 0x01 = 1
	rjmp    Label110
	out     SREG, r0
	reti


Label110:
	andi    r19, 0xfe       ; 254
	sts     0x00bb, r19
	ori     r22, 0x04       ; 4
	out     SREG, r0
	reti


__vect_SpiTransferComplete:
	in      r0, SREG
	lds     r19, 0x00f3
	sbrs    r19, 0          ; 0x01 = 1
	rjmp    SPI_HandleRead
	lds     r20, 0x00a1
	lds     r21, 0x00a2
	cp      r20, r21
	brne    SPI_SendNextByte
	ori     r19, 0x04       ; 4
	sts     0x00f3, r19
	rjmp    SPI_Int_Out


SPI_SendNextByte:
	lds     r30, 0x00a1
	clr     r31
	ld      r19, Z+
	sts     0x00a1, r30
	out     SPDR, r19
	rjmp    SPI_Int_Out


SPI_HandleRead:
	lds     r30, 0x00a3
	clr     r31
	in      r21, SPDR
	st      Z+, r21
	sts     0x00a3, r30
	sts     0x00a4, r30
	lds     r20, 0x00f7
	dec     r20
	breq    SPI_ReadFinished
	sts     0x00f7, r20
	lds     r20, 0x00f5
	sbrc    r20, 3          ; 0x08 = 8
	rjmp    Label114
	sbrc    r20, 2          ; 0x04 = 4
	rjmp    Label114
	clr     r20
	out     SPDR, r20
	rjmp    SPI_Int_Out



Label114:
	ori     r19, 0x0c       ; 12
	sts     0x00f3, r19
	rjmp    SPI_Int_Out


SPI_ReadFinished:
	ori     r19, 0x04       ; 4
	sts     0x00f3, r19





SPI_Int_Out:
	out     SREG, r0
	reti


__vect_Reset:
	cli
	ldi     r16, 0x01       ; 1
	out     SPH, r16
	ldi     r16, 0x5f       ; 95
	out     SPL, r16
	in      r16, MCUSR
	sbrs    r16, 0          ; 0x01 = 1
	rjmp    _on_external_reset
	rjmp    _on_power_on_reset


_on_external_reset:
	sbrs    r16, 1          ; 0x02 = 2
	rjmp    _on_watchdog_reset
	ldi     r17, 0x02       ; 2
	sts     0x00bf, r17
	rjmp    Label121


_on_power_on_reset:
	ldi     r17, 0x01       ; 1
	sts     0x00bf, r17
	rjmp    Label121


_on_watchdog_reset:
	ldi     r17, 0x03       ; 3
	sts     0x00bf, r17
	rjmp    Label121




Label121:
	clr     r16
	out     MCUSR, r16
	clr     r16
	ldi     r17, 0x01       ; 1
	out     DDRA, r17
	ldi     r17, 0x00       ; 0
	out     PORTA, r17

;; we don't have to touch DDRB since we're still using PB4 as output
;; but not for the Notification LED but as the chip select of the RFM12.
	ldi     r17, 0xb2       ; 178
	out     DDRB, r17

;; -> RFM12 CS high
;; -> CPU IRQ pullup on
;; -> KEY PRESS IRQ pullup on
;; -> AC IN IRQ pullup on
	ldi     r17, 0x1d       ; 29
	out     PORTB, r17

	ser     r17
	out     DDRC, r17
	ldi     r17, 0x6e       ; 110
	out     PORTC, r17
	ldi     r17, 0xf2       ; 242
	out     DDRD, r17
	ldi     r17, 0x25       ; 37
	out     PORTD, r17
	ldi     r17, 0x18       ; 24
	out     WDTCR, r17
	andi    r17, 0xfc       ; 252
	out     WDTCR, r17
	out     WDTCR, r16
	out     GIMSK, r16
	out     TIMSK, r16
	out     MCUCR, r16
	out     OCR1AH, r16
	out     OCR1AL, r16
	out     OCR1BH, r16
	out     OCR1BL, r16
	out     SPSR, r16
	ldi     r17, 0xd6       ; 214
	out     SPCR, r17
	out     EECR, r16
	ldi     r17, 0x98       ; 152
	out     UCR, r17
	ldi     r17, 0x01       ; 1
	out     UBRR, r17
	ldi     r17, 0x80       ; 128
	out     ACSR, r17
	ldi     r17, 0x9d       ; 157
	out     ADCSR, r17
	ldi     r17, 0x03       ; 3
	out     TCCR2, r17
	ldi     r17, 0x8d       ; 141
	out     TCNT2, r17
	ldi     r17, 0x05       ; 5
	out     TCCR0, r17
	ldi     r17, 0x4c       ; 76
	out     TCNT0, r17
	ldi     r17, 0x14       ; 20
	sts     0x007a, r17
	ldi     r17, 0x7c       ; 124
	sts     0x0080, r17
	ldi     r23, 0x00       ; 0
	ldi     r24, 0x00       ; 0
	ldi     r25, 0x00       ; 0
	ldi     r22, 0x00       ; 0
	sts     0x006c, r16
	sts     0x0068, r16
	sts     0x0065, r16
	sts     0x0067, r16
	sts     0x006d, r16
	mov     r9, r16
	sts     0x0064, r16
	sts     0x0075, r16
	sts     0x008c, r16
	sts     0x008e, r16
	sts     0x007b, r16
	sts     0x007c, r16
	sts     0x007d, r16
	sts     0x007e, r16
	sts     0x0081, r16
	sts     0x0082, r16
	sts     0x007f, r16
	sts     0x00f3, r16
	sts     0x00f4, r16
	sts     0x00f6, r16
	sts     0x00ff, r16
	sts     0x00f5, r16
	sts     0x00b6, r16
	sts     0x00b7, r16
	sts     0x00b8, r16
	clr     r7
	sts     0x00bc, r16
	sts     0x00bd, r16
	sts     0x00be, r16
	sts     0x00bb, r16
	ldi     r16, 0xc0       ; 192
	out     GIFR, r16
	ldi     r16, 0xc0       ; 192
	out     GIMSK, r16
	ldi     r16, 0xfd       ; 253
	out     TIFR, r16
	ldi     r16, 0x41       ; 65
	out     TIMSK, r16
	sei




MainLoop_Start:
main_cpu_irq_handler_start:
	sbrc    r23, 0          ; 0x01 = 1
	rjmp    Label158
	mov     r16, r23
	andi    r16, 0xfe       ; 254
	brne    Label123
	mov     r16, r22
	andi    r16, 0x86       ; 134
	brne    Label123

	mov	r16, r5
	andi	r16, 4 + 8	; rfm12 status request
	brne	Label123
	
	rjmp    Label158



Label123:
	sbis    PINB, 3         ; 0x08 = 8
	rjmp    Label124
	sbrc    r22, 0          ; 0x01 = 1
	rjmp    Label125
	andi    r22, 0xf7       ; 247
	ldi     r16, 0x03       ; 3
	mov     r8, r16
	cbi     PORTC, 5        ; 0x20 = 32
	ori     r22, 0x01       ; 1
	sbi     PORTC, 5        ; 0x20 = 32
	rjmp    Label158


Label124:
	;; check for rfm12 requests ...
	mov	r16, r5
	sbrc	r16, 2		; 4 -> rfm12 status
	rjmp	TX_RFM12_Status
	sbrc	r16, 3		; 8 -> internal status
	rjmp	TX_RFM12_Internal_Status
	
	sbrc	r5, 4
	sbrs    r22, 0          ; 0x01 = 1
	rjmp    TX_VersionAck


Label125:
	sbrs    r22, 3          ; 0x08 = 8
	rjmp    Label158
	sbrs    r23, 2          ; 0x04 = 4
	rjmp    Label127
	lds     r16, 0x0068
	sbrc    r16, 6          ; 0x40 = 64
	rjmp    Label126
	andi    r16, 0xf7       ; 247
	sts     0x0068, r16
	rjmp    Label127


Label126:
	andi    r16, 0xb7       ; 183
	ori     r16, 0x20       ; 32
	sts     0x0068, r16



Label127:
	clr     r22
	clr     r23
	rjmp    Label158


TX_VersionAck:
	sbrs    r23, 4          ; 0x10 = 16
	rjmp    Label130
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label129
	lds     r16, 0x00ff
	sbrs    r16, 7          ; 0x80 = 128
	rjmp    Label158
	andi    r16, 0x7f       ; 127
	sts     0x00ff, r16
	ori     r23, 0x01       ; 1
	andi    r23, 0xef       ; 239
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	ldi     r16, 0x09       ; 9
	mov     r17, r16
	st      Y+, r16
	ldi     r16, 0x31       ; 49
	add     r17, r16
	st      Y+, r16
	ldi     r16, 0x2e       ; 46
	add     r17, r16
	st      Y+, r16
	ldi     r16, 0x30       ; 48
	add     r17, r16
	st      Y+, r16
	ldi     r16, 0x37       ; 55
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x00bc
	add     r17, r16
	st      Y+, r16
	ldi     r16, 0x2e       ; 46
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x00bd
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x00be
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x00bf
	add     r17, r16
	st      Y+, r16
	st      Y+, r17
	clr     r16
	sts     0x00bf, r16
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label129:
	andi    r23, 0xef       ; 239


Label130:
	sbrs    r23, 1          ; 0x02 = 2
	rjmp    Label132
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label131
	ori     r23, 0x01       ; 1
	andi    r23, 0xfd       ; 253
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	rcall   TX_TouchpanelReadAck
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label131:
	andi    r23, 0xfd       ; 253
	clr     r16
	mov     r9, r16
	sts     0x0064, r16


Label132:
	sbrs    r23, 2          ; 0x04 = 4
	rjmp    TX_EepromReadAck
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label133
	ori     r23, 0x01       ; 1
	andi    r23, 0xfb       ; 251
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	rcall   TX_KeyboardAck
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label133:
	andi    r23, 0xfb       ; 251
	lds     r16, 0x0068
	andi    r16, 0xb7       ; 183
	sts     0x0068, r16


TX_EepromReadAck:
	sbrs    r23, 3          ; 0x08 = 8
	rjmp    Label137
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label136
	ori     r23, 0x01       ; 1
	andi    r23, 0xf7       ; 247
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r26, 0xd5       ; 213
	clr     r27
	ld      r16, X+
	ldi     r17, 0x02       ; 2
	st      Y+, r17
	ldi     r17, 0x40       ; 64
	or      r17, r16
	st      Y+, r17
	mov     r18, r17


TX_EepromReadAck_CopyLoop:
	ld      r17, X+
	st      Y+, r17
	add     r18, r17
	dec     r16
	brne    TX_EepromReadAck_CopyLoop
	st      Y+, r18
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label136:
	andi    r23, 0xf7       ; 247


Label137:
	sbrs    r22, 7          ; 0x80 = 128
	rjmp    TX_BatteryAck
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label138
	ori     r23, 0x01       ; 1
	andi    r22, 0x7f       ; 127
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r27, 0x01       ; 1
	ldi     r26, 0x13       ; 19
	ld      r16, X+
	mov     r18, r16
	rcall   Function2
	ld      r16, X+
	rcall   Function2
	ld      r16, X+
	rcall   Function2
	ldi     r16, 0x0d       ; 13
	st      Y+, r16
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label138:
	andi    r22, 0x7f       ; 127


TX_BatteryAck:
	sbrs    r23, 6          ; 0x40 = 64
	rjmp    Label143
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label142
	ori     r23, 0x01       ; 1
	andi    r23, 0xbf       ; 191
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	ldi     r16, 0x95       ; 149
	lds     r18, 0x00ff
	sbrc    r18, 1          ; 0x02 = 2
	ldi     r16, 0x99       ; 153
	sbrc    r18, 0          ; 0x01 = 1
	ldi     r16, 0x99       ; 153
	mov     r17, r16
	st      Y+, r16		; cmd/len
	ldi     r16, 0x00       ; 0
	sbis    PINB, 0         ; 0x01 = 1
	ldi     r16, 0x01       ; 1
	add     r17, r16
	st      Y+, r16		; pwr source (0)
	ldi     r16, 0x05       ; 5
	add     r17, r16
	st      Y+, r16		; battery chemistry (1)
	cli
	lds     r16, 0x007c
	add     r17, r16
	st      Y+, r16		; batt. voltage lsb (2)
	lds     r16, 0x007b
	add     r17, r16
	st      Y+, r16		; batt. voltage msb (3)
	sei
	ldi     r16, 0x00       ; 0
	lds     r18, 0x008c
	sbrc    r18, 0          ; 0x01 = 1
	ldi     r16, 0x08       ; 8
	sbrc    r18, 1          ; 0x02 = 2
	ldi     r16, 0x08       ; 8
	sbrc    r18, 2          ; 0x04 = 4
	ldi     r16, 0x08       ; 8
	lds     r18, 0x00b8
	sbrc    r18, 4          ; 0x10 = 16
	ldi     r16, 0x08       ; 8
	lds     r18, 0x0075
	sbrc    r18, 6          ; 0x40 = 64
	ori     r16, 0x40       ; 64
	add     r17, r16
	st      Y+, r16		; batt. status (4)
	lds     r18, 0x00ff
	sbrc    r18, 1          ; 0x02 = 2
	rjmp    TX_BatteryAck_2ndBatt
	sbrc    r18, 0          ; 0x01 = 1
	rjmp    TX_BatteryAck_2ndBatt
	rjmp    TX_BatteryAck_Out



TX_BatteryAck_2ndBatt:
	lds     r16, 0x00b6
	add     r17, r16
	st      Y+, r16		; (5)
	lds     r16, 0x00b7
	add     r17, r16
	st      Y+, r16		; (6)
	lds     r16, 0x00b8
	andi    r16, 0xef       ; 239
	sbic    PINB, 0         ; 0x01 = 1
	andi    r16, 0xf7       ; 247
	add     r17, r16
	st      Y+, r16		; (7)
	mov     r16, r7
	add     r17, r16
	st      Y+, r16		; (8)


TX_BatteryAck_Out:
	st      Y+, r17		; (chksum)
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label142:
	andi    r23, 0xbf       ; 191


Label143:
	sbrs    r23, 7          ; 0x80 = 128
	rjmp    TX_BacklightAck
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label150
	ori     r23, 0x01       ; 1
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	lds     r17, 0x0067
	sbrc    r17, 0          ; 0x01 = 1
	rjmp    TX_DefaultAck_CodecControl
	sbrc    r17, 1          ; 0x02 = 2
	rjmp    TX_DefaultAck_NotifyLED
	sbrc    r17, 2          ; 0x04 = 4
	rjmp    TX_DefaultAck_EEpromWrite
	sbrc    r17, 3          ; 0x08 = 8
	rjmp    TX_DefaultAck_SpiWrite
	clr     r17
	sts     0x0067, r17
	andi    r23, 0x7e       ; 126
	rjmp    TX_BacklightAck


TX_DefaultAck_CodecControl:
	ldi     r16, 0xd0       ; 208
	andi    r17, 0xfe       ; 254
	rjmp    TX_DefaultAck_PrepareSend


TX_DefaultAck_NotifyLED:
	ldi     r16, 0x80       ; 128
	andi    r17, 0xfd       ; 253
	rjmp    TX_DefaultAck_PrepareSend


TX_DefaultAck_EEpromWrite:
	ldi     r16, 0x50       ; 80
	andi    r17, 0xfb       ; 251
	rjmp    TX_DefaultAck_PrepareSend


TX_DefaultAck_SpiWrite:
	ldi     r16, 0xc0       ; 192
	andi    r17, 0xf7       ; 247
	rjmp    TX_DefaultAck_PrepareSend





TX_DefaultAck_PrepareSend:
	st      Y+, r16
	st      Y+, r16
	sts     0x00d2, r28
	sts     0x0067, r17
	cpi     r17, 0x00       ; 0
	brne    TX_DefaultAck_EnableUart
	andi    r23, 0x7f       ; 127


TX_DefaultAck_EnableUart:
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label150:
	andi    r23, 0x7f       ; 127
	clr     r17
	sts     0x0067, r17



TX_BacklightAck:
	sbrs    r23, 5          ; 0x20 = 32
	rjmp    TX_SpiReadAck
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label152
	ori     r23, 0x01       ; 1
	andi    r23, 0xdf       ; 223
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	ldi     r16, 0xd1       ; 209
	st      Y+, r16
	mov     r17, r16
	lds     r16, 0x008f
	add     r17, r16
	st      Y+, r16
	st      Y+, r17
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label152:
	andi    r23, 0xdf       ; 223


TX_SpiReadAck:
	sbrs    r22, 1          ; 0x02 = 2
	rjmp    TX_ThermalSensorAck
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label155
	ori     r23, 0x01       ; 1
	andi    r22, 0xfd       ; 253
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r27, 0x01       ; 1
	ldi     r26, 0x00       ; 0
	lds     r18, 0x00f8
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	ldi     r16, 0xb0       ; 176
	or      r16, r18
	st      Y+, r16
	mov     r17, r16


TX_SpiReadAck_CopyLoop:
	ld      r16, X+
	st      Y+, r16
	add     r17, r16
	dec     r18
	brne    TX_SpiReadAck_CopyLoop
	st      Y+, r17
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label155:
	andi    r22, 0xfd       ; 253


TX_ThermalSensorAck:
	sbrs    r22, 2          ; 0x04 = 4
	rjmp    Label158
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label157
	ori     r23, 0x01       ; 1
	andi    r22, 0xfb       ; 251
	clr     r29
	ldi     r28, 0xc0       ; 192
	sts     0x00d1, r28
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	ldi     r16, 0x62       ; 98
	st      Y+, r16
	mov     r17, r16
	cli
	lds     r16, 0x0087
	st      Y+, r16
	add     r17, r16
	lds     r16, 0x0088
	sei
	st      Y+, r16
	add     r17, r16
	st      Y+, r17
	sts     0x00d2, r28
	cli
	sbi     UCR, 5          ; 0x20 = 32
	sei
	rjmp    Label158


Label157:
	andi    r22, 0xfb       ; 251


















Label158:
main_adc_start:
	sbrc    r24, 7          ; 0x80 = 128
	rjmp    ADC_Block_Out
	sbic    ADCSR, 7        ; 0x80 = 128
	rjmp    ADC_AlreadyEnabled
	ldi     r16, 0x9d       ; 157
	out     ADCSR, r16


ADC_AlreadyEnabled:
	sbrs    r25, 0          ; 0x01 = 1
	rjmp    Label162
	ori     r24, 0x81       ; 129
	andi    r25, 0xfe       ; 254
	mov     r16, r9
	sbrs    r16, 1          ; 0x02 = 2
	rjmp    ADC_ConfigureTP_SenseX
	rjmp    Label161


ADC_ConfigureTP_SenseX:
	sbi     PORTC, 3        ; 0x08 = 8
	cbi     PORTC, 2        ; 0x04 = 4
	sbi     PORTC, 1        ; 0x02 = 2
	cbi     PORTC, 0        ; 0x01 = 1


Label161:
	rcall   DelayLoop
	ldi     r16, 0x07       ; 7
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out


Label162:
	sbrs    r25, 1          ; 0x02 = 2
	rjmp    Label165
	ori     r24, 0x82       ; 130
	andi    r25, 0xfd       ; 253
	mov     r16, r9
	sbrs    r16, 1          ; 0x02 = 2
	rjmp    ADC_ConfigureTP_SenseY
	cbi     PORTC, 2        ; 0x04 = 4
	sbi     PORTC, 0        ; 0x01 = 1
	sbi     PORTC, 1        ; 0x02 = 2
	cbi     PORTC, 3        ; 0x08 = 8
	rjmp    Label164


ADC_ConfigureTP_SenseY:
	sbi     PORTC, 0        ; 0x01 = 1
	cbi     PORTC, 1        ; 0x02 = 2
	sbi     PORTC, 2        ; 0x04 = 4
	cbi     PORTC, 3        ; 0x08 = 8


Label164:
	rcall   DelayLoop
	ldi     r16, 0x06       ; 6
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out


Label165:
	sbrs    r25, 2          ; 0x04 = 4
	rjmp    Label166
	ori     r24, 0x84       ; 132
	andi    r25, 0xfb       ; 251
	ldi     r16, 0x05       ; 5 -> Key signal input
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out


Label166:
	sbrs    r25, 3          ; 0x08 = 8
	rjmp    Label167
	ori     r24, 0x88       ; 136
	andi    r25, 0xf7       ; 247
	ldi     r16, 0x04       ; 4 -> main batt. 2/3 voltage sense
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out


Label167:
	sbrs    r25, 4          ; 0x10 = 16
	rjmp    Label168
	ori     r24, 0x90       ; 144
	andi    r25, 0xef       ; 239
	ldi     r16, 0x03       ; 3 -> charger current monitor
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out


Label168:
	sbrs    r25, 5          ; 0x20 = 32
	rjmp    Label169
	ori     r24, 0xa0       ; 160
	andi    r25, 0xdf       ; 223
	ldi     r16, 0x02       ; 2 -> Light sensor
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out


Label169:
	sbrs    r25, 6          ; 0x40 = 64
	rjmp    ADC_Block_Out
	ori     r24, 0xc0       ; 192
	andi    r25, 0xbf       ; 191
	ldi     r16, 0x01       ; 1 -> Batt. temp. sensor
	out     ADMUX, r16
	ldi     r16, 0xdd       ; 221
	out     ADCSR, r16
	rjmp    ADC_Block_Out










ADC_Block_Out:
	rjmp	main_charging_logic_start


main_charging_logic_start:
	lds     r16, 0x0075
	sbrs    r16, 0          ; 0x01 = 1
	rjmp    Label204
	sbic    PINB, 0         ; 0x01 = 1
	rjmp    Label203
	lds     r16, 0x008d
	cpi     r16, 0x02       ; 2
	brcs    Label179
	lds     r16, 0x0075
	ori     r16, 0x08       ; 8
	sts     0x0075, r16
	rjmp    Label193


Label179:
	lds     r16, 0x0075
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    Label180
	rjmp    Label214


Label180:
	andi    r16, 0xfd       ; 253
	sts     0x0075, r16
	lds     r16, 0x00ba
	dec     r16
	breq    Label181
	sts     0x00ba, r16
	rjmp    Label185


Label181:
	ldi     r16, 0x0a       ; 10
	sts     0x00ba, r16
	cli
	lds     r16, 0x0087
	lds     r17, 0x0088
	sei
	ldi     r18, 0x7b       ; 123
	sub     r16, r18
	brcc    Label182
	ldi     r18, 0x00       ; 0
	inc     r18
	rjmp    Label183


Label182:
	ldi     r18, 0x00       ; 0


Label183:
	sub     r17, r18
	brcs    Label184
	rcall   Function13
	rjmp    Label185


Label184:
	lds     r16, 0x0075
	ori     r16, 0x20       ; 32
	sts     0x0075, r16
	rjmp    Label193



Label185:
	lds     r16, 0x0076
	dec     r16
	breq    Label186
	sts     0x0076, r16
	rjmp    Label214


Label186:
	ldi     r16, 0x3c       ; 60
	sts     0x0076, r16
	lds     r16, 0x0077
	dec     r16
	breq    Label187
	sts     0x0077, r16
	rjmp    Label214


Label187:
	ldi     r16, 0x3c       ; 60
	sts     0x0077, r16
	lds     r16, 0x0078
	dec     r16
	breq    Label188
	sts     0x0078, r16
	cpi     r16, 0x07       ; 7
	breq    Label189
	rjmp    Label214


Label188:
	lds     r16, 0x0075
	ori     r16, 0x10       ; 16
	sts     0x0075, r16
	rjmp    Label193


Label189:
	cli
	lds     r16, 0x007c
	lds     r17, 0x007b
	sei
	ldi     r18, 0xaa       ; 170
	sub     r16, r18
	brcc    Label190
	ldi     r18, 0x02       ; 2
	inc     r18
	rjmp    Label191


Label190:
	ldi     r18, 0x02       ; 2


Label191:
	sub     r17, r18
	brcs    Label192
	rjmp    Label214


Label192:
	lds     r16, 0x0075
	ori     r16, 0x04       ; 4
	sts     0x0075, r16
	rjmp    Label193





Label193:
	lds     r16, 0x0075
	andi    r16, 0xfc       ; 252
	sts     0x0075, r16
	lds     r16, 0x0075
	sbrc    r16, 3          ; 0x08 = 8
	rjmp    Label194
	sbrc    r16, 4          ; 0x10 = 16
	rjmp    Label195
	sbrc    r16, 2          ; 0x04 = 4
	rjmp    Label197
	sbrc    r16, 5          ; 0x20 = 32
	rjmp    Label196
	rjmp    Label214


Label194:
	andi    r16, 0xf7       ; 247
	sts     0x0075, r16
	rjmp    Label198


Label195:
	andi    r16, 0xef       ; 239
	sts     0x0075, r16
	rjmp    Label198


Label196:
	andi    r16, 0xdf       ; 223
	sts     0x0075, r16


Label197:
	rjmp    Label202



Label198:
	cli
	lds     r16, 0x007c
	lds     r17, 0x007b
	sei
	ldi     r18, 0x99       ; 153
	sub     r16, r18
	brcc    Label199
	ldi     r18, 0x03       ; 3
	inc     r18
	rjmp    Label200


Label199:
	ldi     r18, 0x03       ; 3


Label200:
	sub     r17, r18
	brcc    Label201
	rjmp    Label202


Label201:
	lds     r16, 0x0075
	ori     r16, 0x80       ; 128
	ori     r16, 0x40       ; 64
	sts     0x0075, r16
	rjmp    Label202




Label202:
	sbi     PORTC, 6        ; 0x40 = 64
	cbi     PORTB, 1        ; 0x02 = 2
	lds     r16, 0x008c
	andi    r16, 0xfb       ; 251
	ori     r16, 0x08       ; 8
	sts     0x008c, r16
	rjmp    Label214


Label203:
	clr     r16
	sts     0x008c, r16
	sts     0x0075, r16
	cbi     PORTB, 1        ; 0x02 = 2
	sbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label214


Label204:
	sbic    PINB, 0         ; 0x01 = 1
	rjmp    Label213
	lds     r16, 0x0075
	sbrc    r16, 2          ; 0x04 = 4
	rjmp    Label214
	lds     r16, 0x008c
	sbrc    r16, 3          ; 0x08 = 8
	rjmp    Label205
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    Label212
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    Label210
	clr     r16
	sts     0x0087, r16
	sts     0x0088, r16
	ldi     r16, 0x03       ; 3
	sts     0x0089, r16
	lds     r16, 0x008c
	ori     r16, 0x01       ; 1
	sts     0x008c, r16
	rjmp    Label210


Label205:
	lds     r16, 0x0075
	sbrs    r16, 7          ; 0x80 = 128
	rjmp    Label206
	lds     r16, 0x006d
	sbrs    r16, 0          ; 0x01 = 1
	cbi     PORTC, 6        ; 0x40 = 64


Label206:
	cli
	lds     r16, 0x007c
	lds     r17, 0x007b
	sei
	ldi     r18, 0x8b       ; 139
	sub     r16, r18
	brcc    Label207
	ldi     r18, 0x03       ; 3
	inc     r18
	rjmp    Label208


Label207:
	ldi     r18, 0x03       ; 3


Label208:
	sub     r17, r18
	brcs    Label209
	rjmp    Label214


Label209:
	lds     r16, 0x0075
	andi    r16, 0x7f       ; 127
	andi    r16, 0xbf       ; 191
	sts     0x0075, r16
	sbi     PORTC, 6        ; 0x40 = 64
	clr     r16
	sts     0x0087, r16
	sts     0x0088, r16
	ldi     r16, 0x03       ; 3
	sts     0x0089, r16
	lds     r16, 0x008c
	ori     r16, 0x01       ; 1
	andi    r16, 0xf7       ; 247
	sts     0x008c, r16
	rjmp    Label210




Label210:
	cli
	lds     r16, 0x0087
	lds     r17, 0x0088
	sei
	ldi     r18, 0x8f       ; 143
	sub     r16, r18
	brcc    Label211
	ldi     r18, 0x00       ; 0
	inc     r18
	sub     r17, r18
	brcs    Label214


Label211:
	lds     r16, 0x008c
	andi    r16, 0xfe       ; 254
	ori     r16, 0x02       ; 2
	sts     0x008c, r16
	rjmp    Label212



Label212:
	rcall   Function13
	ldi     r16, 0x3c       ; 60
	sts     0x0076, r16
	ldi     r16, 0x3c       ; 60
	sts     0x0077, r16
	ldi     r16, 0x08       ; 8
	sts     0x0078, r16
	clr     r16
	sts     0x008d, r16
	ldi     r16, 0x05       ; 5
	sts     0x008a, r16
	ldi     r16, 0x0a       ; 10
	sts     0x00ba, r16
	sbi     PORTA, 0        ; 0x01 = 1
	sbi     PORTB, 1        ; 0x02 = 2
	ldi     r16, 0x01       ; 1
	sts     0x0075, r16
	lds     r16, 0x008c
	andi    r16, 0xfd       ; 253
	ori     r16, 0x04       ; 4
	sts     0x008c, r16
	rjmp    Label214


Label213:
	clr     r16
	sts     0x0075, r16
	sts     0x008c, r16
	sbi     PORTC, 6        ; 0x40 = 64
	rjmp    Label214














Label214:
main_r9_handler_start:
	mov     r16, r9
	sbrs    r16, 0          ; 0x01 = 1
	rjmp    Label215
	lds     r17, 0x0064
	sbrs    r17, 0          ; 0x01 = 1
	rjmp    Label240
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label239
	andi    r16, 0xfe       ; 254
	ori     r16, 0x0a       ; 10
	mov     r9, r16
	clr     r17
	sts     0x0064, r17
	ori     r25, 0x02       ; 2
	rjmp    Label240


Label215:
	sbrs    r16, 1          ; 0x02 = 2
	rjmp    Label236
	lds     r17, 0x0064
	sbrs    r17, 1          ; 0x02 = 2
	rjmp    Label240
	sbrs    r17, 3          ; 0x08 = 8
	rjmp    Label240
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label239
	sbic    PIND, 3         ; 0x08 = 8
	rjmp    Label237
	mov     r17, r11
	mov     r18, r10
	mov     r16, r13
	sub     r17, r16
	brcc    Label216
	mov     r16, r12
	inc     r16
	rjmp    Label217


Label216:
	mov     r16, r12


Label217:
	sub     r18, r16
	mov     r15, r17
	mov     r14, r18
	lds     r17, 0x0063
	lds     r18, 0x0062
	ldi     r16, 0x00       ; 0
	sub     r16, r17
	brcc    Label218
	inc     r18


Label218:
	ldi     r16, 0x02       ; 2
	sub     r16, r18
	brcc    Label219
	rjmp    Label226


Label219:
	lds     r17, 0x0061
	lds     r18, 0x0060
	ldi     r16, 0x00       ; 0
	sub     r16, r17
	brcc    Label220
	inc     r18


Label220:
	ldi     r16, 0x02       ; 2
	sub     r16, r18
	brcc    Label221
	rjmp    Label223


Label221:
	mov     r17, r15
	mov     r18, r14
	ldi     r16, 0xef       ; 239
	sub     r16, r17
	brcc    Label222
	inc     r18


Label222:
	ldi     r16, 0x03       ; 3
	sub     r16, r18
	brcc    Label225
	rjmp    Label232


Label223:
	mov     r17, r15
	mov     r18, r14
	ldi     r16, 0xef       ; 239
	sub     r16, r17
	brcc    Label224
	inc     r18


Label224:
	ldi     r16, 0x03       ; 3
	sub     r16, r18
	brcc    Label225
	rjmp    Label232





Label225:
	rjmp    Label233


Label226:
	lds     r17, 0x0061
	lds     r18, 0x0060
	ldi     r16, 0x00       ; 0
	sub     r16, r17
	brcc    Label227
	inc     r18


Label227:
	ldi     r16, 0x02       ; 2
	sub     r16, r18
	brcc    Label228
	rjmp    Label230


Label228:
	mov     r17, r15
	mov     r18, r14
	ldi     r16, 0xef       ; 239
	sub     r16, r17
	brcc    Label229
	inc     r18


Label229:
	ldi     r16, 0x03       ; 3
	sub     r16, r18
	brcc    Label225
	rjmp    Label232


Label230:
	mov     r17, r15
	mov     r18, r14
	ldi     r16, 0xef       ; 239
	sub     r16, r17
	brcc    Label231
	inc     r18


Label231:
	ldi     r16, 0x03       ; 3
	sub     r16, r18
	brcc    Label225
	rjmp    Label232





Label232:
	mov     r16, r9
	ori     r16, 0x02       ; 2
	andi    r16, 0xe7       ; 231
	mov     r9, r16
	clr     r16
	sts     0x0064, r16
	ori     r25, 0x02       ; 2
	rjmp    Label240


Label233:
	mov     r16, r9
	sbrs    r16, 3          ; 0x08 = 8
	rjmp    Label234
	andi    r16, 0xe5       ; 229
	ori     r16, 0x04       ; 4
	mov     r9, r16
	ldi     r16, 0x04       ; 4
	sts     0x0079, r16
	rjmp    Label235


Label234:
	andi    r16, 0xfd       ; 253
	ori     r16, 0x01       ; 1
	mov     r9, r16
	ori     r25, 0x02       ; 2


Label235:
	clr     r17
	sts     0x0064, r17
	rjmp    Label240


Label236:
	sbrs    r16, 2          ; 0x04 = 4
	rjmp    Label240
	lds     r17, 0x0064
	sbrs    r17, 2          ; 0x04 = 4
	rjmp    Label240
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    Label239
	sbic    PIND, 3         ; 0x08 = 8
	rjmp    Label237
	andi    r16, 0xbb       ; 187
	ori     r16, 0x02       ; 2
	mov     r9, r16
	clr     r17
	sts     0x0064, r17
	ori     r25, 0x02       ; 2
	ori     r23, 0x02       ; 2
	rjmp    Label240



Label237:
	mov     r16, r9
	sbrs    r16, 7          ; 0x80 = 128
	rjmp    Label238
	ldi     r16, 0x40       ; 64
	mov     r9, r16
	clr     r16
	sts     0x0064, r16
	ori     r23, 0x02       ; 2
	rjmp    Label240


Label238:
	clr     r16
	mov     r9, r16
	sts     0x0064, r16
	in      r16, GIMSK
	ori     r16, 0x80       ; 128
	out     GIMSK, r16
	ldi     r16, 0x80       ; 128
	out     GIFR, r16
	rjmp    Label240




Label239:
	clr     r16
	mov     r9, r16
	sts     0x0064, r16
	cbi     PORTC, 0        ; 0x01 = 1
	sbi     PORTC, 2        ; 0x04 = 4
	sbi     PORTC, 1        ; 0x02 = 2
	sbi     PORTC, 3        ; 0x08 = 8












Label240:
main_spi_start:
	lds     r16, 0x00f3
	sbrc    r16, 7          ; 0x80 = 128
	rjmp    SPI_Block_Intermediate
	lds     r17, 0x00f4
	andi    r17, 0x0f       ; 15
	brne    Label241
	rjmp    SPI_Block_Intermediate


Label241:
	sbis    SPCR, 6         ; 0x40 = 64
	sbi     SPCR, 6         ; 0x40 = 64
	lds     r18, 0x00f4
	sbrs    r18, 1          ; 0x02 = 2
	rjmp    Label242
	ori     r16, 0x81       ; 129
	sts     0x00f3, r16
	andi    r18, 0xfd       ; 253
	sts     0x00f4, r18
	lds     r17, 0x00f6
	andi    r17, 0x7f       ; 127
	ori     r17, 0x01       ; 1
	sts     0x00f6, r17
	ldi     r17, 0x11       ; 17
	sts     0x00fc, r17
	lds     r17, 0x00f5
	ori     r17, 0x02       ; 2
	sts     0x00f5, r17
	cbi     PORTD, 5        ; 0x20 = 32
	clr     r16
	sts     0x00a1, r16
	sts     0x00a2, r16
	ldi     r16, 0x06       ; 6
	out     SPDR, r16
	rjmp    SPI_Block_Intermediate


Label242:
	sbrs    r18, 0          ; 0x01 = 1
	rjmp    Label245
	ori     r16, 0x81       ; 129
	sts     0x00f3, r16
	andi    r18, 0xfe       ; 254
	sts     0x00f4, r18
	lds     r17, 0x00f5
	ori     r17, 0x01       ; 1
	sts     0x00f5, r17
	cbi     PORTD, 5        ; 0x20 = 32
	clr     r29
	ldi     r28, 0x90       ; 144
	sts     0x00a1, r28
	lds     r17, 0x00fb
	cpi     r17, 0x00       ; 0
	breq    Label244
	lds     r17, 0x00f9
	st      Y+, r17
	sts     0x00a2, r28
	lds     r16, 0x00fb
	sts     0x00f7, r16
	ldi     r16, 0x03       ; 3
	lds     r17, 0x00fa
	cpi     r17, 0x01       ; 1
	brne    Label243
	ori     r16, 0x08       ; 8


Label243:
	out     SPDR, r16
	rjmp    SPI_Block_Intermediate


Label244:
	sts     0x00a2, r28
	ldi     r16, 0x01       ; 1
	sts     0x00f7, r16
	ldi     r16, 0x05       ; 5
	out     SPDR, r16
	rjmp    SPI_Block_Intermediate


Label245:
	sbrs    r18, 2          ; 0x04 = 4
	rjmp    Label247
	ori     r16, 0x81       ; 129
	sts     0x00f3, r16
	andi    r18, 0xfb       ; 251
	sts     0x00f4, r18
	ldi     r17, 0x02       ; 2
	sts     0x00fc, r17
	lds     r17, 0x00f5
	ori     r17, 0x04       ; 4
	sts     0x00f5, r17
	cbi     PORTD, 5        ; 0x20 = 32
	nop
	nop
	nop
	sbi     PORTD, 5        ; 0x20 = 32
	ldi     r16, 0x30       ; 48


Label246:
	dec     r16
	brne    Label246
	clr     r29
	ldi     r28, 0x90       ; 144
	sts     0x00a1, r28
	ldi     r16, 0x10       ; 16
	st      Y+, r16
	st      Y+, r16
	sts     0x00a2, r28
	ldi     r16, 0x06       ; 6
	sts     0x00f7, r16
	ldi     r16, 0xa1       ; 161
	out     SPDR, r16
	rjmp    SPI_Block_Intermediate


Label247:
	sbrs    r18, 3          ; 0x08 = 8
	rjmp    SPI_Block_Intermediate
	ori     r16, 0x81       ; 129
	sts     0x00f3, r16
	andi    r18, 0xf7       ; 247
	sts     0x00f4, r18
	ldi     r17, 0x03       ; 3
	sts     0x00fc, r17
	lds     r17, 0x00f5
	ori     r17, 0x08       ; 8
	sts     0x00f5, r17
	cbi     PORTD, 5        ; 0x20 = 32
	nop
	nop
	nop
	sbi     PORTD, 5        ; 0x20 = 32
	ldi     r16, 0x30       ; 48


Label248:
	dec     r16
	brne    Label248
	clr     r29
	ldi     r28, 0x90       ; 144
	sts     0x00a1, r28
	ldi     r16, 0x20       ; 32
	st      Y+, r16
	st      Y+, r16
	sts     0x00a2, r28
	ldi     r16, 0x07       ; 7
	sts     0x00f7, r16
	ldi     r16, 0xa1       ; 161
	out     SPDR, r16
	rjmp    SPI_Block_Intermediate









SPI_Block_Intermediate:
	lds     r16, 0x00f3
	sbrs    r16, 2          ; 0x04 = 4
	rjmp    SPI_Block_Out
	lds     r17, 0x00f5
	sbrs    r17, 0          ; 0x01 = 1
	rjmp    Label254
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    Label250
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    Label251


Label250:
	andi    r16, 0xfa       ; 250
	ori     r16, 0x02       ; 2
	sts     0x00f3, r16
	ldi     r16, 0xa5       ; 165
	sts     0x00a3, r16
	clr     r16
	sts     0x00f8, r16
	out     SPDR, r16
	rjmp    SPI_Block_Out


Label251:
	sbi     PORTD, 5        ; 0x20 = 32
	andi    r16, 0x79       ; 121
	sts     0x00f3, r16
	andi    r17, 0xfe       ; 254
	sts     0x00f5, r17
	ldi     r27, 0x01       ; 1
	ldi     r26, 0x00       ; 0
	clr     r29
	ldi     r28, 0xa5       ; 165
	lds     r18, 0x00a4
	clr     r17


Label252:
	ld      r16, Y+
	st      X+, r16
	inc     r17
	cp      r18, r28
	brne    Label252
	sts     0x00f8, r17
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    SPI_Block_Out
	ori     r22, 0x02       ; 2
	lds     r16, 0x00ff
	andi    r16, 0x03       ; 3
	breq    Label253
	rjmp    SPI_Block_Out


Label253:
	ori     r16, 0x01       ; 1
	sts     0x00ff, r16
	rjmp    SPI_Block_Out


Label254:
	sbrs    r17, 1          ; 0x02 = 2
	rjmp    Label260
	sbi     PORTD, 5        ; 0x20 = 32
	lds     r18, 0x00f6
	sbrc    r18, 0          ; 0x01 = 1
	rjmp    Label255
	sbrc    r18, 1          ; 0x02 = 2
	rjmp    Label259


Label255:
	andi    r16, 0xfb       ; 251
	sts     0x00f3, r16
	andi    r18, 0xfe       ; 254
	ori     r18, 0x02       ; 2
	sts     0x00f6, r18
	clr     r29
	ldi     r28, 0x90       ; 144
	sts     0x00a1, r28
	ldi     r27, 0x01       ; 1
	ldi     r26, 0x13       ; 19
	ld      r18, X+
	cpi     r18, 0x00       ; 0
	breq    Label258
	ld      r17, X+
	st      Y+, r17
	ld      r16, X+


Label256:
	ld      r17, X+
	st      Y+, r17
	dec     r18
	brne    Label256
	sts     0x00a2, r28
	cbi     PORTD, 5        ; 0x20 = 32
	mov     r17, r16
	ldi     r16, 0x02       ; 2
	cpi     r17, 0x01       ; 1
	brne    Label257
	ori     r16, 0x08       ; 8


Label257:
	out     SPDR, r16
	rjmp    SPI_Block_Out


Label258:
	ld      r17, X+
	st      Y+, r17
	sts     0x00a2, r28
	cbi     PORTD, 5        ; 0x20 = 32
	ldi     r16, 0x01       ; 1
	out     SPDR, r16
	rjmp    SPI_Block_Out


Label259:
	sbrs    r18, 7          ; 0x80 = 128
	rjmp    SPI_Block_Out
	andi    r17, 0xfd       ; 253
	sts     0x00f5, r17
	andi    r18, 0x7d       ; 125
	sts     0x00f6, r18
	andi    r16, 0x7a       ; 122
	sts     0x00f3, r16
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    SPI_Block_Out
	lds     r16, 0x0067	; queue SPI-Write default ack ...
	ori     r16, 0x08       ; 8
	sts     0x0067, r16
	ori     r23, 0x80       ; 128
	rjmp    SPI_Block_Out


Label260:
	sbrs    r17, 2          ; 0x04 = 4
	rjmp    Label266
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    Label261
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    Label262


Label261:
	lds     r18, 0x00f6
	sbrs    r18, 7          ; 0x80 = 128
	rjmp    SPI_Block_Out
	andi    r16, 0xfa       ; 250
	ori     r16, 0x02       ; 2
	sts     0x00f3, r16
	ldi     r16, 0xa5       ; 165
	sts     0x00a3, r16
	clr     r16
	sts     0x00f8, r16
	out     SPDR, r16
	rjmp    SPI_Block_Out


Label262:
	sbrs    r16, 3          ; 0x08 = 8
	rjmp    SPI_StoreReadPackVersion
	andi    r16, 0xf3       ; 243
	sts     0x00f3, r16
	ldi     r16, 0x28       ; 40


Label263:
	dec     r16
	brne    Label263
	out     SPDR, r16
	rjmp    SPI_Block_Out


SPI_StoreReadPackVersion:
	andi    r16, 0x79       ; 121
	sts     0x00f3, r16
	andi    r17, 0xfb       ; 251
	sts     0x00f5, r17
	lds     r18, 0x00f6
	andi    r18, 0x7f       ; 127
	sts     0x00f6, r18
	lds     r16, 0x00ff
	ori     r16, 0x80       ; 128
	sts     0x00ff, r16
	clr     r29
	ldi     r28, 0xa5       ; 165
	ld      r16, Y+
	cpi     r16, 0xa1       ; 161
	brne    SPI_ClearPackVersion
	ld      r16, Y+
	cpi     r16, 0x13       ; 19
	brne    SPI_ClearPackVersion
	mov     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	cp      r17, r16
	brne    SPI_ClearPackVersion
	ldi     r28, 0xa5       ; 165
	inc     r28
	inc     r28
	ld      r16, Y+
	sts     0x00bc, r16
	ld      r16, Y+
	sts     0x00bd, r16
	ld      r16, Y+
	sts     0x00be, r16
	rjmp    SPI_Block_Out




SPI_ClearPackVersion:
	clr     r16
	sts     0x00bc, r16
	sts     0x00bd, r16
	sts     0x00be, r16
	rjmp    SPI_Block_Out


Label266:
	sbrs    r17, 3          ; 0x08 = 8
	rjmp    SPI_Block_Out
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    Label267
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    Label268


Label267:
	lds     r18, 0x00f6
	sbrs    r18, 7          ; 0x80 = 128
	rjmp    SPI_Block_Out
	andi    r16, 0xfa       ; 250
	ori     r16, 0x02       ; 2
	sts     0x00f3, r16
	ldi     r16, 0xa5       ; 165
	sts     0x00a3, r16
	clr     r16
	sts     0x00f8, r16
	out     SPDR, r16
	rjmp    SPI_Block_Out


Label268:
	sbrs    r16, 3          ; 0x08 = 8
	rjmp    SPI_StoreRead2ndBattState
	andi    r16, 0xf3       ; 243
	sts     0x00f3, r16
	ldi     r16, 0x28       ; 40


Label269:
	dec     r16
	brne    Label269
	out     SPDR, r16
	rjmp    SPI_Block_Out


SPI_StoreRead2ndBattState:
	andi    r16, 0x79       ; 121
	sts     0x00f3, r16
	andi    r17, 0xf7       ; 247
	sts     0x00f5, r17
	lds     r18, 0x00f6
	andi    r18, 0x7f       ; 127
	sts     0x00f6, r18
	clr     r29
	ldi     r28, 0xa5       ; 165
	ld      r16, Y+
	cpi     r16, 0xa1       ; 161
	brne    Label271
	ld      r16, Y+
	cpi     r16, 0x24       ; 36
	brne    Label271
	mov     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	add     r17, r16
	ld      r16, Y+
	cp      r17, r16
	brne    Label271
	ldi     r28, 0xa5       ; 165
	inc     r28
	inc     r28
	ld      r16, Y+
	sts     0x00b6, r16
	ld      r16, Y+
	sts     0x00b7, r16
	ld      r16, Y+
	sts     0x00b8, r16
	ld      r7, Y+
	lds     r16, 0x00ff
	andi    r16, 0xfe       ; 254
	ori     r16, 0x02       ; 2
	sts     0x00ff, r16
	rjmp    SPI_Block_Out




Label271:
	lds     r16, 0x00ff
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    Label272
	ori     r16, 0x01       ; 1
	andi    r16, 0xfd       ; 253
	sts     0x00ff, r16
	ldi     r16, 0x05       ; 5
	sts     0x00b9, r16
	rjmp    SPI_Block_Out


Label272:
	lds     r17, 0x00b9
	dec     r17
	breq    SPI_Clear2ndBattState
	sts     0x00b9, r17
	andi    r16, 0xfd       ; 253
	sts     0x00ff, r16
	rjmp    SPI_Block_Out


SPI_Clear2ndBattState:
	andi    r16, 0xfc       ; 252
	sts     0x00ff, r16
	clr     r16
	clr     r7
	sts     0x00b6, r16
	sts     0x00b7, r16
	sts     0x00b8, r16
	rjmp    SPI_Block_Out
























SPI_Block_Out:
msg_handler_start:
	lds     r16, 0x0065
	sbrs    r16, 6          ; 0x40 = 64
	rjmp    RX_Handler_DEMUX_Out
	sbis    PINB, 3         ; 0x08 = 8
	rjmp    RX_Handler_DEMUX
	clr     r16
	sts     0x0065, r16
	rjmp    RX_Handler_DEMUX_Out


RX_Handler_DEMUX:
	ldi     r28, 0xde       ; 222
	clr     r29
	ld      r16, Y+
	sts     0x00ef, r28
	andi    r16, 0xf0       ; 240
	cpi     r16, 0x00       ; 0
	brne    Label276
	rcall   RX_Handler_MSG_VERSION
	rjmp    RX_Handler_DEMUX_Out


Label276:
	cpi     r16, 0x40       ; 64
	brne    Label277
	rcall   RX_Handler_MSG_EEPROM_READ
	rjmp    RX_Handler_DEMUX_Out


Label277:
	cpi     r16, 0x50       ; 80
	brne    Label278
	rcall   RX_Handler_MSG_EEPROM_WRITE
	rjmp    RX_Handler_DEMUX_Out


Label278:
	cpi     r16, 0x80       ; 128
	brne    Label279
	rcall   RX_Handler_MSG_NOTIFY_LED
	rjmp    RX_Handler_DEMUX_Out


Label279:
	cpi     r16, 0x90       ; 144
	brne    Label280
	rcall   RX_Handler_MSG_BATTERY
	rjmp    RX_Handler_DEMUX_Out


Label280:
	cpi     r16, 0xd0       ; 208
	brne    Label281
	rcall   RX_Handler_MSG_BACKLIGHT
	rjmp    RX_Handler_DEMUX_Out


Label281:
	cpi     r16, 0xb0       ; 176
	brne    Label282
	rcall   RX_Handler_MSG_SPI_READ
	rjmp    RX_Handler_DEMUX_Out


Label282:
	cpi     r16, 0xc0       ; 192
	brne    Label283
	rcall   RX_Handler_MSG_SPI_WRITE
	rjmp    RX_Handler_DEMUX_Out


Label283:
	cpi     r16, 0x60       ; 96
	brne    RX_Handler_TestForRfm12Packet
	rcall   RX_Handler_MSG_THERMAL_SENSOR
	rjmp    RX_Handler_DEMUX_Out


RX_Handler_TestForRfm12Packet:
	cpi	r16, 0xa0
	brne	Label284	; discard packet

	rcall	RX_Handler_MSG_RFM12
	
	;; clear new message flag
	lds	r16, 0x0065
	andi	r16, 0xbf
	sts	0x0065, r16

	;; go back into the main loop ...
	rjmp	RX_Handler_DEMUX_Out
	

Label284:
	;; received an invalid request, ignore.
	clr     r16
	sts     0x0065, r16
	rjmp    RX_Handler_DEMUX_Out













RX_Handler_DEMUX_Out:
	sbis    PINB, 3         ; 0x08 = 8
	rjmp    Label287
	lds     r16, 0x008e
	sbrs    r16, 0          ; 0x01 = 1
	rjmp    Label286
	cbi     PORTC, 7        ; 0x80 = 128
	clr     r16
	sts     0x008e, r16
	out     TCCR1B, r16
	rjmp    Label287


Label286:
	sbrs    r16, 1          ; 0x02 = 2
	rjmp    Label287
	clr     r16
	sts     0x008e, r16
	rjmp    Label287





Label287:
	sbic    PINB, 3         ; 0x08 = 8
	cbi     PORTD, 7        ; 0x80 = 128
	cli
	sbis    PINB, 0         ; 0x01 = 1
	rjmp    FinishLoopWithoutSleeping
	lds     r16, 0x0068
	andi    r16, 0x12       ; 18
	brne    FinishLoopWithoutSleeping
	cpi     r23, 0x00       ; 0
	brne    FinishLoopWithoutSleeping
	cpi     r24, 0x00       ; 0
	brne    FinishLoopWithoutSleeping
	cpi     r25, 0x00       ; 0
	brne    FinishLoopWithoutSleeping
	mov     r16, r9
	cpi     r16, 0x00       ; 0
	brne    FinishLoopWithoutSleeping
	mov     r16, r22
	andi    r16, 0x86       ; 134
	brne    FinishLoopWithoutSleeping
	lds     r16, 0x0065
	cpi     r16, 0x00       ; 0
	brne    FinishLoopWithoutSleeping
	lds     r16, 0x006d
	andi    r16, 0x01       ; 1
	brne    FinishLoopWithoutSleeping
	lds     r16, 0x00f4
	andi    r16, 0x0f       ; 15
	brne    FinishLoopWithoutSleeping
	lds     r16, 0x00f3
	andi    r16, 0x80       ; 128
	brne    FinishLoopWithoutSleeping
	lds     r16, 0x008c
	andi    r16, 0x0f       ; 15
	brne    FinishLoopWithoutSleeping
	sbic    PINB, 3         ; 0x08 = 8
	rjmp    SleepEnable_PowerDown
SleepEnable_Idle:
	cbi     ADCSR, 7        ; 0x80 = 128
	cbi     SPCR, 6         ; 0x40 = 64
	ldi     r16, 0x40       ; 64
	out     MCUCR, r16
	sei
	sleep			; FIXME why sleep here?  PB3 is low ?
	rjmp    MainLoop_Start














FinishLoopWithoutSleeping:
	sei
	rjmp    MainLoop_Start


SleepEnable_PowerDown:
	lds     r16, 0x008e
	andi    r16, 0x03       ; 3
	brne    FinishLoopWithoutSleeping
	cbi     ADCSR, 7        ; 0x80 = 128
	cbi     SPCR, 6         ; 0x40 = 64
	cbi     PORTC, 3        ; 0x08 = 8
	cbi     UCR, 4          ; 0x10 = 16
	cbi     UCR, 3          ; 0x08 = 8
	cbi     PORTD, 0        ; 0x01 = 1
	cbi     PORTD, 1        ; 0x02 = 2
	cbi     DDRD, 0         ; 0x01 = 1
	cbi     DDRD, 1         ; 0x02 = 2
	cbi     PORTB, 5        ; 0x20 = 32
	cbi     PORTB, 7        ; 0x80 = 128
	cbi     PORTD, 7        ; 0x80 = 128
	cbi     PORTC, 4        ; 0x10 = 16
	ldi     r16, 0x60       ; 96
	out     MCUCR, r16
	sei
	sleep
	nop
	nop
	nop
	sbi     DDRD, 1         ; 0x02 = 2
	sbi     UCR, 4          ; 0x10 = 16
	sbi     UCR, 3          ; 0x08 = 8
	sbi     PORTC, 3        ; 0x08 = 8
	sbi     SPCR, 6         ; 0x40 = 64
	clr     r16
	clr     r7
	sts     0x00b6, r16
	sts     0x00b7, r16
	sts     0x00b8, r16
	sts     0x00ff, r16
	rjmp    MainLoop_Start



DelayLoop:
	ser     r16


Label290:
	dec     r16
	brne    Label290
	ret





Function2:
	swap    r16
	ldi     r17, 0x0f       ; 15
	and     r17, r16
	cpi     r17, 0x0a       ; 10
	brcc    Label291
	ldi     r18, 0x30       ; 48
	rjmp    Label292


Label291:
	ldi     r18, 0x37       ; 55


Label292:
	add     r17, r18
	st      Y+, r17
	swap    r16
	andi    r16, 0x0f       ; 15
	cpi     r16, 0x0a       ; 10
	brcc    Label293
	ldi     r18, 0x30       ; 48
	rjmp    Label294


Label293:
	ldi     r18, 0x37       ; 55


Label294:
	add     r16, r18
	st      Y+, r16
	ret



TX_TouchpanelReadAck:
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	mov     r17, r9
	sbrc    r17, 6          ; 0x40 = 64
	rjmp    Label295
	ori     r17, 0x80       ; 128
	mov     r9, r17
	ldi     r16, 0x34       ; 52
	mov     r17, r16
	st      Y+, r16
	lds     r16, 0x0060
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x0061
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x0062
	add     r17, r16
	st      Y+, r16
	lds     r16, 0x0063
	add     r17, r16
	st      Y+, r16
	st      Y+, r17
	ret



Label295:
	ldi     r16, 0x30       ; 48
	st      Y+, r16
	st      Y+, r16
	clr     r17
	mov     r9, r17
	in      r16, GIMSK
	ori     r16, 0x80       ; 128
	out     GIMSK, r16
	ldi     r16, 0x80       ; 128
	out     GIFR, r16
	ret



TX_KeyboardAck:
	ldi     r16, 0x02       ; 2
	st      Y+, r16
	ldi     r16, 0x21       ; 33
	mov     r17, r16
	st      Y+, r16
	lds     r16, 0x0068
	andi    r16, 0xb7       ; 183
	lds     r18, 0x006b
	add     r17, r18
	st      Y+, r18
	st      Y+, r17
	sts     0x0068, r16
	ret




Function5:
	sbic    EECR, 1         ; 0x02 = 2
	rjmp    Function5
	clr     r29
	ldi     r28, 0xd5       ; 213
	lds     r17, 0x00d4
	lsl     r17
	st      Y+, r17
	lds     r17, 0x00d4
	clr     r16
	out     EEARH, r16
	lds     r16, 0x00d3


Label296:
	out     EEAR, r16
	sbi     EECR, 0         ; 0x01 = 1
	in      r18, EEDR
	st      Y+, r18
	inc     r16
	out     EEAR, r16
	sbi     EECR, 0         ; 0x01 = 1
	in      r18, EEDR
	st      Y+, r18
	dec     r17
	breq    Label297
	inc     r16
	rjmp    Label296


Label297:
	ret




Function6:
	sbic    EECR, 1         ; 0x02 = 2
	rjmp    Function6
	lds     r17, 0x00d4
	clr     r29
	ldi     r28, 0xd5       ; 213
	clr     r16
	out     EEARH, r16
	lds     r16, 0x00d3


Label298:
	out     EEAR, r16
	ld      r18, Y+
	out     EEDR, r18
	cli
	sbi     EECR, 2         ; 0x04 = 4
	sbi     EECR, 1         ; 0x02 = 2
	sei


Label299:
	sbic    EECR, 1         ; 0x02 = 2
	rjmp    Label299
	dec     r17
	breq    Label300
	inc     r16
	rjmp    Label298


Label300:
	ret



RX_Handler_MSG_EEPROM_READ:
	lds     r28, 0x00ef
	clr     r29
	ld      r16, Y+
	lsl     r16
	sts     0x00d3, r16
	ld      r16, Y+
	sts     0x00d4, r16
	rcall   Function5
	ori     r23, 0x08       ; 8
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16
	ret



RX_Handler_MSG_EEPROM_WRITE:
	ldi     r26, 0xd5       ; 213
	clr     r27
	ldi     r28, 0xde       ; 222
	clr     r29
	ld      r16, Y+
	andi    r16, 0x0f       ; 15
	dec     r16
	sts     0x00d4, r16
	ld      r17, Y+
	lsl     r17
	sts     0x00d3, r17


Label301:
	ld      r17, Y+
	st      X+, r17
	dec     r16
	brne    Label301
	rcall   Function6
	lds     r16, 0x0067
	ori     r16, 0x04       ; 4
	sts     0x0067, r16
	ori     r23, 0x80       ; 128
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16
	ret



RX_Handler_MSG_VERSION:
	lds     r16, 0x00f4
	ori     r16, 0x04       ; 4
	sts     0x00f4, r16
	lds     r16, 0x00ff
	andi    r16, 0x7f       ; 127
	sts     0x00ff, r16
	ori     r23, 0x10       ; 16
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16
	andi    r22, 0xfe       ; 254
	andi    r22, 0xf7       ; 247
	ret



RX_Handler_MSG_NOTIFY_LED:

;; configure default-ack routine to send notify-led ack ...
	lds     r16, 0x0067
	ori     r16, 0x02       ; 2
	sts     0x0067, r16

;; request default ack
	ori     r23, 0x80       ; 128

;; clear rx buf busy bit
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16

	ret


RX_Handler_MSG_BATTERY:
	ori     r23, 0x40       ; 64
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16
	ret



RX_Handler_MSG_BACKLIGHT:
	lds     r28, 0x00ef
	clr     r29
	ld      r16, Y+
	cpi     r16, 0x03       ; 3
	brne    Label304
	ori     r23, 0x20       ; 32
	rjmp    Label309


Label304:
	lds     r17, 0x008e
	cpi     r16, 0x01       ; 1
	brne    Label305
	sbrc    r17, 1          ; 0x02 = 2
	rjmp    Label306
	ldi     r16, 0xfa       ; 250
	sts     0x00f2, r16
	clr     r16
	sts     0x008f, r16
	andi    r17, 0xfb       ; 251
	ori     r17, 0x02       ; 2
	rjmp    Label306


Label305:
	andi    r17, 0xfd       ; 253



Label306:
	ld      r16, Y+
	cpi     r16, 0x00       ; 0
	brne    Label307
	andi    r17, 0xfe       ; 254
	sts     0x008e, r17
	cbi     PORTC, 7        ; 0x80 = 128
	clr     r16
	out     TCCR1B, r16
	rjmp    Label308


Label307:
	ld      r18, Y+
	out     OCR1BL, r18
	sts     0x008e, r17
	sbrc    r17, 0          ; 0x01 = 1
	rjmp    Label308
	ldi     r16, 0x21       ; 33
	out     TCCR1A, r16
	ldi     r16, 0x01       ; 1
	out     TCCR1B, r16
	sbi     PORTC, 7        ; 0x80 = 128
	ori     r17, 0x01       ; 1
	sts     0x008e, r17



Label308:
	lds     r16, 0x0067
	ori     r16, 0x01       ; 1
	sts     0x0067, r16
	ori     r23, 0x80       ; 128


Label309:
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16
	ret




Function13:
	cli
	lds     r16, 0x007c
	lds     r17, 0x007b
	sei
	ldi     r18, 0xee       ; 238
	sub     r16, r18
	brcc    Label310
	ldi     r18, 0x02       ; 2
	inc     r18
	rjmp    Label311


Label310:
	ldi     r18, 0x02       ; 2


Label311:
	sub     r17, r18
	brcc    Label312
	sbi     PORTA, 0        ; 0x01 = 1
	ret



Label312:
	cbi     PORTA, 0        ; 0x01 = 1
	ret



RX_Handler_MSG_SPI_READ:
	lds     r16, 0x00f4
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    RX_SpiRead_Out
	lds     r16, 0x00f5
	sbrc    r16, 0          ; 0x01 = 1
	rjmp    RX_SpiRead_Out
	lds     r28, 0x00ef
	clr     r29
	ld      r16, Y+
	cpi     r16, 0xff       ; 255
	brne    Label313
	ld      r17, Y+
	dec     r28
	cpi     r17, 0xff       ; 255
	brne    Label313
	clr     r16
	rjmp    Label314



Label313:
	sts     0x00f9, r16
	ld      r16, Y+
	sts     0x00fa, r16
	ld      r16, Y+


Label314:
	sts     0x00fb, r16
	lds     r16, 0x00f4
	ori     r16, 0x01       ; 1
	sts     0x00f4, r16
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16



RX_SpiRead_Out:
	ret



RX_Handler_MSG_SPI_WRITE:
	lds     r16, 0x00f4
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    RX_SpiWrite_Out
	lds     r16, 0x00f5
	sbrc    r16, 1          ; 0x02 = 2
	rjmp    RX_SpiWrite_Out
	ldi     r26, 0x13       ; 19
	ldi     r27, 0x01       ; 1
	ldi     r28, 0xde       ; 222
	clr     r29
	ld      r16, Y+
	andi    r16, 0x0f       ; 15
	subi    r16, 0x02       ; 2
	st      X+, r16
	ld      r17, Y+
	cpi     r17, 0xff       ; 255
	brne    Label316
	ld      r18, Y+
	dec     r28
	cpi     r18, 0xff       ; 255
	brne    Label316
	dec     r26
	clr     r16
	st      X+, r16
	inc     r16
	inc     r28
	rjmp    Label317



Label316:
	st      X+, r17
	ld      r17, Y+
	st      X+, r17



Label317:
	ld      r17, Y+
	st      X+, r17
	dec     r16
	brne    Label317
	lds     r16, 0x00f4
	ori     r16, 0x02       ; 2
	sts     0x00f4, r16
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16



RX_SpiWrite_Out:
	ret



RX_Handler_MSG_THERMAL_SENSOR:
	lds     r16, 0x0075
	sbrs    r16, 0          ; 0x01 = 1
	rjmp    Label319
	ori     r22, 0x04       ; 4
	rjmp    Label320


Label319:
	lds     r16, 0x00bb
	ori     r16, 0x01       ; 1
	sts     0x00bb, r16
	ori     r25, 0x40       ; 64


Label320:
	lds     r16, 0x0065
	andi    r16, 0xbf       ; 191
	sts     0x0065, r16
	ret


RX_Handler_MSG_RFM12:
	ldi	r28, 0xde
	clr	r29		; Y -> Recv Data Buffer
	
	ld	r16, Y+		; load command to r16
	andi	r16, 0x0f	; r16 = length of data

	cpi	r16, 2
	breq	RFM12_Packet_valid
	ret			; get out here -> discard packet

RFM12_Packet_valid:
	ld	r16, Y+		; load first byte

	cpi	r16, 0xff	; get internal status request
	breq 	RFM12_GetInternalStatus

	cpi	r16, 0x00
	breq	RFM12_GetRfm12Status

	;; normal SPI command ...
	rcall	RFM12_ConfigureSpi

	ld	r17, Y+		; load second byte
	rcall	RFM12_DoSpi
	rcall	RFM12_RestoreSpi
	
	;; fall through ...
RFM12_GetInternalStatus:
	mov	r16, r5
	ori	r16, 8
	mov	r5, r16
	ret

RFM12_GetRfm12Status:
	mov	r16, r5
	ori	r16, 4
	mov	r5, r16
	ret

RFM12_ConfigureSpi:
	;; FIXME
	ret


RFM12_RestoreSpi:
	;; FIXME
	ret


;;; send r16|r17 over SPI, return result in r16|r17 as well
RFM12_DoSpi:	
	cbi	PORTB, 4	; chip select

	;; send high byte
	out	SPDR, r16
.L1:
	sbis	SPSR, SPIF
	rjmp	.L1
	in	r16, SPDR

	;; send low byte
	out	SPDR, r17
.L2:
	sbis	SPSR, SPIF
	rjmp	.L2
	in	r17, SPDR

	sbi	PORTB, 4	; unselect chip

	ret



TX_RFM12_Status:
	;; Send SPI command 0x0000 to read status from RFM12
	rcall 	RFM12_ConfigureSpi
	
	clr	r16
	mov	r17, r16
	rcall	RFM12_DoSpi	; send 0x0000

	;; FIXME: send SOF, 0xA2, r16, r17, CRC

	rcall	RFM12_RestoreSpi
	rjmp	Label158	; back to mainloop

TX_RFM12_Internal_Status:
	;; FIXME: send SOF, 0xA2, r5, r6, CRC
	rjmp	Label158	; back to mainloop
