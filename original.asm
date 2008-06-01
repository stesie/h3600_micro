; Disassembly of ipaq-h3600-at90s8535.bin (avr-gcc style)

.equ EECR, 0x1c
.equ EEDR, 0x1d
.equ EEAR, 0x1e
.equ EEARH, 0x1f
.equ SPL, 0x3d
.equ SPH, 0x3e
.equ SREG, 0x3f
.equ ADCL, 0x4
.equ ADCH, 0x5
.equ ADCSR, 0x6
.equ ADMUX, 0x7
.equ ACSR, 0x8
.equ UBRR, 0x9
.equ UCR, 0xa
.equ USR, 0xb
.equ UDR, 0xc
.equ SPCR, 0xd
.equ SPSR, 0xe
.equ SPDR, 0xf
.equ PIND, 0x10
.equ DDRD, 0x11
.equ PORTD, 0x12
.equ PINC, 0x13
.equ DDRC, 0x14
.equ PORTC, 0x15
.equ PINB, 0x16
.equ DDRB, 0x17
.equ PORTB, 0x18
.equ DDRA, 0x1a
.equ PORTA, 0x1b
.equ WDTCR, 0x21
.equ TCNT2, 0x24
.equ TCCR2, 0x25
.equ OCR1BL, 0x28
.equ OCR1BH, 0x29
.equ OCR1AL, 0x2a
.equ OCR1AH, 0x2b
.equ TCCR1B, 0x2e
.equ TCCR1A, 0x2f
.equ TCNT0, 0x32
.equ TCCR0, 0x33
.equ MCUSR, 0x34
.equ MCUCR, 0x35
.equ TIFR, 0x38
.equ TIMSK, 0x39
.equ GIFR, 0x3a
.equ GIMSK, 0x3b
.text
main:
   0:   rjmp    __vect_Reset
   2:   rjmp    __vect_ExternalInt0
   4:   rjmp    __vect_ExternalInt1
   6:   reti
   8:   rjmp    __vect_Timer2Ovf
   a:   reti
   c:   reti
   e:   reti
  10:   reti
  12:   rjmp    __vect_Timer0Ovf
  14:   rjmp    __vect_SpiTransferComplete
  16:   rjmp    __vect_UartRxComplete
  18:   rjmp    __vect_UartDataRegEmpty
  1a:   rjmp    __vect_UartTxComplete
  1c:   rjmp    __vect_UartAdcComplete
  1e:   reti
  20:   reti

; Referenced from offset 0x02 by rjmp
__vect_ExternalInt0:
  22:   in      r0, SREG
  24:   sbic    PINB, 3         ; 0x08 = 8
  26:   rjmp    Label2
  28:   sbi     PORTD, 7        ; 0x80 = 128
  2a:   mov     r19, r9
  2c:   andi    r19, 0x07       ; 7
  2e:   brne    Label2
  30:   in      r19, GIMSK
  32:   ori     r19, 0x80       ; 128
  34:   out     GIMSK, r19
  36:   ldi     r19, 0x80       ; 128
  38:   out     GIFR, r19

; Referenced from offset 0x26 by rjmp
; Referenced from offset 0x2e by brne
Label2:
  3a:   sbis    PINB, 0         ; 0x01 = 1
  3c:   sbi     PORTC, 4        ; 0x10 = 16
  3e:   sbis    PINB, 2         ; 0x04 = 4
  40:   rjmp    KeyPress_IRQ
  42:   rjmp    Label4

; Referenced from offset 0x40 by rjmp
KeyPress_IRQ:
  44:   lds     r19, 0x0068
  48:   andi    r19, 0x12       ; 18
  4a:   brne    Label4
  4c:   clr     r19
  4e:   sts     0x0069, r19
  52:   sts     0x006c, r19
  56:   sbi     PORTD, 6        ; 0x40 = 64
  58:   ldi     r19, 0x05       ; 5
  5a:   sts     0x00fe, r19
  5e:   lds     r19, 0x0068
  62:   ori     r19, 0x10       ; 16
  64:   andi    r19, 0xfd       ; 253
  66:   sts     0x0068, r19

; Referenced from offset 0x42 by rjmp
; Referenced from offset 0x4a by brne
Label4:
  6a:   out     SREG, r0
  6c:   reti

; Referenced from offset 0x04 by rjmp
__vect_ExternalInt1:
  6e:   in      r0, SREG
  70:   in      r19, GIMSK
  72:   andi    r19, 0x7f       ; 127
  74:   out     GIMSK, r19
  76:   sbis    PINB, 3         ; 0x08 = 8
  78:   rjmp    Label6
  7a:   clr     r19
  7c:   mov     r9, r19
  7e:   sts     0x0064, r19
  82:   out     SREG, r0
  84:   reti

; Referenced from offset 0x78 by rjmp
Label6:
  86:   ori     r25, 0x02       ; 2
  88:   ldi     r19, 0x02       ; 2
  8a:   mov     r9, r19
  8c:   clr     r19
  8e:   sts     0x0064, r19
  92:   sbi     PORTC, 0        ; 0x01 = 1
  94:   out     SREG, r0
  96:   reti

; Referenced from offset 0x12 by rjmp
__vect_Timer0Ovf:
  98:   in      r0, SREG
  9a:   lds     r19, 0x007a
  9e:   dec     r19
  a0:   breq    Label8
  a2:   sts     0x007a, r19
  a6:   rjmp    Label25

; Referenced from offset 0xa0 by breq
Label8:
  a8:   ldi     r19, 0x14       ; 20
  aa:   sts     0x007a, r19
  ae:   sbrs    r22, 0          ; 0x01 = 1
  b0:   rjmp    Label9
  b2:   dec     r8
  b4:   brne    Label9
  b6:   ori     r22, 0x08       ; 8

; Referenced from offset 0xb0 by rjmp
; Referenced from offset 0xb4 by brne
Label9:
  b8:   lds     r19, 0x00ff
  bc:   andi    r19, 0x03       ; 3
  be:   breq    Label11
  c0:   sbic    PINB, 3         ; 0x08 = 8
  c2:   rjmp    Label10
  c4:   lds     r19, 0x00f4
  c8:   ori     r19, 0x08       ; 8
  ca:   sts     0x00f4, r19
  ce:   rjmp    Label11

; Referenced from offset 0xc2 by rjmp
Label10:
  d0:   clr     r19
  d2:   sts     0x00ff, r19

; Referenced from offset 0xbe by breq
; Referenced from offset 0xce by rjmp
Label11:
  d6:   lds     r19, 0x008c
  da:   sbrc    r19, 2          ; 0x04 = 4
  dc:   rjmp    Label12
  de:   sbrc    r19, 1          ; 0x02 = 2
  e0:   rjmp    Label22
  e2:   sbrc    r19, 0          ; 0x01 = 1
  e4:   rjmp    Label17
  e6:   rjmp    Label25

; Referenced from offset 0xdc by rjmp
Label12:
  e8:   lds     r19, 0x0075
  ec:   ori     r19, 0x02       ; 2
  ee:   sts     0x0075, r19
  f2:   lds     r19, 0x006d
  f6:   sbrs    r19, 0          ; 0x01 = 1
  f8:   rjmp    Label13
  fa:   sbi     PORTC, 6        ; 0x40 = 64
  fc:   rjmp    Label15

; Referenced from offset 0xf8 by rjmp
Label13:
  fe:   sbis    PINC, 6         ; 0x40 = 64
 100:   rjmp    Label14
 102:   cbi     PORTC, 6        ; 0x40 = 64
 104:   rjmp    Label15

; Referenced from offset 0x100 by rjmp
Label14:
 106:   sbi     PORTC, 6        ; 0x40 = 64

; Referenced from offset 0xfc by rjmp
; Referenced from offset 0x104 by rjmp
Label15:
 108:   lds     r19, 0x008a
 10c:   dec     r19
 10e:   breq    Label16
 110:   sts     0x008a, r19
 114:   rjmp    Label25

; Referenced from offset 0x10e by breq
Label16:
 116:   ldi     r19, 0x05       ; 5
 118:   sts     0x008a, r19
 11c:   ori     r25, 0x50       ; 80
 11e:   rjmp    Label25

; Referenced from offset 0xe4 by rjmp
Label17:
 120:   lds     r19, 0x006d
 124:   sbrs    r19, 0          ; 0x01 = 1
 126:   rjmp    Label18
 128:   sbi     PORTC, 6        ; 0x40 = 64
 12a:   rjmp    Label20

; Referenced from offset 0x126 by rjmp
Label18:
 12c:   sbis    PINC, 6         ; 0x40 = 64
 12e:   rjmp    Label19
 130:   cbi     PORTC, 6        ; 0x40 = 64
 132:   rjmp    Label20

; Referenced from offset 0x12e by rjmp
Label19:
 134:   sbi     PORTC, 6        ; 0x40 = 64

; Referenced from offset 0x12a by rjmp
; Referenced from offset 0x132 by rjmp
Label20:
 136:   lds     r19, 0x0089
 13a:   dec     r19
 13c:   breq    Label21
 13e:   sts     0x0089, r19
 142:   rjmp    Label25

; Referenced from offset 0x13c by breq
Label21:
 144:   ldi     r19, 0x0a       ; 10
 146:   sts     0x0089, r19
 14a:   ori     r25, 0x40       ; 64
 14c:   rjmp    Label25

; Referenced from offset 0xe0 by rjmp
Label22:
 14e:   lds     r19, 0x006d
 152:   sbrs    r19, 0          ; 0x01 = 1
 154:   rjmp    Label23
 156:   sbi     PORTC, 6        ; 0x40 = 64
 158:   rjmp    Label25

; Referenced from offset 0x154 by rjmp
Label23:
 15a:   sbis    PINC, 6         ; 0x40 = 64
 15c:   rjmp    Label24
 15e:   cbi     PORTC, 6        ; 0x40 = 64
 160:   rjmp    Label25

; Referenced from offset 0x15c by rjmp
Label24:
 162:   sbi     PORTC, 6        ; 0x40 = 64
 164:   rjmp    Label25

; Referenced from offset 0xa6 by rjmp
; Referenced from offset 0xe6 by rjmp
; Referenced from offset 0x114 by rjmp
; Referenced from offset 0x11e by rjmp
; Referenced from offset 0x142 by rjmp
; Referenced from offset 0x14c by rjmp
; Referenced from offset 0x158 by rjmp
; Referenced from offset 0x160 by rjmp
; Referenced from offset 0x164 by rjmp
Label25:
 166:   ldi     r19, 0x4c       ; 76
 168:   out     TCNT0, r19
 16a:   out     SREG, r0
 16c:   reti

; Referenced from offset 0x08 by rjmp
__vect_Timer2Ovf:
 16e:   in      r0, SREG
 170:   lds     r19, 0x008e
 174:   sbrs    r19, 1          ; 0x02 = 2
 176:   rjmp    Label28
 178:   lds     r19, 0x00f2
 17c:   dec     r19
 17e:   breq    Label27
 180:   sts     0x00f2, r19
 184:   rjmp    Label28

; Referenced from offset 0x17e by breq
Label27:
 186:   ldi     r19, 0xfa       ; 250
 188:   sts     0x00f2, r19
 18c:   ori     r25, 0x20       ; 32

; Referenced from offset 0x176 by rjmp
; Referenced from offset 0x184 by rjmp
Label28:
 18e:   lds     r19, 0x0080
 192:   dec     r19
 194:   breq    Label29
 196:   sts     0x0080, r19
 19a:   rjmp    Label30

; Referenced from offset 0x194 by breq
Label29:
 19c:   ldi     r19, 0x7c       ; 124
 19e:   sts     0x0080, r19
 1a2:   ori     r25, 0x08       ; 8

; Referenced from offset 0x19a by rjmp
Label30:
 1a4:   mov     r19, r9
 1a6:   sbrc    r19, 2          ; 0x04 = 4
 1a8:   rjmp    Label31
 1aa:   sbrc    r19, 4          ; 0x10 = 16
 1ac:   rjmp    Label31
 1ae:   rjmp    Label33

; Referenced from offset 0x1a8 by rjmp
; Referenced from offset 0x1ac by rjmp
Label31:
 1b0:   lds     r19, 0x0079
 1b4:   dec     r19
 1b6:   breq    Label32
 1b8:   sts     0x0079, r19
 1bc:   rjmp    Label33

; Referenced from offset 0x1b6 by breq
Label32:
 1be:   mov     r20, r9
 1c0:   lds     r19, 0x0064
 1c4:   sbrc    r20, 4          ; 0x10 = 16
 1c6:   ori     r19, 0x08       ; 8
 1c8:   sbrc    r20, 2          ; 0x04 = 4
 1ca:   ori     r19, 0x04       ; 4
 1cc:   sts     0x0064, r19

; Referenced from offset 0x1ae by rjmp
; Referenced from offset 0x1bc by rjmp
Label33:
 1d0:   lds     r19, 0x006d
 1d4:   sbrs    r19, 0          ; 0x01 = 1
 1d6:   rjmp    Label35
 1d8:   lds     r19, 0x0071
 1dc:   dec     r19
 1de:   breq    Label34
 1e0:   sts     0x0071, r19
 1e4:   rjmp    Label35

; Referenced from offset 0x1de by breq
Label34:
 1e6:   ldi     r19, 0x64       ; 100
 1e8:   sts     0x0071, r19
 1ec:   lds     r19, 0x006d
 1f0:   ori     r19, 0x02       ; 2
 1f2:   sts     0x006d, r19

; Referenced from offset 0x1d6 by rjmp
; Referenced from offset 0x1e4 by rjmp
Label35:
 1f6:   lds     r19, 0x0065
 1fa:   sbrs    r19, 7          ; 0x80 = 128
 1fc:   rjmp    Label37
 1fe:   lds     r20, 0x00fd
 202:   dec     r20
 204:   breq    Label36
 206:   sts     0x00fd, r20
 20a:   rjmp    Label37

; Referenced from offset 0x204 by breq
Label36:
 20c:   andi    r19, 0x7f       ; 127
 20e:   sts     0x0065, r19

; Referenced from offset 0x1fc by rjmp
; Referenced from offset 0x20a by rjmp
Label37:
 212:   lds     r19, 0x00fe
 216:   dec     r19
 218:   breq    Label38
 21a:   sts     0x00fe, r19
 21e:   rjmp    Label45

; Referenced from offset 0x218 by breq
Label38:
 220:   ldi     r19, 0x08       ; 8
 222:   sts     0x00fe, r19
 226:   lds     r19, 0x0068
 22a:   sbrs    r19, 1          ; 0x02 = 2
 22c:   rjmp    Label43
 22e:   rjmp    Label39

; Referenced from offset 0x22e by rjmp
Label39:
 230:   sbic    PINB, 2         ; 0x04 = 4
 232:   rjmp    Label40
 234:   rjmp    Label45

; Referenced from offset 0x232 by rjmp
Label40:
 236:   sbrs    r19, 5          ; 0x20 = 32
 238:   rjmp    Label41
 23a:   andi    r19, 0xdf       ; 223
 23c:   andi    r19, 0xfd       ; 253
 23e:   sts     0x0068, r19
 242:   cbi     PORTD, 6        ; 0x40 = 64
 244:   rjmp    Label45

; Referenced from offset 0x238 by rjmp
Label41:
 246:   sbrc    r19, 6          ; 0x40 = 64
 248:   rjmp    Label45
 24a:   sbrc    r19, 3          ; 0x08 = 8
 24c:   rjmp    Label45
 24e:   andi    r19, 0xfd       ; 253
 250:   sbic    PINB, 3         ; 0x08 = 8
 252:   rjmp    Label42
 254:   ori     r19, 0x08       ; 8
 256:   ori     r23, 0x04       ; 4

; Referenced from offset 0x252 by rjmp
Label42:
 258:   sts     0x0068, r19
 25c:   lds     r20, 0x006b
 260:   ori     r20, 0x80       ; 128
 262:   sts     0x006b, r20
 266:   cbi     PORTD, 6        ; 0x40 = 64
 268:   rjmp    Label45

; Referenced from offset 0x22c by rjmp
Label43:
 26a:   sbic    PINB, 2         ; 0x04 = 4
 26c:   rjmp    Label44
 26e:   sbrs    r19, 4          ; 0x10 = 16
 270:   rjmp    Label45
 272:   ori     r25, 0x04       ; 4
 274:   rjmp    Label45

; Referenced from offset 0x26c by rjmp
Label44:
 276:   sbrs    r19, 4          ; 0x10 = 16
 278:   rjmp    Label45
 27a:   andi    r19, 0xef       ; 239
 27c:   sts     0x0068, r19
 280:   cbi     PORTD, 6        ; 0x40 = 64

; Referenced from offset 0x21e by rjmp
; Referenced from offset 0x234 by rjmp
; Referenced from offset 0x244 by rjmp
; Referenced from offset 0x248 by rjmp
; Referenced from offset 0x24c by rjmp
; Referenced from offset 0x268 by rjmp
; Referenced from offset 0x270 by rjmp
; Referenced from offset 0x274 by rjmp
; Referenced from offset 0x278 by rjmp
Label45:
 282:   lds     r19, 0x00f5
 286:   sbrc    r19, 1          ; 0x02 = 2
 288:   rjmp    Label46
 28a:   sbrc    r19, 2          ; 0x04 = 4
 28c:   rjmp    Label46
 28e:   sbrc    r19, 3          ; 0x08 = 8
 290:   rjmp    Label46
 292:   rjmp    Label48

; Referenced from offset 0x288 by rjmp
; Referenced from offset 0x28c by rjmp
; Referenced from offset 0x290 by rjmp
Label46:
 294:   lds     r19, 0x00fc
 298:   dec     r19
 29a:   breq    Label47
 29c:   sts     0x00fc, r19
 2a0:   rjmp    Label48

; Referenced from offset 0x29a by breq
Label47:
 2a2:   lds     r19, 0x00f6
 2a6:   ori     r19, 0x80       ; 128
 2a8:   sts     0x00f6, r19

; Referenced from offset 0x292 by rjmp
; Referenced from offset 0x2a0 by rjmp
Label48:
 2ac:   ldi     r19, 0x8d       ; 141
 2ae:   out     TCNT2, r19
 2b0:   out     SREG, r0
 2b2:   reti

; Referenced from offset 0x16 by rjmp
__vect_UartRxComplete:
 2b4:   in      r0, SREG
 2b6:   in      r19, USR
 2b8:   sbrc    r19, 4          ; 0x10 = 16
 2ba:   rjmp    uart_rx_error
 2bc:   sbrc    r19, 3          ; 0x08 = 8
 2be:   rjmp    uart_rx_error
 2c0:   in      r19, UDR
 2c2:   lds     r20, 0x0065
 2c6:   sbrc    r20, 6          ; 0x40 = 64
 2c8:   rjmp    uart_rx_iret
 2ca:   sbrs    r20, 7          ; 0x80 = 128
 2cc:   rjmp    Label56
 2ce:   lds     r21, 0x00ef
 2d2:   cpi     r21, 0xde       ; 222
 2d4:   breq    Label50
 2d6:   lds     r21, 0x0066
 2da:   dec     r21
 2dc:   sts     0x0066, r21
 2e0:   rjmp    Label51

; Referenced from offset 0x2d4 by breq
Label50:
 2e2:   mov     r20, r19
 2e4:   andi    r20, 0x0f       ; 15
 2e6:   inc     r20
 2e8:   sts     0x0066, r20
 2ec:   rjmp    Label51

; Referenced from offset 0x2e0 by rjmp
; Referenced from offset 0x2ec by rjmp
Label51:
 2ee:   lds     r30, 0x00ef
 2f2:   clr     r31
 2f4:   st      Z+, r19
 2f6:   sts     0x00ef, r30
 2fa:   cpi     r21, 0x00       ; 0
 2fc:   breq    Label52
 2fe:   rjmp    uart_rx_iret

; Referenced from offset 0x2fc by breq
Label52:
 300:   ldi     r30, 0xde       ; 222
 302:   clr     r31
 304:   ld      r19, Z+
 306:   mov     r20, r19
 308:   andi    r19, 0x0f       ; 15
 30a:   breq    Label54

; Referenced from offset 0x312 by brne
Label53:
 30c:   ld      r21, Z+
 30e:   add     r20, r21
 310:   dec     r19
 312:   brne    Label53

; Referenced from offset 0x30a by breq
Label54:
 314:   ld      r21, Z+
 316:   cp      r20, r21
 318:   brne    Label55
 31a:   lds     r20, 0x0065
 31e:   andi    r20, 0x7f       ; 127
 320:   ori     r20, 0x40       ; 64
 322:   sts     0x0065, r20
 326:   rjmp    uart_rx_iret

; Referenced from offset 0x318 by brne
Label55:
 328:   lds     r20, 0x0065
 32c:   andi    r20, 0x7f       ; 127
 32e:   sts     0x0065, r20
 332:   rjmp    uart_rx_iret

; Referenced from offset 0x2cc by rjmp
Label56:
 334:   cpi     r19, 0x02       ; 2
 336:   breq    Label57
 338:   rjmp    uart_rx_iret

; Referenced from offset 0x336 by breq
Label57:
 33a:   ldi     r21, 0x0a       ; 10
 33c:   sts     0x00fd, r21
 340:   ori     r20, 0x80       ; 128
 342:   sts     0x0065, r20
 346:   ldi     r20, 0xde       ; 222
 348:   sts     0x00ef, r20
 34c:   rjmp    uart_rx_iret

; Referenced from offset 0x2ba by rjmp
; Referenced from offset 0x2be by rjmp
uart_rx_error:
 34e:   in      r19, UDR
 350:   lds     r19, 0x0065
 354:   andi    r19, 0x7f       ; 127
 356:   sts     0x0065, r19
 35a:   rjmp    uart_rx_iret

; Referenced from offset 0x2c8 by rjmp
; Referenced from offset 0x2fe by rjmp
; Referenced from offset 0x326 by rjmp
; Referenced from offset 0x332 by rjmp
; Referenced from offset 0x338 by rjmp
; Referenced from offset 0x34c by rjmp
; Referenced from offset 0x35a by rjmp
uart_rx_iret:
 35c:   out     SREG, r0
 35e:   reti

; Referenced from offset 0x18 by rjmp
__vect_UartDataRegEmpty:
 360:   in      r0, SREG
 362:   lds     r19, 0x00d1
 366:   lds     r20, 0x00d2
 36a:   cp      r19, r20
 36c:   brcs    Label62

; Referenced from offset 0x37c by rjmp
Label61:
 36e:   andi    r23, 0xfe       ; 254
 370:   in      r19, UCR
 372:   andi    r19, 0x9f       ; 159
 374:   out     UCR, r19
 376:   out     SREG, r0
 378:   reti

; Referenced from offset 0x36c by brcs
Label62:
 37a:   sbic    PINB, 3         ; 0x08 = 8
 37c:   rjmp    Label61
 37e:   lds     r30, 0x00d1
 382:   clr     r31
 384:   ld      r19, Z+
 386:   out     UDR, r19
 388:   sts     0x00d1, r30
 38c:   out     SREG, r0
 38e:   reti

; Referenced from offset 0x1a by rjmp
__vect_UartTxComplete:
 390:   in      r0, SREG
 392:   in      r19, UCR
 394:   andi    r19, 0xbf       ; 191
 396:   out     UCR, r19
 398:   out     SREG, r0
 39a:   reti

; Referenced from offset 0x1c by rjmp
__vect_UartAdcComplete:
 39c:   in      r0, SREG
 39e:   in      r20, ADCL
 3a0:   in      r21, ADCH
 3a2:   andi    r21, 0x03       ; 3
 3a4:   andi    r24, 0x7f       ; 127
 3a6:   sbrc    r24, 6          ; 0x40 = 64
 3a8:   rjmp    Label109
 3aa:   sbrc    r24, 5          ; 0x20 = 32
 3ac:   rjmp    Label102
 3ae:   sbrc    r24, 4          ; 0x10 = 16
 3b0:   rjmp    Label98
 3b2:   sbrc    r24, 3          ; 0x08 = 8
 3b4:   rjmp    Label89
 3b6:   sbrc    r24, 2          ; 0x04 = 4
 3b8:   rjmp    Label71
 3ba:   sbrc    r24, 1          ; 0x02 = 2
 3bc:   rjmp    Label65
 3be:   sbrc    r24, 0          ; 0x01 = 1
 3c0:   rjmp    Label68
 3c2:   out     SREG, r0
 3c4:   reti

; Referenced from offset 0x3bc by rjmp
Label65:
 3c6:   mov     r19, r9
 3c8:   sbrs    r19, 1          ; 0x02 = 2
 3ca:   rjmp    Label66
 3cc:   mov     r10, r21
 3ce:   mov     r11, r20
 3d0:   rjmp    Label67

; Referenced from offset 0x3ca by rjmp
Label66:
 3d2:   cbi     PORTC, 0        ; 0x01 = 1
 3d4:   sbi     PORTC, 1        ; 0x02 = 2
 3d6:   sbi     PORTC, 2        ; 0x04 = 4
 3d8:   cbi     PORTC, 3        ; 0x08 = 8
 3da:   sts     0x0062, r21
 3de:   sts     0x0063, r20

; Referenced from offset 0x3d0 by rjmp
Label67:
 3e2:   andi    r24, 0xfd       ; 253
 3e4:   ori     r25, 0x01       ; 1
 3e6:   out     SREG, r0
 3e8:   reti

; Referenced from offset 0x3c0 by rjmp
Label68:
 3ea:   mov     r19, r9
 3ec:   sbrs    r19, 1          ; 0x02 = 2
 3ee:   rjmp    Label69
 3f0:   cbi     PORTC, 0        ; 0x01 = 1
 3f2:   sbi     PORTC, 2        ; 0x04 = 4
 3f4:   sbi     PORTC, 1        ; 0x02 = 2
 3f6:   sbi     PORTC, 3        ; 0x08 = 8
 3f8:   mov     r12, r21
 3fa:   mov     r13, r20
 3fc:   ori     r19, 0x10       ; 16
 3fe:   mov     r9, r19
 400:   ldi     r19, 0x02       ; 2
 402:   sts     0x0079, r19
 406:   lds     r19, 0x0064
 40a:   ori     r19, 0x02       ; 2
 40c:   sts     0x0064, r19
 410:   rjmp    Label70

; Referenced from offset 0x3ee by rjmp
Label69:
 412:   sbi     PORTC, 2        ; 0x04 = 4
 414:   cbi     PORTC, 3        ; 0x08 = 8
 416:   sbi     PORTC, 1        ; 0x02 = 2
 418:   cbi     PORTC, 0        ; 0x01 = 1
 41a:   sts     0x0060, r21
 41e:   sts     0x0061, r20
 422:   lds     r19, 0x0064
 426:   ori     r19, 0x01       ; 1
 428:   sts     0x0064, r19

; Referenced from offset 0x410 by rjmp
Label70:
 42c:   andi    r24, 0xfe       ; 254
 42e:   out     SREG, r0
 430:   reti

; Referenced from offset 0x3b8 by rjmp
Label71:
 432:   andi    r24, 0xfb       ; 251
 434:   lsr     r20
 436:   lsr     r20
 438:   andi    r20, 0x3f       ; 63
 43a:   sbrc    r21, 0          ; 0x01 = 1
 43c:   ori     r20, 0x40       ; 64
 43e:   sbrc    r21, 1          ; 0x02 = 2
 440:   ori     r20, 0x80       ; 128
 442:   cpi     r20, 0xe8       ; 232
 444:   brcs    Label72
 446:   clr     r19
 448:   rjmp    Label82

; Referenced from offset 0x444 by brcs
Label72:
 44a:   cpi     r20, 0xd0       ; 208
 44c:   brcs    Label73
 44e:   ldi     r19, 0x09       ; 9
 450:   rjmp    Label82

; Referenced from offset 0x44c by brcs
Label73:
 452:   cpi     r20, 0xb8       ; 184
 454:   brcs    Label74
 456:   ldi     r19, 0x08       ; 8
 458:   rjmp    Label82

; Referenced from offset 0x454 by brcs
Label74:
 45a:   cpi     r20, 0xa0       ; 160
 45c:   brcs    Label75
 45e:   ldi     r19, 0x07       ; 7
 460:   rjmp    Label82

; Referenced from offset 0x45c by brcs
Label75:
 462:   cpi     r20, 0x88       ; 136
 464:   brcs    Label76
 466:   ldi     r19, 0x06       ; 6
 468:   rjmp    Label82

; Referenced from offset 0x464 by brcs
Label76:
 46a:   cpi     r20, 0x70       ; 112
 46c:   brcs    Label77
 46e:   ldi     r19, 0x05       ; 5
 470:   rjmp    Label82

; Referenced from offset 0x46c by brcs
Label77:
 472:   cpi     r20, 0x58       ; 88
 474:   brcs    Label78
 476:   ldi     r19, 0x04       ; 4
 478:   rjmp    Label82

; Referenced from offset 0x474 by brcs
Label78:
 47a:   cpi     r20, 0x40       ; 64
 47c:   brcs    Label79
 47e:   ldi     r19, 0x03       ; 3
 480:   rjmp    Label82

; Referenced from offset 0x47c by brcs
Label79:
 482:   cpi     r20, 0x26       ; 38
 484:   brcs    Label80
 486:   ldi     r19, 0x02       ; 2
 488:   rjmp    Label82

; Referenced from offset 0x484 by brcs
Label80:
 48a:   cpi     r20, 0x0c       ; 12
 48c:   brcs    Label81
 48e:   ldi     r19, 0x0a       ; 10
 490:   rjmp    Label82

; Referenced from offset 0x48c by brcs
Label81:
 492:   ldi     r19, 0x01       ; 1

; Referenced from offset 0x448 by rjmp
; Referenced from offset 0x450 by rjmp
; Referenced from offset 0x458 by rjmp
; Referenced from offset 0x460 by rjmp
; Referenced from offset 0x468 by rjmp
; Referenced from offset 0x470 by rjmp
; Referenced from offset 0x478 by rjmp
; Referenced from offset 0x480 by rjmp
; Referenced from offset 0x488 by rjmp
; Referenced from offset 0x490 by rjmp
Label82:
 494:   cpi     r19, 0x00       ; 0
 496:   breq    Label83
 498:   lds     r20, 0x0069
 49c:   cp      r20, r19
 49e:   breq    Label84
 4a0:   ldi     r20, 0x01       ; 1
 4a2:   sts     0x006c, r20
 4a6:   sts     0x0069, r19
 4aa:   out     SREG, r0
 4ac:   reti

; Referenced from offset 0x496 by breq
Label83:
 4ae:   sts     0x006c, r19
 4b2:   sts     0x0069, r19
 4b6:   out     SREG, r0
 4b8:   reti

; Referenced from offset 0x49e by breq
Label84:
 4ba:   lds     r20, 0x006c
 4be:   inc     r20
 4c0:   sts     0x006c, r20
 4c4:   cpi     r20, 0x03       ; 3
 4c6:   brcc    Label85
 4c8:   out     SREG, r0
 4ca:   reti

; Referenced from offset 0x4c6 by brcc
Label85:
 4cc:   sbic    PINB, 3         ; 0x08 = 8
 4ce:   rjmp    Label87

; Referenced from offset 0x50e by rjmp
Label86:
 4d0:   lds     r20, 0x0068
 4d4:   ori     r20, 0x02       ; 2
 4d6:   ori     r20, 0x08       ; 8
 4d8:   andi    r20, 0xef       ; 239
 4da:   sts     0x0068, r20
 4de:   sts     0x006b, r19
 4e2:   ori     r23, 0x04       ; 4
 4e4:   out     SREG, r0
 4e6:   reti

; Referenced from offset 0x4ce by rjmp
Label87:
 4e8:   cpi     r19, 0x06       ; 6
 4ea:   brcs    Label88
 4ec:   cpi     r19, 0x0a       ; 10
 4ee:   breq    Label88
 4f0:   lds     r20, 0x0068
 4f4:   ori     r20, 0x02       ; 2
 4f6:   ori     r20, 0x20       ; 32
 4f8:   andi    r20, 0xf7       ; 247
 4fa:   andi    r20, 0xef       ; 239
 4fc:   sts     0x0068, r20
 500:   out     SREG, r0
 502:   reti

; Referenced from offset 0x4ea by brcs
; Referenced from offset 0x4ee by breq
Label88:
 504:   lds     r20, 0x0068
 508:   ori     r20, 0x40       ; 64
 50a:   sts     0x0068, r20
 50e:   rjmp    Label86

; Referenced from offset 0x3b4 by rjmp
Label89:
 510:   andi    r24, 0xf7       ; 247
 512:   lds     r19, 0x007f
 516:   cpi     r19, 0x00       ; 0
 518:   brne    Label90
 51a:   inc     r19
 51c:   sts     0x007f, r19
 520:   sts     0x007e, r20
 524:   sts     0x007d, r21
 528:   sts     0x0082, r20
 52c:   sts     0x0081, r21
 530:   out     SREG, r0
 532:   reti

; Referenced from offset 0x518 by brne
Label90:
 534:   mov     r1, r20
 536:   mov     r2, r21
 538:   lds     r19, 0x0082
 53c:   sub     r20, r19
 53e:   brcc    Label91
 540:   lds     r19, 0x0081
 544:   inc     r19
 546:   rjmp    Label92

; Referenced from offset 0x53e by brcc
Label91:
 548:   lds     r19, 0x0081

; Referenced from offset 0x546 by rjmp
Label92:
 54c:   sub     r21, r19
 54e:   brcc    Label93
 550:   com     r21
 552:   com     r20
 554:   inc     r20

; Referenced from offset 0x54e by brcc
Label93:
 556:   cpi     r21, 0x00       ; 0
 558:   breq    Label95

; Referenced from offset 0x568 by rjmp
Label94:
 55a:   clr     r19
 55c:   sts     0x007f, r19
 560:   out     SREG, r0
 562:   reti

; Referenced from offset 0x558 by breq
Label95:
 564:   cpi     r20, 0x09       ; 9
 566:   brcs    Label96
 568:   rjmp    Label94

; Referenced from offset 0x566 by brcs
Label96:
 56a:   mov     r20, r1
 56c:   mov     r21, r2
 56e:   lds     r19, 0x007e
 572:   add     r20, r19
 574:   lds     r19, 0x007d
 578:   adc     r21, r19
 57a:   lds     r19, 0x007f
 57e:   inc     r19
 580:   cpi     r19, 0x08       ; 8
 582:   breq    Label97
 584:   sts     0x007f, r19
 588:   sts     0x007e, r20
 58c:   sts     0x007d, r21
 590:   sts     0x0082, r1
 594:   sts     0x0081, r2
 598:   out     SREG, r0
 59a:   reti

; Referenced from offset 0x582 by breq
Label97:
 59c:   lsr     r20
 59e:   lsr     r20
 5a0:   lsr     r20
 5a2:   andi    r20, 0x1f       ; 31
 5a4:   sbrc    r21, 0          ; 0x01 = 1
 5a6:   ori     r20, 0x20       ; 32
 5a8:   sbrc    r21, 1          ; 0x02 = 2
 5aa:   ori     r20, 0x40       ; 64
 5ac:   sbrc    r21, 2          ; 0x04 = 4
 5ae:   ori     r20, 0x80       ; 128
 5b0:   lsr     r21
 5b2:   lsr     r21
 5b4:   lsr     r21
 5b6:   andi    r21, 0x1f       ; 31
 5b8:   clr     r19
 5ba:   sts     0x007f, r19
 5be:   sts     0x007c, r20
 5c2:   sts     0x007b, r21
 5c6:   out     SREG, r0
 5c8:   reti

; Referenced from offset 0x3b0 by rjmp
Label98:
 5ca:   andi    r24, 0xef       ; 239
 5cc:   sts     0x0083, r20
 5d0:   sts     0x0084, r21
 5d4:   ldi     r19, 0x99       ; 153
 5d6:   sub     r20, r19
 5d8:   brcc    Label99
 5da:   ldi     r19, 0x01       ; 1
 5dc:   inc     r19
 5de:   rjmp    Label100

; Referenced from offset 0x5d8 by brcc
Label99:
 5e0:   ldi     r19, 0x01       ; 1

; Referenced from offset 0x5de by rjmp
Label100:
 5e2:   sub     r21, r19
 5e4:   brcc    Label101
 5e6:   lds     r19, 0x008d
 5ea:   inc     r19
 5ec:   sts     0x008d, r19
 5f0:   out     SREG, r0
 5f2:   reti

; Referenced from offset 0x5e4 by brcc
Label101:
 5f4:   clr     r19
 5f6:   sts     0x008d, r19
 5fa:   out     SREG, r0
 5fc:   reti

; Referenced from offset 0x3ac by rjmp
Label102:
 5fe:   andi    r24, 0xdf       ; 223
 600:   lsr     r20
 602:   lsr     r20
 604:   andi    r20, 0x3f       ; 63
 606:   sbrc    r21, 0          ; 0x01 = 1
 608:   ori     r20, 0x40       ; 64
 60a:   sbrc    r21, 1          ; 0x02 = 2
 60c:   ori     r20, 0x80       ; 128
 60e:   lds     r19, 0x008e
 612:   sbrc    r19, 2          ; 0x04 = 4
 614:   rjmp    Label103
 616:   sts     0x00f1, r20
 61a:   ori     r19, 0x04       ; 4
 61c:   sts     0x008e, r19
 620:   out     SREG, r0
 622:   reti

; Referenced from offset 0x614 by rjmp
Label103:
 624:   lds     r21, 0x00f1
 628:   sub     r21, r20
 62a:   brcc    Label104
 62c:   com     r21
 62e:   inc     r21

; Referenced from offset 0x62a by brcc
Label104:
 630:   cpi     r21, 0x09       ; 9
 632:   brcs    Label105
 634:   rjmp    Label108

; Referenced from offset 0x632 by brcs
Label105:
 636:   lds     r21, 0x00f1
 63a:   add     r20, r21
 63c:   brcc    Label106
 63e:   lsr     r20
 640:   ori     r20, 0x80       ; 128
 642:   rjmp    Label107

; Referenced from offset 0x63c by brcc
Label106:
 644:   lsr     r20

; Referenced from offset 0x642 by rjmp
Label107:
 646:   sts     0x008f, r20

; Referenced from offset 0x634 by rjmp
Label108:
 64a:   lds     r19, 0x008e
 64e:   andi    r19, 0xfb       ; 251
 650:   sts     0x008e, r19
 654:   out     SREG, r0
 656:   reti

; Referenced from offset 0x3a8 by rjmp
Label109:
 658:   andi    r24, 0xbf       ; 191
 65a:   sts     0x0087, r20
 65e:   sts     0x0088, r21
 662:   lds     r19, 0x00bb
 666:   sbrc    r19, 0          ; 0x01 = 1
 668:   rjmp    Label110
 66a:   out     SREG, r0
 66c:   reti

; Referenced from offset 0x668 by rjmp
Label110:
 66e:   andi    r19, 0xfe       ; 254
 670:   sts     0x00bb, r19
 674:   ori     r22, 0x04       ; 4
 676:   out     SREG, r0
 678:   reti

; Referenced from offset 0x14 by rjmp
__vect_SpiTransferComplete:
 67a:   in      r0, SREG
 67c:   lds     r19, 0x00f3
 680:   sbrs    r19, 0          ; 0x01 = 1
 682:   rjmp    Label113
 684:   lds     r20, 0x00a1
 688:   lds     r21, 0x00a2
 68c:   cp      r20, r21
 68e:   brne    Label112
 690:   ori     r19, 0x04       ; 4
 692:   sts     0x00f3, r19
 696:   rjmp    Label116

; Referenced from offset 0x68e by brne
Label112:
 698:   lds     r30, 0x00a1
 69c:   clr     r31
 69e:   ld      r19, Z+
 6a0:   sts     0x00a1, r30
 6a4:   out     SPDR, r19
 6a6:   rjmp    Label116

; Referenced from offset 0x682 by rjmp
Label113:
 6a8:   lds     r30, 0x00a3
 6ac:   clr     r31
 6ae:   in      r21, SPDR
 6b0:   st      Z+, r21
 6b2:   sts     0x00a3, r30
 6b6:   sts     0x00a4, r30
 6ba:   lds     r20, 0x00f7
 6be:   dec     r20
 6c0:   breq    Label115
 6c2:   sts     0x00f7, r20
 6c6:   lds     r20, 0x00f5
 6ca:   sbrc    r20, 3          ; 0x08 = 8
 6cc:   rjmp    Label114
 6ce:   sbrc    r20, 2          ; 0x04 = 4
 6d0:   rjmp    Label114
 6d2:   clr     r20
 6d4:   out     SPDR, r20
 6d6:   rjmp    Label116

; Referenced from offset 0x6cc by rjmp
; Referenced from offset 0x6d0 by rjmp
Label114:
 6d8:   ori     r19, 0x0c       ; 12
 6da:   sts     0x00f3, r19
 6de:   rjmp    Label116

; Referenced from offset 0x6c0 by breq
Label115:
 6e0:   ori     r19, 0x04       ; 4
 6e2:   sts     0x00f3, r19

; Referenced from offset 0x696 by rjmp
; Referenced from offset 0x6a6 by rjmp
; Referenced from offset 0x6d6 by rjmp
; Referenced from offset 0x6de by rjmp
Label116:
 6e6:   out     SREG, r0
 6e8:   reti

; Referenced from offset 0x00 by rjmp
__vect_Reset:
 6ea:   cli
 6ec:   ldi     r16, 0x01       ; 1
 6ee:   out     SPH, r16
 6f0:   ldi     r16, 0x5f       ; 95
 6f2:   out     SPL, r16
 6f4:   in      r16, MCUSR
 6f6:   sbrs    r16, 0          ; 0x01 = 1
 6f8:   rjmp    _on_other_reset
 6fa:   rjmp    _on_power_on_reset

; Referenced from offset 0x6f8 by rjmp
_on_other_reset:
 6fc:   sbrs    r16, 1          ; 0x02 = 2
 6fe:   rjmp    Label120
 700:   ldi     r17, 0x02       ; 2
 702:   sts     0x00bf, r17
 706:   rjmp    Label121

; Referenced from offset 0x6fa by rjmp
_on_power_on_reset:
 708:   ldi     r17, 0x01       ; 1
 70a:   sts     0x00bf, r17
 70e:   rjmp    Label121

; Referenced from offset 0x6fe by rjmp
Label120:
 710:   ldi     r17, 0x03       ; 3
 712:   sts     0x00bf, r17
 716:   rjmp    Label121

; Referenced from offset 0x706 by rjmp
; Referenced from offset 0x70e by rjmp
; Referenced from offset 0x716 by rjmp
Label121:
 718:   clr     r16
 71a:   out     MCUSR, r16
 71c:   clr     r16
 71e:   ldi     r17, 0x01       ; 1
 720:   out     DDRA, r17
 722:   ldi     r17, 0x00       ; 0
 724:   out     PORTA, r17
 726:   ldi     r17, 0xb2       ; 178
 728:   out     DDRB, r17
 72a:   ldi     r17, 0x1d       ; 29
 72c:   out     PORTB, r17
 72e:   ser     r17
 730:   out     DDRC, r17
 732:   ldi     r17, 0x6e       ; 110
 734:   out     PORTC, r17
 736:   ldi     r17, 0xf2       ; 242
 738:   out     DDRD, r17
 73a:   ldi     r17, 0x25       ; 37
 73c:   out     PORTD, r17
 73e:   ldi     r17, 0x18       ; 24
 740:   out     WDTCR, r17
 742:   andi    r17, 0xfc       ; 252
 744:   out     WDTCR, r17
 746:   out     WDTCR, r16
 748:   out     GIMSK, r16
 74a:   out     TIMSK, r16
 74c:   out     MCUCR, r16
 74e:   out     OCR1AH, r16
 750:   out     OCR1AL, r16
 752:   out     OCR1BH, r16
 754:   out     OCR1BL, r16
 756:   out     SPSR, r16
 758:   ldi     r17, 0xd6       ; 214
 75a:   out     SPCR, r17
 75c:   out     EECR, r16
 75e:   ldi     r17, 0x98       ; 152
 760:   out     UCR, r17
 762:   ldi     r17, 0x01       ; 1
 764:   out     UBRR, r17
 766:   ldi     r17, 0x80       ; 128
 768:   out     ACSR, r17
 76a:   ldi     r17, 0x9d       ; 157
 76c:   out     ADCSR, r17
 76e:   ldi     r17, 0x03       ; 3
 770:   out     TCCR2, r17
 772:   ldi     r17, 0x8d       ; 141
 774:   out     TCNT2, r17
 776:   ldi     r17, 0x05       ; 5
 778:   out     TCCR0, r17
 77a:   ldi     r17, 0x4c       ; 76
 77c:   out     TCNT0, r17
 77e:   ldi     r17, 0x14       ; 20
 780:   sts     0x007a, r17
 784:   ldi     r17, 0x7c       ; 124
 786:   sts     0x0080, r17
 78a:   ldi     r23, 0x00       ; 0
 78c:   ldi     r24, 0x00       ; 0
 78e:   ldi     r25, 0x00       ; 0
 790:   ldi     r22, 0x00       ; 0
 792:   sts     0x006c, r16
 796:   sts     0x0068, r16
 79a:   sts     0x0065, r16
 79e:   sts     0x0067, r16
 7a2:   sts     0x006d, r16
 7a6:   mov     r9, r16
 7a8:   sts     0x0064, r16
 7ac:   sts     0x0075, r16
 7b0:   sts     0x008c, r16
 7b4:   sts     0x008e, r16
 7b8:   sts     0x007b, r16
 7bc:   sts     0x007c, r16
 7c0:   sts     0x007d, r16
 7c4:   sts     0x007e, r16
 7c8:   sts     0x0081, r16
 7cc:   sts     0x0082, r16
 7d0:   sts     0x007f, r16
 7d4:   sts     0x00f3, r16
 7d8:   sts     0x00f4, r16
 7dc:   sts     0x00f6, r16
 7e0:   sts     0x00ff, r16
 7e4:   sts     0x00f5, r16
 7e8:   sts     0x00b6, r16
 7ec:   sts     0x00b7, r16
 7f0:   sts     0x00b8, r16
 7f4:   clr     r7
 7f6:   sts     0x00bc, r16
 7fa:   sts     0x00bd, r16
 7fe:   sts     0x00be, r16
 802:   sts     0x00bb, r16
 806:   ldi     r16, 0xc0       ; 192
 808:   out     GIFR, r16
 80a:   ldi     r16, 0xc0       ; 192
 80c:   out     GIMSK, r16
 80e:   ldi     r16, 0xfd       ; 253
 810:   out     TIFR, r16
 812:   ldi     r16, 0x41       ; 65
 814:   out     TIMSK, r16
 816:   sei

; Referenced from offset 0x15ae by rjmp
; Referenced from offset 0x15b2 by rjmp
; Referenced from offset 0x1602 by rjmp
MainLoop_Start:
main_cpu_irq_handler_start:
 818:   sbrc    r23, 0          ; 0x01 = 1
 81a:   rjmp    Label158
 81c:   mov     r16, r23
 81e:   andi    r16, 0xfe       ; 254
 820:   brne    Label123
 822:   mov     r16, r22
 824:   andi    r16, 0x86       ; 134
 826:   brne    Label123
 828:   rjmp    Label158

; Referenced from offset 0x820 by brne
; Referenced from offset 0x826 by brne
Label123:
 82a:   sbis    PINB, 3         ; 0x08 = 8
 82c:   rjmp    Label124
 82e:   sbrc    r22, 0          ; 0x01 = 1
 830:   rjmp    Label125
 832:   andi    r22, 0xf7       ; 247
 834:   ldi     r16, 0x03       ; 3
 836:   mov     r8, r16
 838:   cbi     PORTC, 5        ; 0x20 = 32
 83a:   ori     r22, 0x01       ; 1
 83c:   sbi     PORTC, 5        ; 0x20 = 32
 83e:   rjmp    Label158

; Referenced from offset 0x82c by rjmp
Label124:
 840:   sbrs    r22, 0          ; 0x01 = 1
 842:   rjmp    Label128

; Referenced from offset 0x830 by rjmp
Label125:
 844:   sbrs    r22, 3          ; 0x08 = 8
 846:   rjmp    Label158
 848:   sbrs    r23, 2          ; 0x04 = 4
 84a:   rjmp    Label127
 84c:   lds     r16, 0x0068
 850:   sbrc    r16, 6          ; 0x40 = 64
 852:   rjmp    Label126
 854:   andi    r16, 0xf7       ; 247
 856:   sts     0x0068, r16
 85a:   rjmp    Label127

; Referenced from offset 0x852 by rjmp
Label126:
 85c:   andi    r16, 0xb7       ; 183
 85e:   ori     r16, 0x20       ; 32
 860:   sts     0x0068, r16

; Referenced from offset 0x84a by rjmp
; Referenced from offset 0x85a by rjmp
Label127:
 864:   clr     r22
 866:   clr     r23
 868:   rjmp    Label158

; Referenced from offset 0x842 by rjmp
Label128:
 86a:   sbrs    r23, 4          ; 0x10 = 16
 86c:   rjmp    Label130
 86e:   sbic    PINB, 3         ; 0x08 = 8
 870:   rjmp    Label129
 872:   lds     r16, 0x00ff
 876:   sbrs    r16, 7          ; 0x80 = 128
 878:   rjmp    Label158
 87a:   andi    r16, 0x7f       ; 127
 87c:   sts     0x00ff, r16
 880:   ori     r23, 0x01       ; 1
 882:   andi    r23, 0xef       ; 239
 884:   clr     r29
 886:   ldi     r28, 0xc0       ; 192
 888:   sts     0x00d1, r28
 88c:   ldi     r16, 0x02       ; 2
 88e:   st      Y+, r16
 890:   ldi     r16, 0x09       ; 9
 892:   mov     r17, r16
 894:   st      Y+, r16
 896:   ldi     r16, 0x31       ; 49
 898:   add     r17, r16
 89a:   st      Y+, r16
 89c:   ldi     r16, 0x2e       ; 46
 89e:   add     r17, r16
 8a0:   st      Y+, r16
 8a2:   ldi     r16, 0x30       ; 48
 8a4:   add     r17, r16
 8a6:   st      Y+, r16
 8a8:   ldi     r16, 0x37       ; 55
 8aa:   add     r17, r16
 8ac:   st      Y+, r16
 8ae:   lds     r16, 0x00bc
 8b2:   add     r17, r16
 8b4:   st      Y+, r16
 8b6:   ldi     r16, 0x2e       ; 46
 8b8:   add     r17, r16
 8ba:   st      Y+, r16
 8bc:   lds     r16, 0x00bd
 8c0:   add     r17, r16
 8c2:   st      Y+, r16
 8c4:   lds     r16, 0x00be
 8c8:   add     r17, r16
 8ca:   st      Y+, r16
 8cc:   lds     r16, 0x00bf
 8d0:   add     r17, r16
 8d2:   st      Y+, r16
 8d4:   st      Y+, r17
 8d6:   clr     r16
 8d8:   sts     0x00bf, r16
 8dc:   sts     0x00d2, r28
 8e0:   cli
 8e2:   sbi     UCR, 5          ; 0x20 = 32
 8e4:   sei
 8e6:   rjmp    Label158

; Referenced from offset 0x870 by rjmp
Label129:
 8e8:   andi    r23, 0xef       ; 239

; Referenced from offset 0x86c by rjmp
Label130:
 8ea:   sbrs    r23, 1          ; 0x02 = 2
 8ec:   rjmp    Label132
 8ee:   sbic    PINB, 3         ; 0x08 = 8
 8f0:   rjmp    Label131
 8f2:   ori     r23, 0x01       ; 1
 8f4:   andi    r23, 0xfd       ; 253
 8f6:   clr     r29
 8f8:   ldi     r28, 0xc0       ; 192
 8fa:   sts     0x00d1, r28
 8fe:   rcall   Function3
 900:   sts     0x00d2, r28
 904:   cli
 906:   sbi     UCR, 5          ; 0x20 = 32
 908:   sei
 90a:   rjmp    Label158

; Referenced from offset 0x8f0 by rjmp
Label131:
 90c:   andi    r23, 0xfd       ; 253
 90e:   clr     r16
 910:   mov     r9, r16
 912:   sts     0x0064, r16

; Referenced from offset 0x8ec by rjmp
Label132:
 916:   sbrs    r23, 2          ; 0x04 = 4
 918:   rjmp    Label134
 91a:   sbic    PINB, 3         ; 0x08 = 8
 91c:   rjmp    Label133
 91e:   ori     r23, 0x01       ; 1
 920:   andi    r23, 0xfb       ; 251
 922:   clr     r29
 924:   ldi     r28, 0xc0       ; 192
 926:   sts     0x00d1, r28
 92a:   rcall   Function4
 92c:   sts     0x00d2, r28
 930:   cli
 932:   sbi     UCR, 5          ; 0x20 = 32
 934:   sei
 936:   rjmp    Label158

; Referenced from offset 0x91c by rjmp
Label133:
 938:   andi    r23, 0xfb       ; 251
 93a:   lds     r16, 0x0068
 93e:   andi    r16, 0xb7       ; 183
 940:   sts     0x0068, r16

; Referenced from offset 0x918 by rjmp
Label134:
 944:   sbrs    r23, 3          ; 0x08 = 8
 946:   rjmp    Label137
 948:   sbic    PINB, 3         ; 0x08 = 8
 94a:   rjmp    Label136
 94c:   ori     r23, 0x01       ; 1
 94e:   andi    r23, 0xf7       ; 247
 950:   clr     r29
 952:   ldi     r28, 0xc0       ; 192
 954:   sts     0x00d1, r28
 958:   ldi     r26, 0xd5       ; 213
 95a:   clr     r27
 95c:   ld      r16, X+
 95e:   ldi     r17, 0x02       ; 2
 960:   st      Y+, r17
 962:   ldi     r17, 0x40       ; 64
 964:   or      r17, r16
 966:   st      Y+, r17
 968:   mov     r18, r17

; Referenced from offset 0x972 by brne
Label135:
 96a:   ld      r17, X+
 96c:   st      Y+, r17
 96e:   add     r18, r17
 970:   dec     r16
 972:   brne    Label135
 974:   st      Y+, r18
 976:   sts     0x00d2, r28
 97a:   cli
 97c:   sbi     UCR, 5          ; 0x20 = 32
 97e:   sei
 980:   rjmp    Label158

; Referenced from offset 0x94a by rjmp
Label136:
 982:   andi    r23, 0xf7       ; 247

; Referenced from offset 0x946 by rjmp
Label137:
 984:   sbrs    r22, 7          ; 0x80 = 128
 986:   rjmp    Label139
 988:   sbic    PINB, 3         ; 0x08 = 8
 98a:   rjmp    Label138
 98c:   ori     r23, 0x01       ; 1
 98e:   andi    r22, 0x7f       ; 127
 990:   clr     r29
 992:   ldi     r28, 0xc0       ; 192
 994:   sts     0x00d1, r28
 998:   ldi     r27, 0x01       ; 1
 99a:   ldi     r26, 0x13       ; 19
 99c:   ld      r16, X+
 99e:   mov     r18, r16
 9a0:   rcall   Function2
 9a2:   ld      r16, X+
 9a4:   rcall   Function2
 9a6:   ld      r16, X+
 9a8:   rcall   Function2
 9aa:   ldi     r16, 0x0d       ; 13
 9ac:   st      Y+, r16
 9ae:   sts     0x00d2, r28
 9b2:   cli
 9b4:   sbi     UCR, 5          ; 0x20 = 32
 9b6:   sei
 9b8:   rjmp    Label158

; Referenced from offset 0x98a by rjmp
Label138:
 9ba:   andi    r22, 0x7f       ; 127

; Referenced from offset 0x986 by rjmp
Label139:
 9bc:   sbrs    r23, 6          ; 0x40 = 64
 9be:   rjmp    Label143
 9c0:   sbic    PINB, 3         ; 0x08 = 8
 9c2:   rjmp    Label142
 9c4:   ori     r23, 0x01       ; 1
 9c6:   andi    r23, 0xbf       ; 191
 9c8:   clr     r29
 9ca:   ldi     r28, 0xc0       ; 192
 9cc:   sts     0x00d1, r28
 9d0:   ldi     r16, 0x02       ; 2
 9d2:   st      Y+, r16
 9d4:   ldi     r16, 0x95       ; 149
 9d6:   lds     r18, 0x00ff
 9da:   sbrc    r18, 1          ; 0x02 = 2
 9dc:   ldi     r16, 0x99       ; 153
 9de:   sbrc    r18, 0          ; 0x01 = 1
 9e0:   ldi     r16, 0x99       ; 153
 9e2:   mov     r17, r16
 9e4:   st      Y+, r16
 9e6:   ldi     r16, 0x00       ; 0
 9e8:   sbis    PINB, 0         ; 0x01 = 1
 9ea:   ldi     r16, 0x01       ; 1
 9ec:   add     r17, r16
 9ee:   st      Y+, r16
 9f0:   ldi     r16, 0x05       ; 5
 9f2:   add     r17, r16
 9f4:   st      Y+, r16
 9f6:   cli
 9f8:   lds     r16, 0x007c
 9fc:   add     r17, r16
 9fe:   st      Y+, r16
 a00:   lds     r16, 0x007b
 a04:   add     r17, r16
 a06:   st      Y+, r16
 a08:   sei
 a0a:   ldi     r16, 0x00       ; 0
 a0c:   lds     r18, 0x008c
 a10:   sbrc    r18, 0          ; 0x01 = 1
 a12:   ldi     r16, 0x08       ; 8
 a14:   sbrc    r18, 1          ; 0x02 = 2
 a16:   ldi     r16, 0x08       ; 8
 a18:   sbrc    r18, 2          ; 0x04 = 4
 a1a:   ldi     r16, 0x08       ; 8
 a1c:   lds     r18, 0x00b8
 a20:   sbrc    r18, 4          ; 0x10 = 16
 a22:   ldi     r16, 0x08       ; 8
 a24:   lds     r18, 0x0075
 a28:   sbrc    r18, 6          ; 0x40 = 64
 a2a:   ori     r16, 0x40       ; 64
 a2c:   add     r17, r16
 a2e:   st      Y+, r16
 a30:   lds     r18, 0x00ff
 a34:   sbrc    r18, 1          ; 0x02 = 2
 a36:   rjmp    Label140
 a38:   sbrc    r18, 0          ; 0x01 = 1
 a3a:   rjmp    Label140
 a3c:   rjmp    Label141

; Referenced from offset 0xa36 by rjmp
; Referenced from offset 0xa3a by rjmp
Label140:
 a3e:   lds     r16, 0x00b6
 a42:   add     r17, r16
 a44:   st      Y+, r16
 a46:   lds     r16, 0x00b7
 a4a:   add     r17, r16
 a4c:   st      Y+, r16
 a4e:   lds     r16, 0x00b8
 a52:   andi    r16, 0xef       ; 239
 a54:   sbic    PINB, 0         ; 0x01 = 1
 a56:   andi    r16, 0xf7       ; 247
 a58:   add     r17, r16
 a5a:   st      Y+, r16
 a5c:   mov     r16, r7
 a5e:   add     r17, r16
 a60:   st      Y+, r16

; Referenced from offset 0xa3c by rjmp
Label141:
 a62:   st      Y+, r17
 a64:   sts     0x00d2, r28
 a68:   cli
 a6a:   sbi     UCR, 5          ; 0x20 = 32
 a6c:   sei
 a6e:   rjmp    Label158

; Referenced from offset 0x9c2 by rjmp
Label142:
 a70:   andi    r23, 0xbf       ; 191

; Referenced from offset 0x9be by rjmp
Label143:
 a72:   sbrs    r23, 7          ; 0x80 = 128
 a74:   rjmp    Label151
 a76:   sbic    PINB, 3         ; 0x08 = 8
 a78:   rjmp    Label150
 a7a:   ori     r23, 0x01       ; 1
 a7c:   clr     r29
 a7e:   ldi     r28, 0xc0       ; 192
 a80:   sts     0x00d1, r28
 a84:   ldi     r16, 0x02       ; 2
 a86:   st      Y+, r16
 a88:   lds     r17, 0x0067
 a8c:   sbrc    r17, 0          ; 0x01 = 1
 a8e:   rjmp    Label144
 a90:   sbrc    r17, 1          ; 0x02 = 2
 a92:   rjmp    Label145
 a94:   sbrc    r17, 2          ; 0x04 = 4
 a96:   rjmp    Label146
 a98:   sbrc    r17, 3          ; 0x08 = 8
 a9a:   rjmp    Label147
 a9c:   clr     r17
 a9e:   sts     0x0067, r17
 aa2:   andi    r23, 0x7e       ; 126
 aa4:   rjmp    Label151

; Referenced from offset 0xa8e by rjmp
Label144:
 aa6:   ldi     r16, 0xd0       ; 208
 aa8:   andi    r17, 0xfe       ; 254
 aaa:   rjmp    Label148

; Referenced from offset 0xa92 by rjmp
Label145:
 aac:   ldi     r16, 0x80       ; 128
 aae:   andi    r17, 0xfd       ; 253
 ab0:   rjmp    Label148

; Referenced from offset 0xa96 by rjmp
Label146:
 ab2:   ldi     r16, 0x50       ; 80
 ab4:   andi    r17, 0xfb       ; 251
 ab6:   rjmp    Label148

; Referenced from offset 0xa9a by rjmp
Label147:
 ab8:   ldi     r16, 0xc0       ; 192
 aba:   andi    r17, 0xf7       ; 247
 abc:   rjmp    Label148

; Referenced from offset 0xaaa by rjmp
; Referenced from offset 0xab0 by rjmp
; Referenced from offset 0xab6 by rjmp
; Referenced from offset 0xabc by rjmp
Label148:
 abe:   st      Y+, r16
 ac0:   st      Y+, r16
 ac2:   sts     0x00d2, r28
 ac6:   sts     0x0067, r17
 aca:   cpi     r17, 0x00       ; 0
 acc:   brne    Label149
 ace:   andi    r23, 0x7f       ; 127

; Referenced from offset 0xacc by brne
Label149:
 ad0:   cli
 ad2:   sbi     UCR, 5          ; 0x20 = 32
 ad4:   sei
 ad6:   rjmp    Label158

; Referenced from offset 0xa78 by rjmp
Label150:
 ad8:   andi    r23, 0x7f       ; 127
 ada:   clr     r17
 adc:   sts     0x0067, r17

; Referenced from offset 0xa74 by rjmp
; Referenced from offset 0xaa4 by rjmp
Label151:
 ae0:   sbrs    r23, 5          ; 0x20 = 32
 ae2:   rjmp    Label153
 ae4:   sbic    PINB, 3         ; 0x08 = 8
 ae6:   rjmp    Label152
 ae8:   ori     r23, 0x01       ; 1
 aea:   andi    r23, 0xdf       ; 223
 aec:   clr     r29
 aee:   ldi     r28, 0xc0       ; 192
 af0:   sts     0x00d1, r28
 af4:   ldi     r16, 0x02       ; 2
 af6:   st      Y+, r16
 af8:   ldi     r16, 0xd1       ; 209
 afa:   st      Y+, r16
 afc:   mov     r17, r16
 afe:   lds     r16, 0x008f
 b02:   add     r17, r16
 b04:   st      Y+, r16
 b06:   st      Y+, r17
 b08:   sts     0x00d2, r28
 b0c:   cli
 b0e:   sbi     UCR, 5          ; 0x20 = 32
 b10:   sei
 b12:   rjmp    Label158

; Referenced from offset 0xae6 by rjmp
Label152:
 b14:   andi    r23, 0xdf       ; 223

; Referenced from offset 0xae2 by rjmp
Label153:
 b16:   sbrs    r22, 1          ; 0x02 = 2
 b18:   rjmp    Label156
 b1a:   sbic    PINB, 3         ; 0x08 = 8
 b1c:   rjmp    Label155
 b1e:   ori     r23, 0x01       ; 1
 b20:   andi    r22, 0xfd       ; 253
 b22:   clr     r29
 b24:   ldi     r28, 0xc0       ; 192
 b26:   sts     0x00d1, r28
 b2a:   ldi     r27, 0x01       ; 1
 b2c:   ldi     r26, 0x00       ; 0
 b2e:   lds     r18, 0x00f8
 b32:   ldi     r16, 0x02       ; 2
 b34:   st      Y+, r16
 b36:   ldi     r16, 0xb0       ; 176
 b38:   or      r16, r18
 b3a:   st      Y+, r16
 b3c:   mov     r17, r16

; Referenced from offset 0xb46 by brne
Label154:
 b3e:   ld      r16, X+
 b40:   st      Y+, r16
 b42:   add     r17, r16
 b44:   dec     r18
 b46:   brne    Label154
 b48:   st      Y+, r17
 b4a:   sts     0x00d2, r28
 b4e:   cli
 b50:   sbi     UCR, 5          ; 0x20 = 32
 b52:   sei
 b54:   rjmp    Label158

; Referenced from offset 0xb1c by rjmp
Label155:
 b56:   andi    r22, 0xfd       ; 253

; Referenced from offset 0xb18 by rjmp
Label156:
 b58:   sbrs    r22, 2          ; 0x04 = 4
 b5a:   rjmp    Label158
 b5c:   sbic    PINB, 3         ; 0x08 = 8
 b5e:   rjmp    Label157
 b60:   ori     r23, 0x01       ; 1
 b62:   andi    r22, 0xfb       ; 251
 b64:   clr     r29
 b66:   ldi     r28, 0xc0       ; 192
 b68:   sts     0x00d1, r28
 b6c:   ldi     r16, 0x02       ; 2
 b6e:   st      Y+, r16
 b70:   ldi     r16, 0x62       ; 98
 b72:   st      Y+, r16
 b74:   mov     r17, r16
 b76:   cli
 b78:   lds     r16, 0x0087
 b7c:   st      Y+, r16
 b7e:   add     r17, r16
 b80:   lds     r16, 0x0088
 b84:   sei
 b86:   st      Y+, r16
 b88:   add     r17, r16
 b8a:   st      Y+, r17
 b8c:   sts     0x00d2, r28
 b90:   cli
 b92:   sbi     UCR, 5          ; 0x20 = 32
 b94:   sei
 b96:   rjmp    Label158

; Referenced from offset 0xb5e by rjmp
Label157:
 b98:   andi    r22, 0xfb       ; 251

; Referenced from offset 0x81a by rjmp
; Referenced from offset 0x828 by rjmp
; Referenced from offset 0x83e by rjmp
; Referenced from offset 0x846 by rjmp
; Referenced from offset 0x868 by rjmp
; Referenced from offset 0x878 by rjmp
; Referenced from offset 0x8e6 by rjmp
; Referenced from offset 0x90a by rjmp
; Referenced from offset 0x936 by rjmp
; Referenced from offset 0x980 by rjmp
; Referenced from offset 0x9b8 by rjmp
; Referenced from offset 0xa6e by rjmp
; Referenced from offset 0xad6 by rjmp
; Referenced from offset 0xb12 by rjmp
; Referenced from offset 0xb54 by rjmp
; Referenced from offset 0xb5a by rjmp
; Referenced from offset 0xb96 by rjmp
Label158:
main_adc_start:
 b9a:   sbrc    r24, 7          ; 0x80 = 128
 b9c:   rjmp    Label170
 b9e:   sbic    ADCSR, 7        ; 0x80 = 128
 ba0:   rjmp    Label159
 ba2:   ldi     r16, 0x9d       ; 157
 ba4:   out     ADCSR, r16

; Referenced from offset 0xba0 by rjmp
Label159:
 ba6:   sbrs    r25, 0          ; 0x01 = 1
 ba8:   rjmp    Label162
 baa:   ori     r24, 0x81       ; 129
 bac:   andi    r25, 0xfe       ; 254
 bae:   mov     r16, r9
 bb0:   sbrs    r16, 1          ; 0x02 = 2
 bb2:   rjmp    Label160
 bb4:   rjmp    Label161

; Referenced from offset 0xbb2 by rjmp
Label160:
 bb6:   sbi     PORTC, 3        ; 0x08 = 8
 bb8:   cbi     PORTC, 2        ; 0x04 = 4
 bba:   sbi     PORTC, 1        ; 0x02 = 2
 bbc:   cbi     PORTC, 0        ; 0x01 = 1

; Referenced from offset 0xbb4 by rjmp
Label161:
 bbe:   rcall   Function1
 bc0:   ldi     r16, 0x07       ; 7
 bc2:   out     ADMUX, r16
 bc4:   ldi     r16, 0xdd       ; 221
 bc6:   out     ADCSR, r16
 bc8:   rjmp    Label170

; Referenced from offset 0xba8 by rjmp
Label162:
 bca:   sbrs    r25, 1          ; 0x02 = 2
 bcc:   rjmp    Label165
 bce:   ori     r24, 0x82       ; 130
 bd0:   andi    r25, 0xfd       ; 253
 bd2:   mov     r16, r9
 bd4:   sbrs    r16, 1          ; 0x02 = 2
 bd6:   rjmp    Label163
 bd8:   cbi     PORTC, 2        ; 0x04 = 4
 bda:   sbi     PORTC, 0        ; 0x01 = 1
 bdc:   sbi     PORTC, 1        ; 0x02 = 2
 bde:   cbi     PORTC, 3        ; 0x08 = 8
 be0:   rjmp    Label164

; Referenced from offset 0xbd6 by rjmp
Label163:
 be2:   sbi     PORTC, 0        ; 0x01 = 1
 be4:   cbi     PORTC, 1        ; 0x02 = 2
 be6:   sbi     PORTC, 2        ; 0x04 = 4
 be8:   cbi     PORTC, 3        ; 0x08 = 8

; Referenced from offset 0xbe0 by rjmp
Label164:
 bea:   rcall   Function1
 bec:   ldi     r16, 0x06       ; 6
 bee:   out     ADMUX, r16
 bf0:   ldi     r16, 0xdd       ; 221
 bf2:   out     ADCSR, r16
 bf4:   rjmp    Label170

; Referenced from offset 0xbcc by rjmp
Label165:
 bf6:   sbrs    r25, 2          ; 0x04 = 4
 bf8:   rjmp    Label166
 bfa:   ori     r24, 0x84       ; 132
 bfc:   andi    r25, 0xfb       ; 251
 bfe:   ldi     r16, 0x05       ; 5
 c00:   out     ADMUX, r16
 c02:   ldi     r16, 0xdd       ; 221
 c04:   out     ADCSR, r16
 c06:   rjmp    Label170

; Referenced from offset 0xbf8 by rjmp
Label166:
 c08:   sbrs    r25, 3          ; 0x08 = 8
 c0a:   rjmp    Label167
 c0c:   ori     r24, 0x88       ; 136
 c0e:   andi    r25, 0xf7       ; 247
 c10:   ldi     r16, 0x04       ; 4
 c12:   out     ADMUX, r16
 c14:   ldi     r16, 0xdd       ; 221
 c16:   out     ADCSR, r16
 c18:   rjmp    Label170

; Referenced from offset 0xc0a by rjmp
Label167:
 c1a:   sbrs    r25, 4          ; 0x10 = 16
 c1c:   rjmp    Label168
 c1e:   ori     r24, 0x90       ; 144
 c20:   andi    r25, 0xef       ; 239
 c22:   ldi     r16, 0x03       ; 3
 c24:   out     ADMUX, r16
 c26:   ldi     r16, 0xdd       ; 221
 c28:   out     ADCSR, r16
 c2a:   rjmp    Label170

; Referenced from offset 0xc1c by rjmp
Label168:
 c2c:   sbrs    r25, 5          ; 0x20 = 32
 c2e:   rjmp    Label169
 c30:   ori     r24, 0xa0       ; 160
 c32:   andi    r25, 0xdf       ; 223
 c34:   ldi     r16, 0x02       ; 2
 c36:   out     ADMUX, r16
 c38:   ldi     r16, 0xdd       ; 221
 c3a:   out     ADCSR, r16
 c3c:   rjmp    Label170

; Referenced from offset 0xc2e by rjmp
Label169:
 c3e:   sbrs    r25, 6          ; 0x40 = 64
 c40:   rjmp    Label170
 c42:   ori     r24, 0xc0       ; 192
 c44:   andi    r25, 0xbf       ; 191
 c46:   ldi     r16, 0x01       ; 1
 c48:   out     ADMUX, r16
 c4a:   ldi     r16, 0xdd       ; 221
 c4c:   out     ADCSR, r16
 c4e:   rjmp    Label170

; Referenced from offset 0xb9c by rjmp
; Referenced from offset 0xbc8 by rjmp
; Referenced from offset 0xbf4 by rjmp
; Referenced from offset 0xc06 by rjmp
; Referenced from offset 0xc18 by rjmp
; Referenced from offset 0xc2a by rjmp
; Referenced from offset 0xc3c by rjmp
; Referenced from offset 0xc40 by rjmp
; Referenced from offset 0xc4e by rjmp
Label170:
main_notif_led_start:
 c50:   lds     r16, 0x006d
 c54:   sbrs    r16, 0          ; 0x01 = 1
 c56:   rjmp    Notify_LED_Off
 c58:   sbrs    r16, 1          ; 0x02 = 2
 c5a:   rjmp    Label178
 c5c:   andi    r16, 0xfd       ; 253
 c5e:   sts     0x006d, r16
 c62:   lds     r16, 0x0074
 c66:   dec     r16
 c68:   breq    Label171
 c6a:   sts     0x0074, r16
 c6e:   rjmp    Label173

; Referenced from offset 0xc68 by breq
Label171:
 c70:   sbis    PINB, 4         ; 0x10 = 16
 c72:   rjmp    Label172
 c74:   cbi     PORTB, 4        ; 0x10 = 16
 c76:   lds     r16, 0x006f
 c7a:   sts     0x0074, r16
 c7e:   rjmp    Label173

; Referenced from offset 0xc72 by rjmp
Label172:
 c80:   sbi     PORTB, 4        ; 0x10 = 16
 c82:   lds     r16, 0x0070
 c86:   sts     0x0074, r16
 c8a:   rjmp    Label173

; Referenced from offset 0xc6e by rjmp
; Referenced from offset 0xc7e by rjmp
; Referenced from offset 0xc8a by rjmp
Label173:
 c8c:   lds     r16, 0x006d
 c90:   sbrc    r16, 2          ; 0x04 = 4
 c92:   rjmp    Label178
 c94:   lds     r16, 0x0072
 c98:   dec     r16
 c9a:   breq    Label174
 c9c:   sts     0x0072, r16
 ca0:   rjmp    Label178

; Referenced from offset 0xc9a by breq
Label174:
 ca2:   ldi     r16, 0x32       ; 50
 ca4:   sts     0x0072, r16
 ca8:   lds     r16, 0x0073
 cac:   dec     r16
 cae:   breq    Label175
 cb0:   sts     0x0073, r16
 cb4:   rjmp    Label178

; Referenced from offset 0xcae by breq
Label175:
 cb6:   ldi     r16, 0x0c       ; 12
 cb8:   sts     0x0073, r16
 cbc:   lds     r16, 0x006e
 cc0:   dec     r16
 cc2:   breq    Label176
 cc4:   sts     0x006e, r16
 cc8:   rjmp    Label178

; Referenced from offset 0xcc2 by breq
Label176:
 cca:   lds     r16, 0x006d
 cce:   andi    r16, 0xfc       ; 252
 cd0:   sts     0x006d, r16
 cd4:   sbi     PORTB, 4        ; 0x10 = 16
 cd6:   rjmp    Label178

; Referenced from offset 0xc56 by rjmp
Notify_LED_Off:
 cd8:   sbis    PINB, 4         ; 0x10 = 16
 cda:   sbi     PORTB, 4        ; 0x10 = 16

; Referenced from offset 0xc5a by rjmp
; Referenced from offset 0xc92 by rjmp
; Referenced from offset 0xca0 by rjmp
; Referenced from offset 0xcb4 by rjmp
; Referenced from offset 0xcc8 by rjmp
; Referenced from offset 0xcd6 by rjmp
Label178:
main_charging_logic_start:
 cdc:   lds     r16, 0x0075
 ce0:   sbrs    r16, 0          ; 0x01 = 1
 ce2:   rjmp    Label204
 ce4:   sbic    PINB, 0         ; 0x01 = 1
 ce6:   rjmp    Label203
 ce8:   lds     r16, 0x008d
 cec:   cpi     r16, 0x02       ; 2
 cee:   brcs    Label179
 cf0:   lds     r16, 0x0075
 cf4:   ori     r16, 0x08       ; 8
 cf6:   sts     0x0075, r16
 cfa:   rjmp    Label193

; Referenced from offset 0xcee by brcs
Label179:
 cfc:   lds     r16, 0x0075
 d00:   sbrc    r16, 1          ; 0x02 = 2
 d02:   rjmp    Label180
 d04:   rjmp    Label214

; Referenced from offset 0xd02 by rjmp
Label180:
 d06:   andi    r16, 0xfd       ; 253
 d08:   sts     0x0075, r16
 d0c:   lds     r16, 0x00ba
 d10:   dec     r16
 d12:   breq    Label181
 d14:   sts     0x00ba, r16
 d18:   rjmp    Label185

; Referenced from offset 0xd12 by breq
Label181:
 d1a:   ldi     r16, 0x0a       ; 10
 d1c:   sts     0x00ba, r16
 d20:   cli
 d22:   lds     r16, 0x0087
 d26:   lds     r17, 0x0088
 d2a:   sei
 d2c:   ldi     r18, 0x7b       ; 123
 d2e:   sub     r16, r18
 d30:   brcc    Label182
 d32:   ldi     r18, 0x00       ; 0
 d34:   inc     r18
 d36:   rjmp    Label183

; Referenced from offset 0xd30 by brcc
Label182:
 d38:   ldi     r18, 0x00       ; 0

; Referenced from offset 0xd36 by rjmp
Label183:
 d3a:   sub     r17, r18
 d3c:   brcs    Label184
 d3e:   rcall   Function13
 d40:   rjmp    Label185

; Referenced from offset 0xd3c by brcs
Label184:
 d42:   lds     r16, 0x0075
 d46:   ori     r16, 0x20       ; 32
 d48:   sts     0x0075, r16
 d4c:   rjmp    Label193

; Referenced from offset 0xd18 by rjmp
; Referenced from offset 0xd40 by rjmp
Label185:
 d4e:   lds     r16, 0x0076
 d52:   dec     r16
 d54:   breq    Label186
 d56:   sts     0x0076, r16
 d5a:   rjmp    Label214

; Referenced from offset 0xd54 by breq
Label186:
 d5c:   ldi     r16, 0x3c       ; 60
 d5e:   sts     0x0076, r16
 d62:   lds     r16, 0x0077
 d66:   dec     r16
 d68:   breq    Label187
 d6a:   sts     0x0077, r16
 d6e:   rjmp    Label214

; Referenced from offset 0xd68 by breq
Label187:
 d70:   ldi     r16, 0x3c       ; 60
 d72:   sts     0x0077, r16
 d76:   lds     r16, 0x0078
 d7a:   dec     r16
 d7c:   breq    Label188
 d7e:   sts     0x0078, r16
 d82:   cpi     r16, 0x07       ; 7
 d84:   breq    Label189
 d86:   rjmp    Label214

; Referenced from offset 0xd7c by breq
Label188:
 d88:   lds     r16, 0x0075
 d8c:   ori     r16, 0x10       ; 16
 d8e:   sts     0x0075, r16
 d92:   rjmp    Label193

; Referenced from offset 0xd84 by breq
Label189:
 d94:   cli
 d96:   lds     r16, 0x007c
 d9a:   lds     r17, 0x007b
 d9e:   sei
 da0:   ldi     r18, 0xaa       ; 170
 da2:   sub     r16, r18
 da4:   brcc    Label190
 da6:   ldi     r18, 0x02       ; 2
 da8:   inc     r18
 daa:   rjmp    Label191

; Referenced from offset 0xda4 by brcc
Label190:
 dac:   ldi     r18, 0x02       ; 2

; Referenced from offset 0xdaa by rjmp
Label191:
 dae:   sub     r17, r18
 db0:   brcs    Label192
 db2:   rjmp    Label214

; Referenced from offset 0xdb0 by brcs
Label192:
 db4:   lds     r16, 0x0075
 db8:   ori     r16, 0x04       ; 4
 dba:   sts     0x0075, r16
 dbe:   rjmp    Label193

; Referenced from offset 0xcfa by rjmp
; Referenced from offset 0xd4c by rjmp
; Referenced from offset 0xd92 by rjmp
; Referenced from offset 0xdbe by rjmp
Label193:
 dc0:   lds     r16, 0x0075
 dc4:   andi    r16, 0xfc       ; 252
 dc6:   sts     0x0075, r16
 dca:   lds     r16, 0x0075
 dce:   sbrc    r16, 3          ; 0x08 = 8
 dd0:   rjmp    Label194
 dd2:   sbrc    r16, 4          ; 0x10 = 16
 dd4:   rjmp    Label195
 dd6:   sbrc    r16, 2          ; 0x04 = 4
 dd8:   rjmp    Label197
 dda:   sbrc    r16, 5          ; 0x20 = 32
 ddc:   rjmp    Label196
 dde:   rjmp    Label214

; Referenced from offset 0xdd0 by rjmp
Label194:
 de0:   andi    r16, 0xf7       ; 247
 de2:   sts     0x0075, r16
 de6:   rjmp    Label198

; Referenced from offset 0xdd4 by rjmp
Label195:
 de8:   andi    r16, 0xef       ; 239
 dea:   sts     0x0075, r16
 dee:   rjmp    Label198

; Referenced from offset 0xddc by rjmp
Label196:
 df0:   andi    r16, 0xdf       ; 223
 df2:   sts     0x0075, r16

; Referenced from offset 0xdd8 by rjmp
Label197:
 df6:   rjmp    Label202

; Referenced from offset 0xde6 by rjmp
; Referenced from offset 0xdee by rjmp
Label198:
 df8:   cli
 dfa:   lds     r16, 0x007c
 dfe:   lds     r17, 0x007b
 e02:   sei
 e04:   ldi     r18, 0x99       ; 153
 e06:   sub     r16, r18
 e08:   brcc    Label199
 e0a:   ldi     r18, 0x03       ; 3
 e0c:   inc     r18
 e0e:   rjmp    Label200

; Referenced from offset 0xe08 by brcc
Label199:
 e10:   ldi     r18, 0x03       ; 3

; Referenced from offset 0xe0e by rjmp
Label200:
 e12:   sub     r17, r18
 e14:   brcc    Label201
 e16:   rjmp    Label202

; Referenced from offset 0xe14 by brcc
Label201:
 e18:   lds     r16, 0x0075
 e1c:   ori     r16, 0x80       ; 128
 e1e:   ori     r16, 0x40       ; 64
 e20:   sts     0x0075, r16
 e24:   rjmp    Label202

; Referenced from offset 0xdf6 by rjmp
; Referenced from offset 0xe16 by rjmp
; Referenced from offset 0xe24 by rjmp
Label202:
 e26:   sbi     PORTC, 6        ; 0x40 = 64
 e28:   cbi     PORTB, 1        ; 0x02 = 2
 e2a:   lds     r16, 0x008c
 e2e:   andi    r16, 0xfb       ; 251
 e30:   ori     r16, 0x08       ; 8
 e32:   sts     0x008c, r16
 e36:   rjmp    Label214

; Referenced from offset 0xce6 by rjmp
Label203:
 e38:   clr     r16
 e3a:   sts     0x008c, r16
 e3e:   sts     0x0075, r16
 e42:   cbi     PORTB, 1        ; 0x02 = 2
 e44:   sbi     PORTC, 6        ; 0x40 = 64
 e46:   rjmp    Label214

; Referenced from offset 0xce2 by rjmp
Label204:
 e48:   sbic    PINB, 0         ; 0x01 = 1
 e4a:   rjmp    Label213
 e4c:   lds     r16, 0x0075
 e50:   sbrc    r16, 2          ; 0x04 = 4
 e52:   rjmp    Label214
 e54:   lds     r16, 0x008c
 e58:   sbrc    r16, 3          ; 0x08 = 8
 e5a:   rjmp    Label205
 e5c:   sbrc    r16, 1          ; 0x02 = 2
 e5e:   rjmp    Label212
 e60:   sbrc    r16, 0          ; 0x01 = 1
 e62:   rjmp    Label210
 e64:   clr     r16
 e66:   sts     0x0087, r16
 e6a:   sts     0x0088, r16
 e6e:   ldi     r16, 0x03       ; 3
 e70:   sts     0x0089, r16
 e74:   lds     r16, 0x008c
 e78:   ori     r16, 0x01       ; 1
 e7a:   sts     0x008c, r16
 e7e:   rjmp    Label210

; Referenced from offset 0xe5a by rjmp
Label205:
 e80:   lds     r16, 0x0075
 e84:   sbrs    r16, 7          ; 0x80 = 128
 e86:   rjmp    Label206
 e88:   lds     r16, 0x006d
 e8c:   sbrs    r16, 0          ; 0x01 = 1
 e8e:   cbi     PORTC, 6        ; 0x40 = 64

; Referenced from offset 0xe86 by rjmp
Label206:
 e90:   cli
 e92:   lds     r16, 0x007c
 e96:   lds     r17, 0x007b
 e9a:   sei
 e9c:   ldi     r18, 0x8b       ; 139
 e9e:   sub     r16, r18
 ea0:   brcc    Label207
 ea2:   ldi     r18, 0x03       ; 3
 ea4:   inc     r18
 ea6:   rjmp    Label208

; Referenced from offset 0xea0 by brcc
Label207:
 ea8:   ldi     r18, 0x03       ; 3

; Referenced from offset 0xea6 by rjmp
Label208:
 eaa:   sub     r17, r18
 eac:   brcs    Label209
 eae:   rjmp    Label214

; Referenced from offset 0xeac by brcs
Label209:
 eb0:   lds     r16, 0x0075
 eb4:   andi    r16, 0x7f       ; 127
 eb6:   andi    r16, 0xbf       ; 191
 eb8:   sts     0x0075, r16
 ebc:   sbi     PORTC, 6        ; 0x40 = 64
 ebe:   clr     r16
 ec0:   sts     0x0087, r16
 ec4:   sts     0x0088, r16
 ec8:   ldi     r16, 0x03       ; 3
 eca:   sts     0x0089, r16
 ece:   lds     r16, 0x008c
 ed2:   ori     r16, 0x01       ; 1
 ed4:   andi    r16, 0xf7       ; 247
 ed6:   sts     0x008c, r16
 eda:   rjmp    Label210

; Referenced from offset 0xe62 by rjmp
; Referenced from offset 0xe7e by rjmp
; Referenced from offset 0xeda by rjmp
Label210:
 edc:   cli
 ede:   lds     r16, 0x0087
 ee2:   lds     r17, 0x0088
 ee6:   sei
 ee8:   ldi     r18, 0x8f       ; 143
 eea:   sub     r16, r18
 eec:   brcc    Label211
 eee:   ldi     r18, 0x00       ; 0
 ef0:   inc     r18
 ef2:   sub     r17, r18
 ef4:   brcs    Label214

; Referenced from offset 0xeec by brcc
Label211:
 ef6:   lds     r16, 0x008c
 efa:   andi    r16, 0xfe       ; 254
 efc:   ori     r16, 0x02       ; 2
 efe:   sts     0x008c, r16
 f02:   rjmp    Label212

; Referenced from offset 0xe5e by rjmp
; Referenced from offset 0xf02 by rjmp
Label212:
 f04:   rcall   Function13
 f06:   ldi     r16, 0x3c       ; 60
 f08:   sts     0x0076, r16
 f0c:   ldi     r16, 0x3c       ; 60
 f0e:   sts     0x0077, r16
 f12:   ldi     r16, 0x08       ; 8
 f14:   sts     0x0078, r16
 f18:   clr     r16
 f1a:   sts     0x008d, r16
 f1e:   ldi     r16, 0x05       ; 5
 f20:   sts     0x008a, r16
 f24:   ldi     r16, 0x0a       ; 10
 f26:   sts     0x00ba, r16
 f2a:   sbi     PORTA, 0        ; 0x01 = 1
 f2c:   sbi     PORTB, 1        ; 0x02 = 2
 f2e:   ldi     r16, 0x01       ; 1
 f30:   sts     0x0075, r16
 f34:   lds     r16, 0x008c
 f38:   andi    r16, 0xfd       ; 253
 f3a:   ori     r16, 0x04       ; 4
 f3c:   sts     0x008c, r16
 f40:   rjmp    Label214

; Referenced from offset 0xe4a by rjmp
Label213:
 f42:   clr     r16
 f44:   sts     0x0075, r16
 f48:   sts     0x008c, r16
 f4c:   sbi     PORTC, 6        ; 0x40 = 64
 f4e:   rjmp    Label214

; Referenced from offset 0xd04 by rjmp
; Referenced from offset 0xd5a by rjmp
; Referenced from offset 0xd6e by rjmp
; Referenced from offset 0xd86 by rjmp
; Referenced from offset 0xdb2 by rjmp
; Referenced from offset 0xdde by rjmp
; Referenced from offset 0xe36 by rjmp
; Referenced from offset 0xe46 by rjmp
; Referenced from offset 0xe52 by rjmp
; Referenced from offset 0xeae by rjmp
; Referenced from offset 0xef4 by brcs
; Referenced from offset 0xf40 by rjmp
; Referenced from offset 0xf4e by rjmp
Label214:
main_r9_handler_start:
 f50:   mov     r16, r9
 f52:   sbrs    r16, 0          ; 0x01 = 1
 f54:   rjmp    Label215
 f56:   lds     r17, 0x0064
 f5a:   sbrs    r17, 0          ; 0x01 = 1
 f5c:   rjmp    Label240
 f5e:   sbic    PINB, 3         ; 0x08 = 8
 f60:   rjmp    Label239
 f62:   andi    r16, 0xfe       ; 254
 f64:   ori     r16, 0x0a       ; 10
 f66:   mov     r9, r16
 f68:   clr     r17
 f6a:   sts     0x0064, r17
 f6e:   ori     r25, 0x02       ; 2
 f70:   rjmp    Label240

; Referenced from offset 0xf54 by rjmp
Label215:
 f72:   sbrs    r16, 1          ; 0x02 = 2
 f74:   rjmp    Label236
 f76:   lds     r17, 0x0064
 f7a:   sbrs    r17, 1          ; 0x02 = 2
 f7c:   rjmp    Label240
 f7e:   sbrs    r17, 3          ; 0x08 = 8
 f80:   rjmp    Label240
 f82:   sbic    PINB, 3         ; 0x08 = 8
 f84:   rjmp    Label239
 f86:   sbic    PIND, 3         ; 0x08 = 8
 f88:   rjmp    Label237
 f8a:   mov     r17, r11
 f8c:   mov     r18, r10
 f8e:   mov     r16, r13
 f90:   sub     r17, r16
 f92:   brcc    Label216
 f94:   mov     r16, r12
 f96:   inc     r16
 f98:   rjmp    Label217

; Referenced from offset 0xf92 by brcc
Label216:
 f9a:   mov     r16, r12

; Referenced from offset 0xf98 by rjmp
Label217:
 f9c:   sub     r18, r16
 f9e:   mov     r15, r17
 fa0:   mov     r14, r18
 fa2:   lds     r17, 0x0063
 fa6:   lds     r18, 0x0062
 faa:   ldi     r16, 0x00       ; 0
 fac:   sub     r16, r17
 fae:   brcc    Label218
 fb0:   inc     r18

; Referenced from offset 0xfae by brcc
Label218:
 fb2:   ldi     r16, 0x02       ; 2
 fb4:   sub     r16, r18
 fb6:   brcc    Label219
 fb8:   rjmp    Label226

; Referenced from offset 0xfb6 by brcc
Label219:
 fba:   lds     r17, 0x0061
 fbe:   lds     r18, 0x0060
 fc2:   ldi     r16, 0x00       ; 0
 fc4:   sub     r16, r17
 fc6:   brcc    Label220
 fc8:   inc     r18

; Referenced from offset 0xfc6 by brcc
Label220:
 fca:   ldi     r16, 0x02       ; 2
 fcc:   sub     r16, r18
 fce:   brcc    Label221
 fd0:   rjmp    Label223

; Referenced from offset 0xfce by brcc
Label221:
 fd2:   mov     r17, r15
 fd4:   mov     r18, r14
 fd6:   ldi     r16, 0xef       ; 239
 fd8:   sub     r16, r17
 fda:   brcc    Label222
 fdc:   inc     r18

; Referenced from offset 0xfda by brcc
Label222:
 fde:   ldi     r16, 0x03       ; 3
 fe0:   sub     r16, r18
 fe2:   brcc    Label225
 fe4:   rjmp    Label232

; Referenced from offset 0xfd0 by rjmp
Label223:
 fe6:   mov     r17, r15
 fe8:   mov     r18, r14
 fea:   ldi     r16, 0xef       ; 239
 fec:   sub     r16, r17
 fee:   brcc    Label224
 ff0:   inc     r18

; Referenced from offset 0xfee by brcc
Label224:
 ff2:   ldi     r16, 0x03       ; 3
 ff4:   sub     r16, r18
 ff6:   brcc    Label225
 ff8:   rjmp    Label232

; Referenced from offset 0xfe2 by brcc
; Referenced from offset 0xff6 by brcc
; Referenced from offset 0x1024 by brcc
; Referenced from offset 0x1038 by brcc
Label225:
 ffa:   rjmp    Label233

; Referenced from offset 0xfb8 by rjmp
Label226:
 ffc:   lds     r17, 0x0061
1000:   lds     r18, 0x0060
1004:   ldi     r16, 0x00       ; 0
1006:   sub     r16, r17
1008:   brcc    Label227
100a:   inc     r18

; Referenced from offset 0x1008 by brcc
Label227:
100c:   ldi     r16, 0x02       ; 2
100e:   sub     r16, r18
1010:   brcc    Label228
1012:   rjmp    Label230

; Referenced from offset 0x1010 by brcc
Label228:
1014:   mov     r17, r15
1016:   mov     r18, r14
1018:   ldi     r16, 0xef       ; 239
101a:   sub     r16, r17
101c:   brcc    Label229
101e:   inc     r18

; Referenced from offset 0x101c by brcc
Label229:
1020:   ldi     r16, 0x03       ; 3
1022:   sub     r16, r18
1024:   brcc    Label225
1026:   rjmp    Label232

; Referenced from offset 0x1012 by rjmp
Label230:
1028:   mov     r17, r15
102a:   mov     r18, r14
102c:   ldi     r16, 0xef       ; 239
102e:   sub     r16, r17
1030:   brcc    Label231
1032:   inc     r18

; Referenced from offset 0x1030 by brcc
Label231:
1034:   ldi     r16, 0x03       ; 3
1036:   sub     r16, r18
1038:   brcc    Label225
103a:   rjmp    Label232

; Referenced from offset 0xfe4 by rjmp
; Referenced from offset 0xff8 by rjmp
; Referenced from offset 0x1026 by rjmp
; Referenced from offset 0x103a by rjmp
Label232:
103c:   mov     r16, r9
103e:   ori     r16, 0x02       ; 2
1040:   andi    r16, 0xe7       ; 231
1042:   mov     r9, r16
1044:   clr     r16
1046:   sts     0x0064, r16
104a:   ori     r25, 0x02       ; 2
104c:   rjmp    Label240

; Referenced from offset 0xffa by rjmp
Label233:
104e:   mov     r16, r9
1050:   sbrs    r16, 3          ; 0x08 = 8
1052:   rjmp    Label234
1054:   andi    r16, 0xe5       ; 229
1056:   ori     r16, 0x04       ; 4
1058:   mov     r9, r16
105a:   ldi     r16, 0x04       ; 4
105c:   sts     0x0079, r16
1060:   rjmp    Label235

; Referenced from offset 0x1052 by rjmp
Label234:
1062:   andi    r16, 0xfd       ; 253
1064:   ori     r16, 0x01       ; 1
1066:   mov     r9, r16
1068:   ori     r25, 0x02       ; 2

; Referenced from offset 0x1060 by rjmp
Label235:
106a:   clr     r17
106c:   sts     0x0064, r17
1070:   rjmp    Label240

; Referenced from offset 0xf74 by rjmp
Label236:
1072:   sbrs    r16, 2          ; 0x04 = 4
1074:   rjmp    Label240
1076:   lds     r17, 0x0064
107a:   sbrs    r17, 2          ; 0x04 = 4
107c:   rjmp    Label240
107e:   sbic    PINB, 3         ; 0x08 = 8
1080:   rjmp    Label239
1082:   sbic    PIND, 3         ; 0x08 = 8
1084:   rjmp    Label237
1086:   andi    r16, 0xbb       ; 187
1088:   ori     r16, 0x02       ; 2
108a:   mov     r9, r16
108c:   clr     r17
108e:   sts     0x0064, r17
1092:   ori     r25, 0x02       ; 2
1094:   ori     r23, 0x02       ; 2
1096:   rjmp    Label240

; Referenced from offset 0xf88 by rjmp
; Referenced from offset 0x1084 by rjmp
Label237:
1098:   mov     r16, r9
109a:   sbrs    r16, 7          ; 0x80 = 128
109c:   rjmp    Label238
109e:   ldi     r16, 0x40       ; 64
10a0:   mov     r9, r16
10a2:   clr     r16
10a4:   sts     0x0064, r16
10a8:   ori     r23, 0x02       ; 2
10aa:   rjmp    Label240

; Referenced from offset 0x109c by rjmp
Label238:
10ac:   clr     r16
10ae:   mov     r9, r16
10b0:   sts     0x0064, r16
10b4:   in      r16, GIMSK
10b6:   ori     r16, 0x80       ; 128
10b8:   out     GIMSK, r16
10ba:   ldi     r16, 0x80       ; 128
10bc:   out     GIFR, r16
10be:   rjmp    Label240

; Referenced from offset 0xf60 by rjmp
; Referenced from offset 0xf84 by rjmp
; Referenced from offset 0x1080 by rjmp
Label239:
10c0:   clr     r16
10c2:   mov     r9, r16
10c4:   sts     0x0064, r16
10c8:   cbi     PORTC, 0        ; 0x01 = 1
10ca:   sbi     PORTC, 2        ; 0x04 = 4
10cc:   sbi     PORTC, 1        ; 0x02 = 2
10ce:   sbi     PORTC, 3        ; 0x08 = 8

; Referenced from offset 0xf5c by rjmp
; Referenced from offset 0xf70 by rjmp
; Referenced from offset 0xf7c by rjmp
; Referenced from offset 0xf80 by rjmp
; Referenced from offset 0x104c by rjmp
; Referenced from offset 0x1070 by rjmp
; Referenced from offset 0x1074 by rjmp
; Referenced from offset 0x107c by rjmp
; Referenced from offset 0x1096 by rjmp
; Referenced from offset 0x10aa by rjmp
; Referenced from offset 0x10be by rjmp
Label240:
main_spi_start:
10d0:   lds     r16, 0x00f3
10d4:   sbrc    r16, 7          ; 0x80 = 128
10d6:   rjmp    Label249
10d8:   lds     r17, 0x00f4
10dc:   andi    r17, 0x0f       ; 15
10de:   brne    Label241
10e0:   rjmp    Label249

; Referenced from offset 0x10de by brne
Label241:
10e2:   sbis    SPCR, 6         ; 0x40 = 64
10e4:   sbi     SPCR, 6         ; 0x40 = 64
10e6:   lds     r18, 0x00f4
10ea:   sbrs    r18, 1          ; 0x02 = 2
10ec:   rjmp    Label242
10ee:   ori     r16, 0x81       ; 129
10f0:   sts     0x00f3, r16
10f4:   andi    r18, 0xfd       ; 253
10f6:   sts     0x00f4, r18
10fa:   lds     r17, 0x00f6
10fe:   andi    r17, 0x7f       ; 127
1100:   ori     r17, 0x01       ; 1
1102:   sts     0x00f6, r17
1106:   ldi     r17, 0x11       ; 17
1108:   sts     0x00fc, r17
110c:   lds     r17, 0x00f5
1110:   ori     r17, 0x02       ; 2
1112:   sts     0x00f5, r17
1116:   cbi     PORTD, 5        ; 0x20 = 32
1118:   clr     r16
111a:   sts     0x00a1, r16
111e:   sts     0x00a2, r16
1122:   ldi     r16, 0x06       ; 6
1124:   out     SPDR, r16
1126:   rjmp    Label249

; Referenced from offset 0x10ec by rjmp
Label242:
1128:   sbrs    r18, 0          ; 0x01 = 1
112a:   rjmp    Label245
112c:   ori     r16, 0x81       ; 129
112e:   sts     0x00f3, r16
1132:   andi    r18, 0xfe       ; 254
1134:   sts     0x00f4, r18
1138:   lds     r17, 0x00f5
113c:   ori     r17, 0x01       ; 1
113e:   sts     0x00f5, r17
1142:   cbi     PORTD, 5        ; 0x20 = 32
1144:   clr     r29
1146:   ldi     r28, 0x90       ; 144
1148:   sts     0x00a1, r28
114c:   lds     r17, 0x00fb
1150:   cpi     r17, 0x00       ; 0
1152:   breq    Label244
1154:   lds     r17, 0x00f9
1158:   st      Y+, r17
115a:   sts     0x00a2, r28
115e:   lds     r16, 0x00fb
1162:   sts     0x00f7, r16
1166:   ldi     r16, 0x03       ; 3
1168:   lds     r17, 0x00fa
116c:   cpi     r17, 0x01       ; 1
116e:   brne    Label243
1170:   ori     r16, 0x08       ; 8

; Referenced from offset 0x116e by brne
Label243:
1172:   out     SPDR, r16
1174:   rjmp    Label249

; Referenced from offset 0x1152 by breq
Label244:
1176:   sts     0x00a2, r28
117a:   ldi     r16, 0x01       ; 1
117c:   sts     0x00f7, r16
1180:   ldi     r16, 0x05       ; 5
1182:   out     SPDR, r16
1184:   rjmp    Label249

; Referenced from offset 0x112a by rjmp
Label245:
1186:   sbrs    r18, 2          ; 0x04 = 4
1188:   rjmp    Label247
118a:   ori     r16, 0x81       ; 129
118c:   sts     0x00f3, r16
1190:   andi    r18, 0xfb       ; 251
1192:   sts     0x00f4, r18
1196:   ldi     r17, 0x02       ; 2
1198:   sts     0x00fc, r17
119c:   lds     r17, 0x00f5
11a0:   ori     r17, 0x04       ; 4
11a2:   sts     0x00f5, r17
11a6:   cbi     PORTD, 5        ; 0x20 = 32
11a8:   nop
11aa:   nop
11ac:   nop
11ae:   sbi     PORTD, 5        ; 0x20 = 32
11b0:   ldi     r16, 0x30       ; 48

; Referenced from offset 0x11b4 by brne
Label246:
11b2:   dec     r16
11b4:   brne    Label246
11b6:   clr     r29
11b8:   ldi     r28, 0x90       ; 144
11ba:   sts     0x00a1, r28
11be:   ldi     r16, 0x10       ; 16
11c0:   st      Y+, r16
11c2:   st      Y+, r16
11c4:   sts     0x00a2, r28
11c8:   ldi     r16, 0x06       ; 6
11ca:   sts     0x00f7, r16
11ce:   ldi     r16, 0xa1       ; 161
11d0:   out     SPDR, r16
11d2:   rjmp    Label249

; Referenced from offset 0x1188 by rjmp
Label247:
11d4:   sbrs    r18, 3          ; 0x08 = 8
11d6:   rjmp    Label249
11d8:   ori     r16, 0x81       ; 129
11da:   sts     0x00f3, r16
11de:   andi    r18, 0xf7       ; 247
11e0:   sts     0x00f4, r18
11e4:   ldi     r17, 0x03       ; 3
11e6:   sts     0x00fc, r17
11ea:   lds     r17, 0x00f5
11ee:   ori     r17, 0x08       ; 8
11f0:   sts     0x00f5, r17
11f4:   cbi     PORTD, 5        ; 0x20 = 32
11f6:   nop
11f8:   nop
11fa:   nop
11fc:   sbi     PORTD, 5        ; 0x20 = 32
11fe:   ldi     r16, 0x30       ; 48

; Referenced from offset 0x1202 by brne
Label248:
1200:   dec     r16
1202:   brne    Label248
1204:   clr     r29
1206:   ldi     r28, 0x90       ; 144
1208:   sts     0x00a1, r28
120c:   ldi     r16, 0x20       ; 32
120e:   st      Y+, r16
1210:   st      Y+, r16
1212:   sts     0x00a2, r28
1216:   ldi     r16, 0x07       ; 7
1218:   sts     0x00f7, r16
121c:   ldi     r16, 0xa1       ; 161
121e:   out     SPDR, r16
1220:   rjmp    Label249

; Referenced from offset 0x10d6 by rjmp
; Referenced from offset 0x10e0 by rjmp
; Referenced from offset 0x1126 by rjmp
; Referenced from offset 0x1174 by rjmp
; Referenced from offset 0x1184 by rjmp
; Referenced from offset 0x11d2 by rjmp
; Referenced from offset 0x11d6 by rjmp
; Referenced from offset 0x1220 by rjmp
Label249:
1222:   lds     r16, 0x00f3
1226:   sbrs    r16, 2          ; 0x04 = 4
1228:   rjmp    Label274
122a:   lds     r17, 0x00f5
122e:   sbrs    r17, 0          ; 0x01 = 1
1230:   rjmp    Label254
1232:   sbrc    r16, 0          ; 0x01 = 1
1234:   rjmp    Label250
1236:   sbrc    r16, 1          ; 0x02 = 2
1238:   rjmp    Label251

; Referenced from offset 0x1234 by rjmp
Label250:
123a:   andi    r16, 0xfa       ; 250
123c:   ori     r16, 0x02       ; 2
123e:   sts     0x00f3, r16
1242:   ldi     r16, 0xa5       ; 165
1244:   sts     0x00a3, r16
1248:   clr     r16
124a:   sts     0x00f8, r16
124e:   out     SPDR, r16
1250:   rjmp    Label274

; Referenced from offset 0x1238 by rjmp
Label251:
1252:   sbi     PORTD, 5        ; 0x20 = 32
1254:   andi    r16, 0x79       ; 121
1256:   sts     0x00f3, r16
125a:   andi    r17, 0xfe       ; 254
125c:   sts     0x00f5, r17
1260:   ldi     r27, 0x01       ; 1
1262:   ldi     r26, 0x00       ; 0
1264:   clr     r29
1266:   ldi     r28, 0xa5       ; 165
1268:   lds     r18, 0x00a4
126c:   clr     r17

; Referenced from offset 0x1276 by brne
Label252:
126e:   ld      r16, Y+
1270:   st      X+, r16
1272:   inc     r17
1274:   cp      r18, r28
1276:   brne    Label252
1278:   sts     0x00f8, r17
127c:   sbic    PINB, 3         ; 0x08 = 8
127e:   rjmp    Label274
1280:   ori     r22, 0x02       ; 2
1282:   lds     r16, 0x00ff
1286:   andi    r16, 0x03       ; 3
1288:   breq    Label253
128a:   rjmp    Label274

; Referenced from offset 0x1288 by breq
Label253:
128c:   ori     r16, 0x01       ; 1
128e:   sts     0x00ff, r16
1292:   rjmp    Label274

; Referenced from offset 0x1230 by rjmp
Label254:
1294:   sbrs    r17, 1          ; 0x02 = 2
1296:   rjmp    Label260
1298:   sbi     PORTD, 5        ; 0x20 = 32
129a:   lds     r18, 0x00f6
129e:   sbrc    r18, 0          ; 0x01 = 1
12a0:   rjmp    Label255
12a2:   sbrc    r18, 1          ; 0x02 = 2
12a4:   rjmp    Label259

; Referenced from offset 0x12a0 by rjmp
Label255:
12a6:   andi    r16, 0xfb       ; 251
12a8:   sts     0x00f3, r16
12ac:   andi    r18, 0xfe       ; 254
12ae:   ori     r18, 0x02       ; 2
12b0:   sts     0x00f6, r18
12b4:   clr     r29
12b6:   ldi     r28, 0x90       ; 144
12b8:   sts     0x00a1, r28
12bc:   ldi     r27, 0x01       ; 1
12be:   ldi     r26, 0x13       ; 19
12c0:   ld      r18, X+
12c2:   cpi     r18, 0x00       ; 0
12c4:   breq    Label258
12c6:   ld      r17, X+
12c8:   st      Y+, r17
12ca:   ld      r16, X+

; Referenced from offset 0x12d2 by brne
Label256:
12cc:   ld      r17, X+
12ce:   st      Y+, r17
12d0:   dec     r18
12d2:   brne    Label256
12d4:   sts     0x00a2, r28
12d8:   cbi     PORTD, 5        ; 0x20 = 32
12da:   mov     r17, r16
12dc:   ldi     r16, 0x02       ; 2
12de:   cpi     r17, 0x01       ; 1
12e0:   brne    Label257
12e2:   ori     r16, 0x08       ; 8

; Referenced from offset 0x12e0 by brne
Label257:
12e4:   out     SPDR, r16
12e6:   rjmp    Label274

; Referenced from offset 0x12c4 by breq
Label258:
12e8:   ld      r17, X+
12ea:   st      Y+, r17
12ec:   sts     0x00a2, r28
12f0:   cbi     PORTD, 5        ; 0x20 = 32
12f2:   ldi     r16, 0x01       ; 1
12f4:   out     SPDR, r16
12f6:   rjmp    Label274

; Referenced from offset 0x12a4 by rjmp
Label259:
12f8:   sbrs    r18, 7          ; 0x80 = 128
12fa:   rjmp    Label274
12fc:   andi    r17, 0xfd       ; 253
12fe:   sts     0x00f5, r17
1302:   andi    r18, 0x7d       ; 125
1304:   sts     0x00f6, r18
1308:   andi    r16, 0x7a       ; 122
130a:   sts     0x00f3, r16
130e:   sbic    PINB, 3         ; 0x08 = 8
1310:   rjmp    Label274
1312:   lds     r16, 0x0067
1316:   ori     r16, 0x08       ; 8
1318:   sts     0x0067, r16
131c:   ori     r23, 0x80       ; 128
131e:   rjmp    Label274

; Referenced from offset 0x1296 by rjmp
Label260:
1320:   sbrs    r17, 2          ; 0x04 = 4
1322:   rjmp    Label266
1324:   sbrc    r16, 0          ; 0x01 = 1
1326:   rjmp    Label261
1328:   sbrc    r16, 1          ; 0x02 = 2
132a:   rjmp    Label262

; Referenced from offset 0x1326 by rjmp
Label261:
132c:   lds     r18, 0x00f6
1330:   sbrs    r18, 7          ; 0x80 = 128
1332:   rjmp    Label274
1334:   andi    r16, 0xfa       ; 250
1336:   ori     r16, 0x02       ; 2
1338:   sts     0x00f3, r16
133c:   ldi     r16, 0xa5       ; 165
133e:   sts     0x00a3, r16
1342:   clr     r16
1344:   sts     0x00f8, r16
1348:   out     SPDR, r16
134a:   rjmp    Label274

; Referenced from offset 0x132a by rjmp
Label262:
134c:   sbrs    r16, 3          ; 0x08 = 8
134e:   rjmp    Label264
1350:   andi    r16, 0xf3       ; 243
1352:   sts     0x00f3, r16
1356:   ldi     r16, 0x28       ; 40

; Referenced from offset 0x135a by brne
Label263:
1358:   dec     r16
135a:   brne    Label263
135c:   out     SPDR, r16
135e:   rjmp    Label274

; Referenced from offset 0x134e by rjmp
Label264:
1360:   andi    r16, 0x79       ; 121
1362:   sts     0x00f3, r16
1366:   andi    r17, 0xfb       ; 251
1368:   sts     0x00f5, r17
136c:   lds     r18, 0x00f6
1370:   andi    r18, 0x7f       ; 127
1372:   sts     0x00f6, r18
1376:   lds     r16, 0x00ff
137a:   ori     r16, 0x80       ; 128
137c:   sts     0x00ff, r16
1380:   clr     r29
1382:   ldi     r28, 0xa5       ; 165
1384:   ld      r16, Y+
1386:   cpi     r16, 0xa1       ; 161
1388:   brne    Label265
138a:   ld      r16, Y+
138c:   cpi     r16, 0x13       ; 19
138e:   brne    Label265
1390:   mov     r17, r16
1392:   ld      r16, Y+
1394:   add     r17, r16
1396:   ld      r16, Y+
1398:   add     r17, r16
139a:   ld      r16, Y+
139c:   add     r17, r16
139e:   ld      r16, Y+
13a0:   cp      r17, r16
13a2:   brne    Label265
13a4:   ldi     r28, 0xa5       ; 165
13a6:   inc     r28
13a8:   inc     r28
13aa:   ld      r16, Y+
13ac:   sts     0x00bc, r16
13b0:   ld      r16, Y+
13b2:   sts     0x00bd, r16
13b6:   ld      r16, Y+
13b8:   sts     0x00be, r16
13bc:   rjmp    Label274

; Referenced from offset 0x1388 by brne
; Referenced from offset 0x138e by brne
; Referenced from offset 0x13a2 by brne
Label265:
13be:   clr     r16
13c0:   sts     0x00bc, r16
13c4:   sts     0x00bd, r16
13c8:   sts     0x00be, r16
13cc:   rjmp    Label274

; Referenced from offset 0x1322 by rjmp
Label266:
13ce:   sbrs    r17, 3          ; 0x08 = 8
13d0:   rjmp    Label274
13d2:   sbrc    r16, 0          ; 0x01 = 1
13d4:   rjmp    Label267
13d6:   sbrc    r16, 1          ; 0x02 = 2
13d8:   rjmp    Label268

; Referenced from offset 0x13d4 by rjmp
Label267:
13da:   lds     r18, 0x00f6
13de:   sbrs    r18, 7          ; 0x80 = 128
13e0:   rjmp    Label274
13e2:   andi    r16, 0xfa       ; 250
13e4:   ori     r16, 0x02       ; 2
13e6:   sts     0x00f3, r16
13ea:   ldi     r16, 0xa5       ; 165
13ec:   sts     0x00a3, r16
13f0:   clr     r16
13f2:   sts     0x00f8, r16
13f6:   out     SPDR, r16
13f8:   rjmp    Label274

; Referenced from offset 0x13d8 by rjmp
Label268:
13fa:   sbrs    r16, 3          ; 0x08 = 8
13fc:   rjmp    Label270
13fe:   andi    r16, 0xf3       ; 243
1400:   sts     0x00f3, r16
1404:   ldi     r16, 0x28       ; 40

; Referenced from offset 0x1408 by brne
Label269:
1406:   dec     r16
1408:   brne    Label269
140a:   out     SPDR, r16
140c:   rjmp    Label274

; Referenced from offset 0x13fc by rjmp
Label270:
140e:   andi    r16, 0x79       ; 121
1410:   sts     0x00f3, r16
1414:   andi    r17, 0xf7       ; 247
1416:   sts     0x00f5, r17
141a:   lds     r18, 0x00f6
141e:   andi    r18, 0x7f       ; 127
1420:   sts     0x00f6, r18
1424:   clr     r29
1426:   ldi     r28, 0xa5       ; 165
1428:   ld      r16, Y+
142a:   cpi     r16, 0xa1       ; 161
142c:   brne    Label271
142e:   ld      r16, Y+
1430:   cpi     r16, 0x24       ; 36
1432:   brne    Label271
1434:   mov     r17, r16
1436:   ld      r16, Y+
1438:   add     r17, r16
143a:   ld      r16, Y+
143c:   add     r17, r16
143e:   ld      r16, Y+
1440:   add     r17, r16
1442:   ld      r16, Y+
1444:   add     r17, r16
1446:   ld      r16, Y+
1448:   cp      r17, r16
144a:   brne    Label271
144c:   ldi     r28, 0xa5       ; 165
144e:   inc     r28
1450:   inc     r28
1452:   ld      r16, Y+
1454:   sts     0x00b6, r16
1458:   ld      r16, Y+
145a:   sts     0x00b7, r16
145e:   ld      r16, Y+
1460:   sts     0x00b8, r16
1464:   ld      r7, Y+
1466:   lds     r16, 0x00ff
146a:   andi    r16, 0xfe       ; 254
146c:   ori     r16, 0x02       ; 2
146e:   sts     0x00ff, r16
1472:   rjmp    Label274

; Referenced from offset 0x142c by brne
; Referenced from offset 0x1432 by brne
; Referenced from offset 0x144a by brne
Label271:
1474:   lds     r16, 0x00ff
1478:   sbrc    r16, 0          ; 0x01 = 1
147a:   rjmp    Label272
147c:   ori     r16, 0x01       ; 1
147e:   andi    r16, 0xfd       ; 253
1480:   sts     0x00ff, r16
1484:   ldi     r16, 0x05       ; 5
1486:   sts     0x00b9, r16
148a:   rjmp    Label274

; Referenced from offset 0x147a by rjmp
Label272:
148c:   lds     r17, 0x00b9
1490:   dec     r17
1492:   breq    Label273
1494:   sts     0x00b9, r17
1498:   andi    r16, 0xfd       ; 253
149a:   sts     0x00ff, r16
149e:   rjmp    Label274

; Referenced from offset 0x1492 by breq
Label273:
14a0:   andi    r16, 0xfc       ; 252
14a2:   sts     0x00ff, r16
14a6:   clr     r16
14a8:   clr     r7
14aa:   sts     0x00b6, r16
14ae:   sts     0x00b7, r16
14b2:   sts     0x00b8, r16
14b6:   rjmp    Label274

; Referenced from offset 0x1228 by rjmp
; Referenced from offset 0x1250 by rjmp
; Referenced from offset 0x127e by rjmp
; Referenced from offset 0x128a by rjmp
; Referenced from offset 0x1292 by rjmp
; Referenced from offset 0x12e6 by rjmp
; Referenced from offset 0x12f6 by rjmp
; Referenced from offset 0x12fa by rjmp
; Referenced from offset 0x1310 by rjmp
; Referenced from offset 0x131e by rjmp
; Referenced from offset 0x1332 by rjmp
; Referenced from offset 0x134a by rjmp
; Referenced from offset 0x135e by rjmp
; Referenced from offset 0x13bc by rjmp
; Referenced from offset 0x13cc by rjmp
; Referenced from offset 0x13d0 by rjmp
; Referenced from offset 0x13e0 by rjmp
; Referenced from offset 0x13f8 by rjmp
; Referenced from offset 0x140c by rjmp
; Referenced from offset 0x1472 by rjmp
; Referenced from offset 0x148a by rjmp
; Referenced from offset 0x149e by rjmp
; Referenced from offset 0x14b6 by rjmp
Label274:
msg_handler_start:
14b8:   lds     r16, 0x0065
14bc:   sbrs    r16, 6          ; 0x40 = 64
14be:   rjmp    RX_Handler_DEMUX_Out
14c0:   sbis    PINB, 3         ; 0x08 = 8
14c2:   rjmp    RX_Handler_DEMUX
14c4:   clr     r16
14c6:   sts     0x0065, r16
14ca:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14c2 by rjmp
RX_Handler_DEMUX:
14cc:   ldi     r28, 0xde       ; 222
14ce:   clr     r29
14d0:   ld      r16, Y+
14d2:   sts     0x00ef, r28
14d6:   andi    r16, 0xf0       ; 240
14d8:   cpi     r16, 0x00       ; 0
14da:   brne    Label276
14dc:   rcall   RX_Handler_MSG_VERSION
14de:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14da by brne
Label276:
14e0:   cpi     r16, 0x40       ; 64
14e2:   brne    Label277
14e4:   rcall   RX_Handler_MSG_EEPROM_READ
14e6:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14e2 by brne
Label277:
14e8:   cpi     r16, 0x50       ; 80
14ea:   brne    Label278
14ec:   rcall   RX_Handler_MSG_EEPROM_WRITE
14ee:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14ea by brne
Label278:
14f0:   cpi     r16, 0x80       ; 128
14f2:   brne    Label279
14f4:   rcall   RX_Handler_MSG_NOTIFY_LED
14f6:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14f2 by brne
Label279:
14f8:   cpi     r16, 0x90       ; 144
14fa:   brne    Label280
14fc:   rcall   RX_Handler_MSG_BATTERY
14fe:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14fa by brne
Label280:
1500:   cpi     r16, 0xd0       ; 208
1502:   brne    Label281
1504:   rcall   RX_Handler_MSG_BACKLIGHT
1506:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x1502 by brne
Label281:
1508:   cpi     r16, 0xb0       ; 176
150a:   brne    Label282
150c:   rcall   RX_Handler_MSG_SPI_READ
150e:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x150a by brne
Label282:
1510:   cpi     r16, 0xc0       ; 192
1512:   brne    Label283
1514:   rcall   RX_Handler_MSG_SPI_WRITE
1516:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x1512 by brne
Label283:
1518:   cpi     r16, 0x60       ; 96
151a:   brne    Label284
151c:   rcall   RX_Handler_MSG_THERMAL_SENSOR
151e:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x151a by brne
Label284:
1520:   clr     r16
1522:   sts     0x0065, r16
1526:   rjmp    RX_Handler_DEMUX_Out

; Referenced from offset 0x14be by rjmp
; Referenced from offset 0x14ca by rjmp
; Referenced from offset 0x14de by rjmp
; Referenced from offset 0x14e6 by rjmp
; Referenced from offset 0x14ee by rjmp
; Referenced from offset 0x14f6 by rjmp
; Referenced from offset 0x14fe by rjmp
; Referenced from offset 0x1506 by rjmp
; Referenced from offset 0x150e by rjmp
; Referenced from offset 0x1516 by rjmp
; Referenced from offset 0x151e by rjmp
; Referenced from offset 0x1526 by rjmp
RX_Handler_DEMUX_Out:
1528:   sbis    PINB, 3         ; 0x08 = 8
152a:   rjmp    Label287
152c:   lds     r16, 0x008e
1530:   sbrs    r16, 0          ; 0x01 = 1
1532:   rjmp    Label286
1534:   cbi     PORTC, 7        ; 0x80 = 128
1536:   clr     r16
1538:   sts     0x008e, r16
153c:   out     TCCR1B, r16
153e:   rjmp    Label287

; Referenced from offset 0x1532 by rjmp
Label286:
1540:   sbrs    r16, 1          ; 0x02 = 2
1542:   rjmp    Label287
1544:   clr     r16
1546:   sts     0x008e, r16
154a:   rjmp    Label287

; Referenced from offset 0x152a by rjmp
; Referenced from offset 0x153e by rjmp
; Referenced from offset 0x1542 by rjmp
; Referenced from offset 0x154a by rjmp
Label287:
154c:   sbic    PINB, 3         ; 0x08 = 8
154e:   cbi     PORTD, 7        ; 0x80 = 128
1550:   cli
1552:   sbis    PINB, 0         ; 0x01 = 1
1554:   rjmp    FinishLoopWithoutSleeping
1556:   lds     r16, 0x0068
155a:   andi    r16, 0x12       ; 18
155c:   brne    FinishLoopWithoutSleeping
155e:   cpi     r23, 0x00       ; 0
1560:   brne    FinishLoopWithoutSleeping
1562:   cpi     r24, 0x00       ; 0
1564:   brne    FinishLoopWithoutSleeping
1566:   cpi     r25, 0x00       ; 0
1568:   brne    FinishLoopWithoutSleeping
156a:   mov     r16, r9
156c:   cpi     r16, 0x00       ; 0
156e:   brne    FinishLoopWithoutSleeping
1570:   mov     r16, r22
1572:   andi    r16, 0x86       ; 134
1574:   brne    FinishLoopWithoutSleeping
1576:   lds     r16, 0x0065
157a:   cpi     r16, 0x00       ; 0
157c:   brne    FinishLoopWithoutSleeping
157e:   lds     r16, 0x006d
1582:   andi    r16, 0x01       ; 1
1584:   brne    FinishLoopWithoutSleeping
1586:   lds     r16, 0x00f4
158a:   andi    r16, 0x0f       ; 15
158c:   brne    FinishLoopWithoutSleeping
158e:   lds     r16, 0x00f3
1592:   andi    r16, 0x80       ; 128
1594:   brne    FinishLoopWithoutSleeping
1596:   lds     r16, 0x008c
159a:   andi    r16, 0x0f       ; 15
159c:   brne    FinishLoopWithoutSleeping
159e:   sbic    PINB, 3         ; 0x08 = 8
15a0:   rjmp    SleepEnable_PowerDown
15a2:   cbi     ADCSR, 7        ; 0x80 = 128
15a4:   cbi     SPCR, 6         ; 0x40 = 64
15a6:   ldi     r16, 0x40       ; 64
15a8:   out     MCUCR, r16
15aa:   sei
15ac:   sleep
15ae:   rjmp    MainLoop_Start

; Referenced from offset 0x1554 by rjmp
; Referenced from offset 0x155c by brne
; Referenced from offset 0x1560 by brne
; Referenced from offset 0x1564 by brne
; Referenced from offset 0x1568 by brne
; Referenced from offset 0x156e by brne
; Referenced from offset 0x1574 by brne
; Referenced from offset 0x157c by brne
; Referenced from offset 0x1584 by brne
; Referenced from offset 0x158c by brne
; Referenced from offset 0x1594 by brne
; Referenced from offset 0x159c by brne
; Referenced from offset 0x15ba by brne
FinishLoopWithoutSleeping:
15b0:   sei
15b2:   rjmp    MainLoop_Start

; Referenced from offset 0x15a0 by rjmp
SleepEnable_PowerDown:
15b4:   lds     r16, 0x008e
15b8:   andi    r16, 0x03       ; 3
15ba:   brne    FinishLoopWithoutSleeping
15bc:   cbi     ADCSR, 7        ; 0x80 = 128
15be:   cbi     SPCR, 6         ; 0x40 = 64
15c0:   cbi     PORTC, 3        ; 0x08 = 8
15c2:   cbi     UCR, 4          ; 0x10 = 16
15c4:   cbi     UCR, 3          ; 0x08 = 8
15c6:   cbi     PORTD, 0        ; 0x01 = 1
15c8:   cbi     PORTD, 1        ; 0x02 = 2
15ca:   cbi     DDRD, 0         ; 0x01 = 1
15cc:   cbi     DDRD, 1         ; 0x02 = 2
15ce:   cbi     PORTB, 5        ; 0x20 = 32
15d0:   cbi     PORTB, 7        ; 0x80 = 128
15d2:   cbi     PORTD, 7        ; 0x80 = 128
15d4:   cbi     PORTC, 4        ; 0x10 = 16
15d6:   ldi     r16, 0x60       ; 96
15d8:   out     MCUCR, r16
15da:   sei
15dc:   sleep
15de:   nop
15e0:   nop
15e2:   nop
15e4:   sbi     DDRD, 1         ; 0x02 = 2
15e6:   sbi     UCR, 4          ; 0x10 = 16
15e8:   sbi     UCR, 3          ; 0x08 = 8
15ea:   sbi     PORTC, 3        ; 0x08 = 8
15ec:   sbi     SPCR, 6         ; 0x40 = 64
15ee:   clr     r16
15f0:   clr     r7
15f2:   sts     0x00b6, r16
15f6:   sts     0x00b7, r16
15fa:   sts     0x00b8, r16
15fe:   sts     0x00ff, r16
1602:   rjmp    MainLoop_Start

; Referenced from offset 0xbbe by rcall
; Referenced from offset 0xbea by rcall
Function1:
1604:   ser     r16

; Referenced from offset 0x1608 by brne
Label290:
1606:   dec     r16
1608:   brne    Label290
160a:   ret


; Referenced from offset 0x9a0 by rcall
; Referenced from offset 0x9a4 by rcall
; Referenced from offset 0x9a8 by rcall
Function2:
160c:   swap    r16
160e:   ldi     r17, 0x0f       ; 15
1610:   and     r17, r16
1612:   cpi     r17, 0x0a       ; 10
1614:   brcc    Label291
1616:   ldi     r18, 0x30       ; 48
1618:   rjmp    Label292

; Referenced from offset 0x1614 by brcc
Label291:
161a:   ldi     r18, 0x37       ; 55

; Referenced from offset 0x1618 by rjmp
Label292:
161c:   add     r17, r18
161e:   st      Y+, r17
1620:   swap    r16
1622:   andi    r16, 0x0f       ; 15
1624:   cpi     r16, 0x0a       ; 10
1626:   brcc    Label293
1628:   ldi     r18, 0x30       ; 48
162a:   rjmp    Label294

; Referenced from offset 0x1626 by brcc
Label293:
162c:   ldi     r18, 0x37       ; 55

; Referenced from offset 0x162a by rjmp
Label294:
162e:   add     r16, r18
1630:   st      Y+, r16
1632:   ret


; Referenced from offset 0x8fe by rcall
Function3:
1634:   ldi     r16, 0x02       ; 2
1636:   st      Y+, r16
1638:   mov     r17, r9
163a:   sbrc    r17, 6          ; 0x40 = 64
163c:   rjmp    Label295
163e:   ori     r17, 0x80       ; 128
1640:   mov     r9, r17
1642:   ldi     r16, 0x34       ; 52
1644:   mov     r17, r16
1646:   st      Y+, r16
1648:   lds     r16, 0x0060
164c:   add     r17, r16
164e:   st      Y+, r16
1650:   lds     r16, 0x0061
1654:   add     r17, r16
1656:   st      Y+, r16
1658:   lds     r16, 0x0062
165c:   add     r17, r16
165e:   st      Y+, r16
1660:   lds     r16, 0x0063
1664:   add     r17, r16
1666:   st      Y+, r16
1668:   st      Y+, r17
166a:   ret


; Referenced from offset 0x163c by rjmp
Label295:
166c:   ldi     r16, 0x30       ; 48
166e:   st      Y+, r16
1670:   st      Y+, r16
1672:   clr     r17
1674:   mov     r9, r17
1676:   in      r16, GIMSK
1678:   ori     r16, 0x80       ; 128
167a:   out     GIMSK, r16
167c:   ldi     r16, 0x80       ; 128
167e:   out     GIFR, r16
1680:   ret


; Referenced from offset 0x92a by rcall
Function4:
1682:   ldi     r16, 0x02       ; 2
1684:   st      Y+, r16
1686:   ldi     r16, 0x21       ; 33
1688:   mov     r17, r16
168a:   st      Y+, r16
168c:   lds     r16, 0x0068
1690:   andi    r16, 0xb7       ; 183
1692:   lds     r18, 0x006b
1696:   add     r17, r18
1698:   st      Y+, r18
169a:   st      Y+, r17
169c:   sts     0x0068, r16
16a0:   ret


; Referenced from offset 0x16a4 by rjmp
; Referenced from offset 0x171e by rcall
Function5:
16a2:   sbic    EECR, 1         ; 0x02 = 2
16a4:   rjmp    Function5
16a6:   clr     r29
16a8:   ldi     r28, 0xd5       ; 213
16aa:   lds     r17, 0x00d4
16ae:   lsl     r17
16b0:   st      Y+, r17
16b2:   lds     r17, 0x00d4
16b6:   clr     r16
16b8:   out     EEARH, r16
16ba:   lds     r16, 0x00d3

; Referenced from offset 0x16d6 by rjmp
Label296:
16be:   out     EEAR, r16
16c0:   sbi     EECR, 0         ; 0x01 = 1
16c2:   in      r18, EEDR
16c4:   st      Y+, r18
16c6:   inc     r16
16c8:   out     EEAR, r16
16ca:   sbi     EECR, 0         ; 0x01 = 1
16cc:   in      r18, EEDR
16ce:   st      Y+, r18
16d0:   dec     r17
16d2:   breq    Label297
16d4:   inc     r16
16d6:   rjmp    Label296

; Referenced from offset 0x16d2 by breq
Label297:
16d8:   ret


; Referenced from offset 0x16dc by rjmp
; Referenced from offset 0x1750 by rcall
Function6:
16da:   sbic    EECR, 1         ; 0x02 = 2
16dc:   rjmp    Function6
16de:   lds     r17, 0x00d4
16e2:   clr     r29
16e4:   ldi     r28, 0xd5       ; 213
16e6:   clr     r16
16e8:   out     EEARH, r16
16ea:   lds     r16, 0x00d3

; Referenced from offset 0x1706 by rjmp
Label298:
16ee:   out     EEAR, r16
16f0:   ld      r18, Y+
16f2:   out     EEDR, r18
16f4:   cli
16f6:   sbi     EECR, 2         ; 0x04 = 4
16f8:   sbi     EECR, 1         ; 0x02 = 2
16fa:   sei

; Referenced from offset 0x16fe by rjmp
Label299:
16fc:   sbic    EECR, 1         ; 0x02 = 2
16fe:   rjmp    Label299
1700:   dec     r17
1702:   breq    Label300
1704:   inc     r16
1706:   rjmp    Label298

; Referenced from offset 0x1702 by breq
Label300:
1708:   ret


; Referenced from offset 0x14e4 by rcall
RX_Handler_MSG_EEPROM_READ:
170a:   lds     r28, 0x00ef
170e:   clr     r29
1710:   ld      r16, Y+
1712:   lsl     r16
1714:   sts     0x00d3, r16
1718:   ld      r16, Y+
171a:   sts     0x00d4, r16
171e:   rcall   Function5
1720:   ori     r23, 0x08       ; 8
1722:   lds     r16, 0x0065
1726:   andi    r16, 0xbf       ; 191
1728:   sts     0x0065, r16
172c:   ret


; Referenced from offset 0x14ec by rcall
RX_Handler_MSG_EEPROM_WRITE:
172e:   ldi     r26, 0xd5       ; 213
1730:   clr     r27
1732:   ldi     r28, 0xde       ; 222
1734:   clr     r29
1736:   ld      r16, Y+
1738:   andi    r16, 0x0f       ; 15
173a:   dec     r16
173c:   sts     0x00d4, r16
1740:   ld      r17, Y+
1742:   lsl     r17
1744:   sts     0x00d3, r17

; Referenced from offset 0x174e by brne
Label301:
1748:   ld      r17, Y+
174a:   st      X+, r17
174c:   dec     r16
174e:   brne    Label301
1750:   rcall   Function6
1752:   lds     r16, 0x0067
1756:   ori     r16, 0x04       ; 4
1758:   sts     0x0067, r16
175c:   ori     r23, 0x80       ; 128
175e:   lds     r16, 0x0065
1762:   andi    r16, 0xbf       ; 191
1764:   sts     0x0065, r16
1768:   ret


; Referenced from offset 0x14dc by rcall
RX_Handler_MSG_VERSION:
176a:   lds     r16, 0x00f4
176e:   ori     r16, 0x04       ; 4
1770:   sts     0x00f4, r16
1774:   lds     r16, 0x00ff
1778:   andi    r16, 0x7f       ; 127
177a:   sts     0x00ff, r16
177e:   ori     r23, 0x10       ; 16
1780:   lds     r16, 0x0065
1784:   andi    r16, 0xbf       ; 191
1786:   sts     0x0065, r16
178a:   andi    r22, 0xfe       ; 254
178c:   andi    r22, 0xf7       ; 247
178e:   ret


; Referenced from offset 0x14f4 by rcall
RX_Handler_MSG_NOTIFY_LED:
1790:   lds     r28, 0x00ef
1794:   clr     r29
1796:   ld      r16, Y+
1798:   sbrc    r16, 0          ; 0x01 = 1
179a:   rjmp    Label302
179c:   clr     r16
179e:   sts     0x006d, r16
17a2:   sbi     PORTB, 4        ; 0x10 = 16
17a4:   lds     r16, 0x0067
17a8:   ori     r16, 0x02       ; 2
17aa:   sts     0x0067, r16
17ae:   ori     r23, 0x80       ; 128
17b0:   lds     r16, 0x0065
17b4:   andi    r16, 0xbf       ; 191
17b6:   sts     0x0065, r16
17ba:   ret


; Referenced from offset 0x179a by rjmp
Label302:
17bc:   ld      r16, Y+
17be:   cpi     r16, 0x00       ; 0
17c0:   brne    Label303
17c2:   lds     r17, 0x006d
17c6:   ori     r17, 0x04       ; 4
17c8:   sts     0x006d, r17

; Referenced from offset 0x17c0 by brne
Label303:
17cc:   sts     0x006e, r16
17d0:   ld      r16, Y+
17d2:   sts     0x006f, r16
17d6:   sts     0x0074, r16
17da:   ld      r16, Y+
17dc:   sts     0x0070, r16
17e0:   ldi     r16, 0x64       ; 100
17e2:   sts     0x0071, r16
17e6:   ldi     r16, 0x32       ; 50
17e8:   sts     0x0072, r16
17ec:   ldi     r16, 0x0c       ; 12
17ee:   sts     0x0073, r16
17f2:   lds     r16, 0x006d
17f6:   ori     r16, 0x01       ; 1
17f8:   sts     0x006d, r16
17fc:   sbi     PORTC, 6        ; 0x40 = 64
17fe:   cbi     PORTB, 4        ; 0x10 = 16
1800:   lds     r16, 0x0067
1804:   ori     r16, 0x02       ; 2
1806:   sts     0x0067, r16
180a:   ori     r23, 0x80       ; 128
180c:   lds     r16, 0x0065
1810:   andi    r16, 0xbf       ; 191
1812:   sts     0x0065, r16
1816:   ret


; Referenced from offset 0x14fc by rcall
RX_Handler_MSG_BATTERY:
1818:   ori     r23, 0x40       ; 64
181a:   lds     r16, 0x0065
181e:   andi    r16, 0xbf       ; 191
1820:   sts     0x0065, r16
1824:   ret


; Referenced from offset 0x1504 by rcall
RX_Handler_MSG_BACKLIGHT:
1826:   lds     r28, 0x00ef
182a:   clr     r29
182c:   ld      r16, Y+
182e:   cpi     r16, 0x03       ; 3
1830:   brne    Label304
1832:   ori     r23, 0x20       ; 32
1834:   rjmp    Label309

; Referenced from offset 0x1830 by brne
Label304:
1836:   lds     r17, 0x008e
183a:   cpi     r16, 0x01       ; 1
183c:   brne    Label305
183e:   sbrc    r17, 1          ; 0x02 = 2
1840:   rjmp    Label306
1842:   ldi     r16, 0xfa       ; 250
1844:   sts     0x00f2, r16
1848:   clr     r16
184a:   sts     0x008f, r16
184e:   andi    r17, 0xfb       ; 251
1850:   ori     r17, 0x02       ; 2
1852:   rjmp    Label306

; Referenced from offset 0x183c by brne
Label305:
1854:   andi    r17, 0xfd       ; 253

; Referenced from offset 0x1840 by rjmp
; Referenced from offset 0x1852 by rjmp
Label306:
1856:   ld      r16, Y+
1858:   cpi     r16, 0x00       ; 0
185a:   brne    Label307
185c:   andi    r17, 0xfe       ; 254
185e:   sts     0x008e, r17
1862:   cbi     PORTC, 7        ; 0x80 = 128
1864:   clr     r16
1866:   out     TCCR1B, r16
1868:   rjmp    Label308

; Referenced from offset 0x185a by brne
Label307:
186a:   ld      r18, Y+
186c:   out     OCR1BL, r18
186e:   sts     0x008e, r17
1872:   sbrc    r17, 0          ; 0x01 = 1
1874:   rjmp    Label308
1876:   ldi     r16, 0x21       ; 33
1878:   out     TCCR1A, r16
187a:   ldi     r16, 0x01       ; 1
187c:   out     TCCR1B, r16
187e:   sbi     PORTC, 7        ; 0x80 = 128
1880:   ori     r17, 0x01       ; 1
1882:   sts     0x008e, r17

; Referenced from offset 0x1868 by rjmp
; Referenced from offset 0x1874 by rjmp
Label308:
1886:   lds     r16, 0x0067
188a:   ori     r16, 0x01       ; 1
188c:   sts     0x0067, r16
1890:   ori     r23, 0x80       ; 128

; Referenced from offset 0x1834 by rjmp
Label309:
1892:   lds     r16, 0x0065
1896:   andi    r16, 0xbf       ; 191
1898:   sts     0x0065, r16
189c:   ret


; Referenced from offset 0xd3e by rcall
; Referenced from offset 0xf04 by rcall
Function13:
189e:   cli
18a0:   lds     r16, 0x007c
18a4:   lds     r17, 0x007b
18a8:   sei
18aa:   ldi     r18, 0xee       ; 238
18ac:   sub     r16, r18
18ae:   brcc    Label310
18b0:   ldi     r18, 0x02       ; 2
18b2:   inc     r18
18b4:   rjmp    Label311

; Referenced from offset 0x18ae by brcc
Label310:
18b6:   ldi     r18, 0x02       ; 2

; Referenced from offset 0x18b4 by rjmp
Label311:
18b8:   sub     r17, r18
18ba:   brcc    Label312
18bc:   sbi     PORTA, 0        ; 0x01 = 1
18be:   ret


; Referenced from offset 0x18ba by brcc
Label312:
18c0:   cbi     PORTA, 0        ; 0x01 = 1
18c2:   ret


; Referenced from offset 0x150c by rcall
RX_Handler_MSG_SPI_READ:
18c4:   lds     r16, 0x00f4
18c8:   sbrc    r16, 0          ; 0x01 = 1
18ca:   rjmp    Label315
18cc:   lds     r16, 0x00f5
18d0:   sbrc    r16, 0          ; 0x01 = 1
18d2:   rjmp    Label315
18d4:   lds     r28, 0x00ef
18d8:   clr     r29
18da:   ld      r16, Y+
18dc:   cpi     r16, 0xff       ; 255
18de:   brne    Label313
18e0:   ld      r17, Y+
18e2:   dec     r28
18e4:   cpi     r17, 0xff       ; 255
18e6:   brne    Label313
18e8:   clr     r16
18ea:   rjmp    Label314

; Referenced from offset 0x18de by brne
; Referenced from offset 0x18e6 by brne
Label313:
18ec:   sts     0x00f9, r16
18f0:   ld      r16, Y+
18f2:   sts     0x00fa, r16
18f6:   ld      r16, Y+

; Referenced from offset 0x18ea by rjmp
Label314:
18f8:   sts     0x00fb, r16
18fc:   lds     r16, 0x00f4
1900:   ori     r16, 0x01       ; 1
1902:   sts     0x00f4, r16
1906:   lds     r16, 0x0065
190a:   andi    r16, 0xbf       ; 191
190c:   sts     0x0065, r16

; Referenced from offset 0x18ca by rjmp
; Referenced from offset 0x18d2 by rjmp
Label315:
1910:   ret


; Referenced from offset 0x1514 by rcall
RX_Handler_MSG_SPI_WRITE:
1912:   lds     r16, 0x00f4
1916:   sbrc    r16, 1          ; 0x02 = 2
1918:   rjmp    Label318
191a:   lds     r16, 0x00f5
191e:   sbrc    r16, 1          ; 0x02 = 2
1920:   rjmp    Label318
1922:   ldi     r26, 0x13       ; 19
1924:   ldi     r27, 0x01       ; 1
1926:   ldi     r28, 0xde       ; 222
1928:   clr     r29
192a:   ld      r16, Y+
192c:   andi    r16, 0x0f       ; 15
192e:   subi    r16, 0x02       ; 2
1930:   st      X+, r16
1932:   ld      r17, Y+
1934:   cpi     r17, 0xff       ; 255
1936:   brne    Label316
1938:   ld      r18, Y+
193a:   dec     r28
193c:   cpi     r18, 0xff       ; 255
193e:   brne    Label316
1940:   dec     r26
1942:   clr     r16
1944:   st      X+, r16
1946:   inc     r16
1948:   inc     r28
194a:   rjmp    Label317

; Referenced from offset 0x1936 by brne
; Referenced from offset 0x193e by brne
Label316:
194c:   st      X+, r17
194e:   ld      r17, Y+
1950:   st      X+, r17

; Referenced from offset 0x194a by rjmp
; Referenced from offset 0x1958 by brne
Label317:
1952:   ld      r17, Y+
1954:   st      X+, r17
1956:   dec     r16
1958:   brne    Label317
195a:   lds     r16, 0x00f4
195e:   ori     r16, 0x02       ; 2
1960:   sts     0x00f4, r16
1964:   lds     r16, 0x0065
1968:   andi    r16, 0xbf       ; 191
196a:   sts     0x0065, r16

; Referenced from offset 0x1918 by rjmp
; Referenced from offset 0x1920 by rjmp
Label318:
196e:   ret


; Referenced from offset 0x151c by rcall
RX_Handler_MSG_THERMAL_SENSOR:
1970:   lds     r16, 0x0075
1974:   sbrs    r16, 0          ; 0x01 = 1
1976:   rjmp    Label319
1978:   ori     r22, 0x04       ; 4
197a:   rjmp    Label320

; Referenced from offset 0x1976 by rjmp
Label319:
197c:   lds     r16, 0x00bb
1980:   ori     r16, 0x01       ; 1
1982:   sts     0x00bb, r16
1986:   ori     r25, 0x40       ; 64

; Referenced from offset 0x197a by rjmp
Label320:
1988:   lds     r16, 0x0065
198c:   andi    r16, 0xbf       ; 191
198e:   sts     0x0065, r16
1992:   ret

1994:   nop
1996:   nop
1998:   nop
199a:   nop
199c:   nop
199e:   nop
19a0:   nop
19a2:   nop
19a4:   nop
19a6:   nop
19a8:   nop
19aa:   nop
19ac:   nop
19ae:   nop
19b0:   nop
19b2:   nop
19b4:   nop
19b6:   nop
19b8:   nop
19ba:   nop
19bc:   nop
19be:   nop
19c0:   nop
19c2:   nop
19c4:   nop
19c6:   nop
19c8:   nop
19ca:   nop
19cc:   nop
19ce:   nop
19d0:   nop
19d2:   nop
19d4:   nop
19d6:   nop
19d8:   nop
19da:   nop
19dc:   nop
19de:   nop
19e0:   nop
19e2:   nop
19e4:   nop
19e6:   nop
19e8:   nop
19ea:   nop
19ec:   nop
19ee:   nop
19f0:   nop
19f2:   nop
19f4:   nop
19f6:   nop
19f8:   nop
19fa:   nop
19fc:   nop
19fe:   nop
1a00:   nop
1a02:   nop
1a04:   nop
1a06:   nop
1a08:   nop
1a0a:   nop
1a0c:   nop
1a0e:   nop
1a10:   nop
1a12:   nop
1a14:   nop
1a16:   nop
1a18:   nop
1a1a:   nop
1a1c:   nop
1a1e:   nop
1a20:   nop
1a22:   nop
1a24:   nop
1a26:   nop
1a28:   nop
1a2a:   nop
1a2c:   nop
1a2e:   nop
1a30:   nop
1a32:   nop
1a34:   nop
1a36:   nop
1a38:   nop
1a3a:   nop
1a3c:   nop
1a3e:   nop
1a40:   nop
1a42:   nop
1a44:   nop
1a46:   nop
1a48:   nop
1a4a:   nop
1a4c:   nop
1a4e:   nop
1a50:   nop
1a52:   nop
1a54:   nop
1a56:   nop
1a58:   nop
1a5a:   nop
1a5c:   nop
1a5e:   nop
1a60:   nop
1a62:   nop
1a64:   nop
1a66:   nop
1a68:   nop
1a6a:   nop
1a6c:   nop
1a6e:   nop
1a70:   nop
1a72:   nop
1a74:   nop
1a76:   nop
1a78:   nop
1a7a:   nop
1a7c:   nop
1a7e:   nop
1a80:   nop
1a82:   nop
1a84:   nop
1a86:   nop
1a88:   nop
1a8a:   nop
1a8c:   nop
1a8e:   nop
1a90:   nop
1a92:   nop
1a94:   nop
1a96:   nop
1a98:   nop
1a9a:   nop
1a9c:   nop
1a9e:   nop
1aa0:   nop
1aa2:   nop
1aa4:   nop
1aa6:   nop
1aa8:   nop
1aaa:   nop
1aac:   nop
1aae:   nop
1ab0:   nop
1ab2:   nop
1ab4:   nop
1ab6:   nop
1ab8:   nop
1aba:   nop
1abc:   nop
1abe:   nop
1ac0:   nop
1ac2:   nop
1ac4:   nop
1ac6:   nop
1ac8:   nop
1aca:   nop
1acc:   nop
1ace:   nop
1ad0:   nop
1ad2:   nop
1ad4:   nop
1ad6:   nop
1ad8:   nop
1ada:   nop
1adc:   nop
1ade:   nop
1ae0:   nop
1ae2:   nop
1ae4:   nop
1ae6:   nop
1ae8:   nop
1aea:   nop
1aec:   nop
1aee:   nop
1af0:   nop
1af2:   nop
1af4:   nop
1af6:   nop
1af8:   nop
1afa:   nop
1afc:   nop
1afe:   nop
1b00:   nop
1b02:   nop
1b04:   nop
1b06:   nop
1b08:   nop
1b0a:   nop
1b0c:   nop
1b0e:   nop
1b10:   nop
1b12:   nop
1b14:   nop
1b16:   nop
1b18:   nop
1b1a:   nop
1b1c:   nop
1b1e:   nop
1b20:   nop
1b22:   nop
1b24:   nop
1b26:   nop
1b28:   nop
1b2a:   nop
1b2c:   nop
1b2e:   nop
1b30:   nop
1b32:   nop
1b34:   nop
1b36:   nop
1b38:   nop
1b3a:   nop
1b3c:   nop
1b3e:   nop
1b40:   nop
1b42:   nop
1b44:   nop
1b46:   nop
1b48:   nop
1b4a:   nop
1b4c:   nop
1b4e:   nop
1b50:   nop
1b52:   nop
1b54:   nop
1b56:   nop
1b58:   nop
1b5a:   nop
1b5c:   nop
1b5e:   nop
1b60:   nop
1b62:   nop
1b64:   nop
1b66:   nop
1b68:   nop
1b6a:   nop
1b6c:   nop
1b6e:   nop
1b70:   nop
1b72:   nop
1b74:   nop
1b76:   nop
1b78:   nop
1b7a:   nop
1b7c:   nop
1b7e:   nop
1b80:   nop
1b82:   nop
1b84:   nop
1b86:   nop
1b88:   nop
1b8a:   nop
1b8c:   nop
1b8e:   nop
1b90:   nop
1b92:   nop
1b94:   nop
1b96:   nop
1b98:   nop
1b9a:   nop
1b9c:   nop
1b9e:   nop
1ba0:   nop
1ba2:   nop
1ba4:   nop
1ba6:   nop
1ba8:   nop
1baa:   nop
1bac:   nop
1bae:   nop
1bb0:   nop
1bb2:   nop
1bb4:   nop
1bb6:   nop
1bb8:   nop
1bba:   nop
1bbc:   nop
1bbe:   nop
1bc0:   nop
1bc2:   nop
1bc4:   nop
1bc6:   nop
1bc8:   nop
1bca:   nop
1bcc:   nop
1bce:   nop
1bd0:   nop
1bd2:   nop
1bd4:   nop
1bd6:   nop
1bd8:   nop
1bda:   nop
1bdc:   nop
1bde:   nop
1be0:   nop
1be2:   nop
1be4:   nop
1be6:   nop
1be8:   nop
1bea:   nop
1bec:   nop
1bee:   nop
1bf0:   nop
1bf2:   nop
1bf4:   nop
1bf6:   nop
1bf8:   nop
1bfa:   nop
1bfc:   nop
1bfe:   nop
1c00:   nop
1c02:   nop
1c04:   nop
1c06:   nop
1c08:   nop
1c0a:   nop
1c0c:   nop
1c0e:   nop
1c10:   nop
1c12:   nop
1c14:   nop
1c16:   nop
1c18:   nop
1c1a:   nop
1c1c:   nop
1c1e:   nop
1c20:   nop
1c22:   nop
1c24:   nop
1c26:   nop
1c28:   nop
1c2a:   nop
1c2c:   nop
1c2e:   nop
1c30:   nop
1c32:   nop
1c34:   nop
1c36:   nop
1c38:   nop
1c3a:   nop
1c3c:   nop
1c3e:   nop
1c40:   nop
1c42:   nop
1c44:   nop
1c46:   nop
1c48:   nop
1c4a:   nop
1c4c:   nop
1c4e:   nop
1c50:   nop
1c52:   nop
1c54:   nop
1c56:   nop
1c58:   nop
1c5a:   nop
1c5c:   nop
1c5e:   nop
1c60:   nop
1c62:   nop
1c64:   nop
1c66:   nop
1c68:   nop
1c6a:   nop
1c6c:   nop
1c6e:   nop
1c70:   nop
1c72:   nop
1c74:   nop
1c76:   nop
1c78:   nop
1c7a:   nop
1c7c:   nop
1c7e:   nop
1c80:   nop
1c82:   nop
1c84:   nop
1c86:   nop
1c88:   nop
1c8a:   nop
1c8c:   nop
1c8e:   nop
1c90:   nop
1c92:   nop
1c94:   nop
1c96:   nop
1c98:   nop
1c9a:   nop
1c9c:   nop
1c9e:   nop
1ca0:   nop
1ca2:   nop
1ca4:   nop
1ca6:   nop
1ca8:   nop
1caa:   nop
1cac:   nop
1cae:   nop
1cb0:   nop
1cb2:   nop
1cb4:   nop
1cb6:   nop
1cb8:   nop
1cba:   nop
1cbc:   nop
1cbe:   nop
1cc0:   nop
1cc2:   nop
1cc4:   nop
1cc6:   nop
1cc8:   nop
1cca:   nop
1ccc:   nop
1cce:   nop
1cd0:   nop
1cd2:   nop
1cd4:   nop
1cd6:   nop
1cd8:   nop
1cda:   nop
1cdc:   nop
1cde:   nop
1ce0:   nop
1ce2:   nop
1ce4:   nop
1ce6:   nop
1ce8:   nop
1cea:   nop
1cec:   nop
1cee:   nop
1cf0:   nop
1cf2:   nop
1cf4:   nop
1cf6:   nop
1cf8:   nop
1cfa:   nop
1cfc:   nop
1cfe:   nop
1d00:   nop
1d02:   nop
1d04:   nop
1d06:   nop
1d08:   nop
1d0a:   nop
1d0c:   nop
1d0e:   nop
1d10:   nop
1d12:   nop
1d14:   nop
1d16:   nop
1d18:   nop
1d1a:   nop
1d1c:   nop
1d1e:   nop
1d20:   nop
1d22:   nop
1d24:   nop
1d26:   nop
1d28:   nop
1d2a:   nop
1d2c:   nop
1d2e:   nop
1d30:   nop
1d32:   nop
1d34:   nop
1d36:   nop
1d38:   nop
1d3a:   nop
1d3c:   nop
1d3e:   nop
1d40:   nop
1d42:   nop
1d44:   nop
1d46:   nop
1d48:   nop
1d4a:   nop
1d4c:   nop
1d4e:   nop
1d50:   nop
1d52:   nop
1d54:   nop
1d56:   nop
1d58:   nop
1d5a:   nop
1d5c:   nop
1d5e:   nop
1d60:   nop
1d62:   nop
1d64:   nop
1d66:   nop
1d68:   nop
1d6a:   nop
1d6c:   nop
1d6e:   nop
1d70:   nop
1d72:   nop
1d74:   nop
1d76:   nop
1d78:   nop
1d7a:   nop
1d7c:   nop
1d7e:   nop
1d80:   nop
1d82:   nop
1d84:   nop
1d86:   nop
1d88:   nop
1d8a:   nop
1d8c:   nop
1d8e:   nop
1d90:   nop
1d92:   nop
1d94:   nop
1d96:   nop
1d98:   nop
1d9a:   nop
1d9c:   nop
1d9e:   nop
1da0:   nop
1da2:   nop
1da4:   nop
1da6:   nop
1da8:   nop
1daa:   nop
1dac:   nop
1dae:   nop
1db0:   nop
1db2:   nop
1db4:   nop
1db6:   nop
1db8:   nop
1dba:   nop
1dbc:   nop
1dbe:   nop
1dc0:   nop
1dc2:   nop
1dc4:   nop
1dc6:   nop
1dc8:   nop
1dca:   nop
1dcc:   nop
1dce:   nop
1dd0:   nop
1dd2:   nop
1dd4:   nop
1dd6:   nop
1dd8:   nop
1dda:   nop
1ddc:   nop
1dde:   nop
1de0:   nop
1de2:   nop
1de4:   nop
1de6:   nop
1de8:   nop
1dea:   nop
1dec:   nop
1dee:   nop
1df0:   nop
1df2:   nop
1df4:   nop
1df6:   nop
1df8:   nop
1dfa:   nop
1dfc:   nop
1dfe:   nop
1e00:   nop
1e02:   nop
1e04:   nop
1e06:   nop
1e08:   nop
1e0a:   nop
1e0c:   nop
1e0e:   nop
1e10:   nop
1e12:   nop
1e14:   nop
1e16:   nop
1e18:   nop
1e1a:   nop
1e1c:   nop
1e1e:   nop
1e20:   nop
1e22:   nop
1e24:   nop
1e26:   nop
1e28:   nop
1e2a:   nop
1e2c:   nop
1e2e:   nop
1e30:   nop
1e32:   nop
1e34:   nop
1e36:   nop
1e38:   nop
1e3a:   nop
1e3c:   nop
1e3e:   nop
1e40:   nop
1e42:   nop
1e44:   nop
1e46:   nop
1e48:   nop
1e4a:   nop
1e4c:   nop
1e4e:   nop
1e50:   nop
1e52:   nop
1e54:   nop
1e56:   nop
1e58:   nop
1e5a:   nop
1e5c:   nop
1e5e:   nop
1e60:   nop
1e62:   nop
1e64:   nop
1e66:   nop
1e68:   nop
1e6a:   nop
1e6c:   nop
1e6e:   nop
1e70:   nop
1e72:   nop
1e74:   nop
1e76:   nop
1e78:   nop
1e7a:   nop
1e7c:   nop
1e7e:   nop
1e80:   nop
1e82:   nop
1e84:   nop
1e86:   nop
1e88:   nop
1e8a:   nop
1e8c:   nop
1e8e:   nop
1e90:   nop
1e92:   nop
1e94:   nop
1e96:   nop
1e98:   nop
1e9a:   nop
1e9c:   nop
1e9e:   nop
1ea0:   nop
1ea2:   nop
1ea4:   nop
1ea6:   nop
1ea8:   nop
1eaa:   nop
1eac:   nop
1eae:   nop
1eb0:   nop
1eb2:   nop
1eb4:   nop
1eb6:   nop
1eb8:   nop
1eba:   nop
1ebc:   nop
1ebe:   nop
1ec0:   nop
1ec2:   nop
1ec4:   nop
1ec6:   nop
1ec8:   nop
1eca:   nop
1ecc:   nop
1ece:   nop
1ed0:   nop
1ed2:   nop
1ed4:   nop
1ed6:   nop
1ed8:   nop
1eda:   nop
1edc:   nop
1ede:   nop
1ee0:   nop
1ee2:   nop
1ee4:   nop
1ee6:   nop
1ee8:   nop
1eea:   nop
1eec:   nop
1eee:   nop
1ef0:   nop
1ef2:   nop
1ef4:   nop
1ef6:   nop
1ef8:   nop
1efa:   nop
1efc:   nop
1efe:   nop
1f00:   nop
1f02:   nop
1f04:   nop
1f06:   nop
1f08:   nop
1f0a:   nop
1f0c:   nop
1f0e:   nop
1f10:   nop
1f12:   nop
1f14:   nop
1f16:   nop
1f18:   nop
1f1a:   nop
1f1c:   nop
1f1e:   nop
1f20:   nop
1f22:   nop
1f24:   nop
1f26:   nop
1f28:   nop
1f2a:   nop
1f2c:   nop
1f2e:   nop
1f30:   nop
1f32:   nop
1f34:   nop
1f36:   nop
1f38:   nop
1f3a:   nop
1f3c:   nop
1f3e:   nop
1f40:   nop
1f42:   nop
1f44:   nop
1f46:   nop
1f48:   nop
1f4a:   nop
1f4c:   nop
1f4e:   nop
1f50:   nop
1f52:   nop
1f54:   nop
1f56:   nop
1f58:   nop
1f5a:   nop
1f5c:   nop
1f5e:   nop
1f60:   nop
1f62:   nop
1f64:   nop
1f66:   nop
1f68:   nop
1f6a:   nop
1f6c:   nop
1f6e:   nop
1f70:   nop
1f72:   nop
1f74:   nop
1f76:   nop
1f78:   nop
1f7a:   nop
1f7c:   nop
1f7e:   nop
1f80:   nop
1f82:   nop
1f84:   nop
1f86:   nop
1f88:   nop
1f8a:   nop
1f8c:   nop
1f8e:   nop
1f90:   nop
1f92:   nop
1f94:   nop
1f96:   nop
1f98:   nop
1f9a:   nop
1f9c:   nop
1f9e:   nop
1fa0:   nop
1fa2:   nop
1fa4:   nop
1fa6:   nop
1fa8:   nop
1faa:   nop
1fac:   nop
1fae:   nop
1fb0:   nop
1fb2:   nop
1fb4:   nop
1fb6:   nop
1fb8:   nop
1fba:   nop
1fbc:   nop
1fbe:   nop
1fc0:   nop
1fc2:   nop
1fc4:   nop
1fc6:   nop
1fc8:   nop
1fca:   nop
1fcc:   nop
1fce:   nop
1fd0:   nop
1fd2:   nop
1fd4:   nop
1fd6:   nop
1fd8:   nop
1fda:   nop
1fdc:   nop
1fde:   nop
1fe0:   nop
1fe2:   nop
1fe4:   nop
1fe6:   nop
1fe8:   nop
1fea:   nop
1fec:   nop
1fee:   nop
1ff0:   nop
1ff2:   nop
1ff4:   nop
1ff6:   nop
1ff8:   nop
1ffa:   nop
1ffc:   nop
1ffe:   nop
